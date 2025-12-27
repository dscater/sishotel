<?php

namespace App\Services;

use App\Models\EgresoProducto;
use App\Models\IngresoProducto;
use App\Models\Producto;
use App\Models\ServicioDetalle;
use App\Models\TipoProducto;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Auth;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Log;

class ProductoService
{
    private $modulo = "PRODUCTOS";
    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}


    public function listado(string $search): array
    {
        return Producto::select("productos.*")
            ->get()
            ->toArray();
    }

    /**
     * Obtener producto oficial
     *
     * @return Producto
     */
    public function getProductoPrincipal(): Producto
    {
        return Producto::where("oficial", 1)->get()->first();
    }

    /**
     * Lista de productos paginado con filtros
     *
     * @param integer $length
     * @param integer $page
     * @param string $search
     * @param array $columnsSerachLike
     * @param array $columnsFilter
     * @return LengthAwarePaginator
     */
    public function listadoPaginado(int $length, int $page, string $search, array $columnsSerachLike = [], array $columnsFilter = [], array $columnsBetweenFilter = [], array $orderBy = []): LengthAwarePaginator
    {
        $productos = Producto::select("productos.*")
            ->with(["tipo_producto:id,nombre,tipo"]);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $productos->where("productos.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $productos->whereBetween("productos.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $productos->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("productos.$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $productos->orderBy($value[0], $value[1]);
            }
        }


        $productos = $productos->paginate($length, ['*'], 'page', $page);
        return $productos;
    }

    /**
     * Crear producto
     *
     * @param array $datos
     * @return Producto
     */
    public function crear(array $datos): Producto
    {
        $tipo_producto = TipoProducto::findOrFail($datos["tipo_producto_id"]);

        $producto = Producto::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "precio" => $datos["precio"],
            "tipo_producto_id" => $datos["tipo_producto_id"],
            "control_stock" => $tipo_producto->tipo == 'PRODUCTO' ? 1 : 0
        ]);

        // cargar imagen
        if ($datos["imagen"] && !is_string($datos["imagen"])) {
            $this->cargarFoto($producto, $datos["imagen"]);
        }


        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN PRODUCTO", $producto);

        return $producto;
    }

    /**
     * Actualizar producto
     *
     * @param array $datos
     * @param Producto $producto
     * @return Producto
     */
    public function actualizar(array $datos, Producto $producto): Producto
    {
        $tipo_producto = TipoProducto::findOrFail($datos["tipo_producto_id"]);
        $old_producto = clone $producto;
        $producto->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "precio" => $datos["precio"],
            "tipo_producto_id" => $datos["tipo_producto_id"],
            "control_stock" => $tipo_producto->tipo == 'PRODUCTO' ? 1 : 0
        ]);

        // cargar imagen
        if ($datos["imagen"] && !is_string($datos["imagen"])) {
            $this->cargarFoto($producto, $datos["imagen"]);
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ EL REGISTRO DE UN PRODUCTO", $old_producto, $producto->withoutRelations());

        return $producto;
    }

    /**
     * Cargar imagen
     *
     * @param Producto $producto
     * @param UploadedFile $imagen
     * @return void
     */
    public function cargarFoto(Producto $producto, UploadedFile $imagen): void
    {
        if ($producto->imagen) {
            \File::delete(public_path("imgs/productos/" . $producto->imagen));
        }

        $nombre = $producto->id . time();
        $producto->imagen = $this->cargarArchivoService->cargarArchivo($imagen, public_path("imgs/productos"), $nombre);
        $producto->save();
    }

    /**
     * Eliminar producto
     *
     * @param Producto $producto
     * @return boolean
     */
    public function eliminar(Producto $producto): bool
    {
        $usos = ServicioDetalle::where("producto_id", $producto->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el registro porque esta siendo utilizado.");
        }
        $usos = IngresoProducto::where("producto_id", $producto->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el registro porque esta siendo utilizado.");
        }
        $usos = EgresoProducto::where("producto_id", $producto->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el registro porque esta siendo utilizado.");
        }

        $old_producto = clone $producto;
        $producto->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UN PRODUCTO", $old_producto);
        return true;
    }


    /**
     * Incrementar el stock del producto sucursal
     *
     * @param Producto $producto
     * @param float $cantidad
     * @return App\Models\Producto
     */
    public function incrementarStock(Producto $producto, float $cantidad): Producto
    {
        $producto->stock = (float)$producto->stock + $cantidad;
        $producto->save();
        return $producto;
    }

    /**
     * Decrementar el stock de un producto sucursal
     *
     * @param Producto $producto
     * @param float $cantidad
     * @return App\Models\Producto
     */
    public function decrementarStock(Producto $producto, float $cantidad): Producto|null
    {
        $producto->stock = (float)$producto->stock - $cantidad;
        $producto->save();
        return $producto;
    }

    /**
     * Verificar el stock del producto
     *
     * @param integer $producto_id
     * @param float $cantidad
     * @return array[bool,float]
     */
    public function verificaStockProducto(int $producto_id, float $cantidad): array
    {
        $resultado = [false, 0];
        $producto = Producto::findOrFail($producto_id);
        if ($producto) {
            $stock = (float)$producto->stock;
            $resultado[1] = $stock;
            if ($stock >= $cantidad) {
                $resultado[0] = true;
            }
        }

        return $resultado;
    }
}

<?php

namespace App\Services;

use App\Models\IngresoProducto;
use App\Models\Producto;
use App\Models\TipoIngresoProducto;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Auth;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Log;

class IngresoProductoService
{
    private $modulo = "INGRESO DE PRODUCTOS";
    public function __construct(private HistorialAccionService $historialAccionService, private KardexProductoService $kardex_producto_service) {}


    public function listado(string $search): array
    {
        return IngresoProducto::select("ingreso_productos.*")
            ->get()
            ->toArray();
    }

    /**
     * Obtener ingreso_producto oficial
     *
     * @return IngresoProducto
     */
    public function getIngresoProductoPrincipal(): IngresoProducto
    {
        return IngresoProducto::where("oficial", 1)->get()->first();
    }

    /**
     * Lista de ingreso_productos paginado con filtros
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
        $ingreso_productos = IngresoProducto::select("ingreso_productos.*")
            ->with(["producto:id,nombre"]);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $ingreso_productos->where("ingreso_productos.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $ingreso_productos->whereBetween("ingreso_productos.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $ingreso_productos->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("ingreso_productos.$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $ingreso_productos->orderBy($value[0], $value[1]);
            }
        }


        $ingreso_productos = $ingreso_productos->paginate($length, ['*'], 'page', $page);
        return $ingreso_productos;
    }

    /**
     * Crear ingreso_producto
     *
     * @param array $datos
     * @return IngresoProducto
     */
    public function crear(array $datos): IngresoProducto
    {
        $ingreso_producto = IngresoProducto::create([
            "producto_id" => $datos["producto_id"],
            "cantidad" => $datos["cantidad"],
            "precio_compra" => $datos["precio_compra"],
            "total" => (float)$datos["cantidad"] * (float)$datos["precio_compra"],
            "fecha_ingreso" => date("Y-m-d"),
        ]);

        // incrementar stock
        $producto = Producto::findOrFail($datos["producto_id"]);
        $this->kardex_producto_service->registroIngreso("INGRESO DE PRODUCTO", $producto, $datos["cantidad"], $datos["precio_compra"], "INGRESO POR COMPRA", "IngresoProducto", $ingreso_producto->id);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN INGRESO DE PRODUCTO", $ingreso_producto);

        return $ingreso_producto;
    }

    /**
     * Actualizar ingreso_producto
     *
     * @param array $datos
     * @param IngresoProducto $ingreso_producto
     * @return IngresoProducto
     */
    public function actualizar(array $datos, IngresoProducto $ingreso_producto): IngresoProducto
    {
        $old_ingreso_producto = clone $ingreso_producto;

        // decrementar stock
        $producto = Producto::findOrFail($old_ingreso_producto->producto_id);
        $this->kardex_producto_service->registroEgreso("INGRESO DE PRODUCTO", $producto, $old_ingreso_producto->cantidad, $old_ingreso_producto->precio_compra, "SALIDA POR MODIFICACIÓN", "IngresoProducto", $old_ingreso_producto->id);

        $ingreso_producto->update([
            "producto_id" => $datos["producto_id"],
            "cantidad" => $datos["cantidad"],
            "precio_compra" => $datos["precio_compra"],
            "total" => (float)$datos["cantidad"] * (float)$datos["precio_compra"],
        ]);

        // incrementar stock
        $producto = Producto::findOrFail($datos["producto_id"]);
        $this->kardex_producto_service->registroIngreso("INGRESO DE PRODUCTO", $producto, $datos["cantidad"], $datos["precio_compra"], "INGRESO POR COMPRA", "IngresoProducto", $ingreso_producto->id);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ EL REGISTRO DE UN INGRESO DE PRODUCTO", $old_ingreso_producto, $ingreso_producto->withoutRelations());

        return $ingreso_producto;
    }

    /**
     * Eliminar ingreso_producto
     *
     * @param IngresoProducto $ingreso_producto
     * @return boolean
     */
    public function eliminar(IngresoProducto $ingreso_producto): bool
    {

        $old_ingreso_producto = clone $ingreso_producto;

        // decrementar stock
        $producto = Producto::findOrFail($old_ingreso_producto->producto_id);
        $this->kardex_producto_service->registroEgreso("INGRESO DE PRODUCTO", $producto, $old_ingreso_producto->cantidad, $old_ingreso_producto->precio_compra, "SALIDA POR ELIMINACIÓN DE INGRESO", "IngresoProducto", $old_ingreso_producto->id);

        $ingreso_producto->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UN INGRESO DE PRODUCTO", $old_ingreso_producto);
        return true;
    }
}

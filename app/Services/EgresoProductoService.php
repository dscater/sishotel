<?php

namespace App\Services;

use App\Models\EgresoProducto;
use App\Models\Producto;
use App\Models\TipoEgresoProducto;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Auth;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Log;

class EgresoProductoService
{
    private $modulo = "EGRESO DE PRODUCTOS";
    public function __construct(private HistorialAccionService $historialAccionService, private KardexProductoService $kardex_producto_service) {}


    public function listado(string $search): array
    {
        return EgresoProducto::select("egreso_productos.*")
            ->get()
            ->toArray();
    }

    /**
     * Obtener egreso_producto oficial
     *
     * @return EgresoProducto
     */
    public function getEgresoProductoPrincipal(): EgresoProducto
    {
        return EgresoProducto::where("oficial", 1)->get()->first();
    }

    /**
     * Lista de egreso_productos paginado con filtros
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
        $egreso_productos = EgresoProducto::select("egreso_productos.*")
            ->with(["producto:id,nombre"]);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $egreso_productos->where("egreso_productos.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $egreso_productos->whereBetween("egreso_productos.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $egreso_productos->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("egreso_productos.$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $egreso_productos->orderBy($value[0], $value[1]);
            }
        }


        $egreso_productos = $egreso_productos->paginate($length, ['*'], 'page', $page);
        return $egreso_productos;
    }

    /**
     * Crear egreso_producto
     *
     * @param array $datos
     * @return EgresoProducto
     */
    public function crear(array $datos): EgresoProducto
    {
        $egreso_producto = EgresoProducto::create([
            "producto_id" => $datos["producto_id"],
            "cantidad" => $datos["cantidad"],
            "motivo" => mb_strtoupper($datos["motivo"]),
            "fecha_egreso" => date("Y-m-d"),
        ]);

        // decrementar stock
        $producto = Producto::findOrFail($datos["producto_id"]);
        $this->kardex_producto_service->registroEgreso("EGRESO DE PRODUCTO", $producto, $datos["cantidad"], $producto->precio, "SALIDA POR REGISTRO DE EGRESO", "EgresoProducto", $egreso_producto->id);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN EGRESO DE PRODUCTO", $egreso_producto);

        return $egreso_producto;
    }

    /**
     * Actualizar egreso_producto
     *
     * @param array $datos
     * @param EgresoProducto $egreso_producto
     * @return EgresoProducto
     */
    public function actualizar(array $datos, EgresoProducto $egreso_producto): EgresoProducto
    {
        $old_egreso_producto = clone $egreso_producto;

        // incrementar stock
        $producto = Producto::findOrFail($old_egreso_producto->producto_id);
        $this->kardex_producto_service->registroIngreso("EGRESO DE PRODUCTO", $producto, $old_egreso_producto->cantidad, $producto->precio, "INGRESO POR MODIFICACIÓN DE EGRESO", "EgresoProducto", $old_egreso_producto->id);

        $egreso_producto->update([
            "producto_id" => $datos["producto_id"],
            "cantidad" => $datos["cantidad"],
            "motivo" => mb_strtoupper($datos["motivo"]),
        ]);

        // decrementar stock
        $producto = Producto::findOrFail($datos["producto_id"]);
        $this->kardex_producto_service->registroEgreso("EGRESO DE PRODUCTO", $producto, $datos["cantidad"], $producto->precio, "SALIDA POR MODIFICACIÓN", "EgresoProducto", $egreso_producto->id);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ EL REGISTRO DE UN EGRESO DE PRODUCTO", $old_egreso_producto, $egreso_producto->withoutRelations());

        return $egreso_producto;
    }

    /**
     * Eliminar egreso_producto
     *
     * @param EgresoProducto $egreso_producto
     * @return boolean
     */
    public function eliminar(EgresoProducto $egreso_producto): bool
    {

        $old_egreso_producto = clone $egreso_producto;

        // incrementar stock
        $producto = Producto::findOrFail($old_egreso_producto->producto_id);
        $this->kardex_producto_service->registroIngreso("EGRESO DE PRODUCTO", $producto, $old_egreso_producto->cantidad, $producto->precio, "INGRESO POR ELIMINACIÓN DE EGRESO", "EgresoProducto", $old_egreso_producto->id);

        $egreso_producto->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UN EGRESO DE PRODUCTO", $old_egreso_producto);
        return true;
    }
}

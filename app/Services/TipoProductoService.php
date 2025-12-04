<?php

namespace App\Services;

use App\Models\Habitacion;
use App\Models\Producto;
use App\Models\TipoProducto;
use App\Models\Registro;
use App\Models\RegistroServicio;
use App\Models\ServicioDetalle;
use App\Models\TipoCambio;
use Illuminate\Support\Facades\Auth;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class TipoProductoService
{
    private $modulo = "TIPO DE PRODUCTOS";
    public function __construct(private HistorialAccionService $historialAccionService) {}


    public function listado(string $search): array
    {
        // return TipoProducto::where(function ($query) use ($search) {
        //     $query->where("ci", "LIKE", "%$search%")
        //         ->orWhereRaw("CONCAT(nombre, ' ', paterno, ' ', materno) LIKE ?", ["%$search%"]);
        // })
        //     ->orderBy("nombre")
        //     ->get()
        //     ->toArray();
        return TipoProducto::select("tipo_productos.*")
            ->get()
            ->toArray();
    }

    /**
     * Obtener tipo_producto oficial
     *
     * @return TipoProducto
     */
    public function getTipoProductoPrincipal(): TipoProducto
    {
        return TipoProducto::where("oficial", 1)->get()->first();
    }

    /**
     * Lista de tipo_productos paginado con filtros
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
        $tipo_productos = TipoProducto::select("tipo_productos.*");

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $tipo_productos->where("tipo_productos.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $tipo_productos->whereBetween("tipo_productos.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $tipo_productos->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("tipo_productos.$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $tipo_productos->orderBy($value[0], $value[1]);
            }
        }


        $tipo_productos = $tipo_productos->paginate($length, ['*'], 'page', $page);
        return $tipo_productos;
    }

    /**
     * Crear tipo_producto
     *
     * @param array $datos
     * @return TipoProducto
     */
    public function crear(array $datos): TipoProducto
    {
        $tipo_producto = TipoProducto::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN TIPO DE PRODUCTO", $tipo_producto);

        return $tipo_producto;
    }

    /**
     * Actualizar tipo_producto
     *
     * @param array $datos
     * @param TipoProducto $tipo_producto
     * @return TipoProducto
     */
    public function actualizar(array $datos, TipoProducto $tipo_producto): TipoProducto
    {
        $old_tipo_producto = clone $tipo_producto;
        $tipo_producto->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ EL REGISTRO DE UN TIPO DE PRODUCTO", $old_tipo_producto, $tipo_producto->withoutRelations());

        return $tipo_producto;
    }

    /**
     * Eliminar tipo_producto
     *
     * @param TipoProducto $tipo_producto
     * @return boolean
     */
    public function eliminar(TipoProducto $tipo_producto): bool
    {
        $usos = Producto::where("tipo_producto_id", $tipo_producto->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el registro porque esta siendo utilizado.");
        }

        $old_tipo_producto = clone $tipo_producto;
        $tipo_producto->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UN TIPO DE PRODUCTO", $old_tipo_producto);
        return true;
    }
}

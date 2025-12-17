<?php

namespace App\Services;

use App\Models\RegistroServicio;
use Illuminate\Support\Facades\Auth;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class RegistroServicioService
{
    private $modulo = "REGISTRO SERVICIOS";
    public function __construct(private HistorialAccionService $historialAccionService, private MonedaService $monedaService) {}


    public function listado(string $search): array
    {
        return RegistroServicio::where("status", 1)
            ->where(function ($query) use ($search) {
                $query->where("ci", "LIKE", "%$search%")
                    ->orWhereRaw("CONCAT(nombre, ' ', paterno, ' ', materno) LIKE ?", ["%$search%"]);
            })
            ->orderBy("nombre")
            ->get()
            ->toArray();
    }

    /**
     * Lista de registro_servicios paginado con filtros
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
        $registro_servicios = RegistroServicio::select("registro_servicios.*");

        $registro_servicios->where("status", 1);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $registro_servicios->where("registro_servicios.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $registro_servicios->whereBetween("registro_servicios.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $registro_servicios->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("registro_servicios.$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $registro_servicios->orderBy($value[0], $value[1]);
            }
        }


        $registro_servicios = $registro_servicios->paginate($length, ['*'], 'page', $page);
        return $registro_servicios;
    }


    /**
     * Crear registro_servicio
     *
     * @param array $datos
     * @return RegistroServicio
     */
    public function crear(array $datos): RegistroServicio
    {

        $monedaOficial = $this->monedaService->getMonedaPrincipal();
        if (!$monedaOficial) {
            throw new Exception("No se configuro la moneda oficial, contactese con el Administrador");
        }

        $registro_servicio = RegistroServicio::create([
            "registro_id" => $datos["registro_id"],
            "total" => $datos["total"],
            "cancelado" => $datos["cancelado"],
            "saldo" => $datos["saldo"],
            "moneda_id" => $monedaOficial->id,
            "total_tc" => $datos["total_tc"] ?? null,
            "cancelado_tc" => $datos["cancelado_tc"] ?? null,
            "saldo_tc" => $datos["saldo_tc"] ?? null,
            "moneda_id_tc" => $datos["moneda_id_tc"] ?? null,
            "tipo_cambio_id" => $datos["tipo_cambio_id"] ?? null,
            "user_id" => Auth::user()->id,
        ]);

        foreach ($datos["servicio_detalles"] as $item) {
            $registro_servicio->servicio_detalles()->create([
                "registro_id" => $datos["registro_id"],
                "producto_id" => $item["producto_id"],
                "tipo" => $item["tipo"],
                "descripcion_externo" => $item["descripcion_externo"],
                "cantidad" => $item["cantidad"],
                "precio_unitario" => $item["precio_unitario"],
                "total" => $item["total"],
            ]);
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN SERVICIO", $registro_servicio);

        return $registro_servicio;
    }

    /**
     * Actualizar registro_servicio
     *
     * @param array $datos
     * @param RegistroServicio $registro_servicio
     * @return RegistroServicio
     */
    public function actualizar(array $datos, RegistroServicio $registro_servicio): RegistroServicio
    {
        $old_registro = clone $registro_servicio;

        $registro_servicio->update([
            "registro_id" => $datos["registro_id"],
            "total" => $datos["total"],
            "cancelado" => $datos["cancelado"],
            "saldo" => $datos["saldo"],
            "moneda_id" => $datos["moneda_id"],
            "total_tc" => $datos["total_tc"],
            "cancelado_tc" => $datos["cancelado_tc"],
            "saldo_tc" => $datos["saldo_tc"],
            "moneda_id_tc" => $datos["moneda_id_tc"],
            "tipo_cambio_id" => $datos["tipo_cambio_id"],
        ]);



        foreach ($datos["servicio_detalles"] as $item) {
            $registro_servicio->servicio_detalles()->create([
                "registro_id" => $item["registro_id"],
                "producto_id" => $item["producto_id"],
                "tipo" => $item["tipo"],
                "descripcion_externo" => $item["descripcion_externo"],
                "cantidad" => $item["cantidad"],
                "precio_unitario" => $item["precio_unitario"],
                "total" => $item["total"],
            ]);
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ EL REGISTRO DE UN SERVICIO", $old_registro, $registro_servicio, ["servicio_detalles"]);

        return $registro_servicio;
    }

    /**
     * Eliminar registro_servicio
     *
     * @param RegistroServicio $registro_servicio
     * @return boolean
     */
    public function eliminar(RegistroServicio $registro_servicio): bool
    {
        // no eliminar users predeterminados para el funcionamiento del sistema
        $old_registro = clone $registro_servicio;
        $registro_servicio->delete();
        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UN SERVICIO", $old_registro, null, ["servicio_detalles"]);
        return true;
    }
}

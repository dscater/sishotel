<?php

namespace App\Services;

use App\Models\Habitacion;
use App\Models\TipoCambio;
use Illuminate\Support\Facades\Auth;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class TipoCambioService
{
    private $modulo = "TIPO DE CAMBIO";
    public function __construct(private HistorialAccionService $historialAccionService) {}


    public function listado(string $search): array
    {
        // return TipoCambio::where(function ($query) use ($search) {
        //     $query->where("ci", "LIKE", "%$search%")
        //         ->orWhereRaw("CONCAT(nombre, ' ', paterno, ' ', materno) LIKE ?", ["%$search%"]);
        // })
        //     ->orderBy("nombre")
        //     ->get()
        //     ->toArray();
        return TipoCambio::select("tipo_cambios.*")
            ->get()
            ->toArray();
    }

    /**
     * Lista de tipo_cambios paginado con filtros
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
        $tipo_cambios = TipoCambio::select("tipo_cambios.*");

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $tipo_cambios->where("tipo_cambios.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $tipo_cambios->whereBetween("tipo_cambios.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $tipo_cambios->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("tipo_cambios.$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $tipo_cambios->orderBy($value[0], $value[1]);
            }
        }


        $tipo_cambios = $tipo_cambios->paginate($length, ['*'], 'page', $page);
        return $tipo_cambios;
    }

    /**
     * Crear tipo_cambio
     *
     * @param array $datos
     * @return TipoCambio
     */
    public function crear(array $datos): TipoCambio
    {
        $tipo_cambio = TipoCambio::create([
            "moneda_id" => mb_strtoupper($datos["moneda_id"]),
            "valor" => mb_strtoupper($datos["valor"]),
            "fecha" => date("Y-m-d")
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN TIPO DE CAMBIO", $tipo_cambio);

        return $tipo_cambio;
    }

    /**
     * Actualizar tipo_cambio
     *
     * @param array $datos
     * @param TipoCambio $tipo_cambio
     * @return TipoCambio
     */
    public function actualizar(array $datos, TipoCambio $tipo_cambio): TipoCambio
    {
        $old_tipo_cambio = clone $tipo_cambio;
        $tipo_cambio->update([
            "moneda_id" => mb_strtoupper($datos["moneda_id"]),
            "valor" => mb_strtoupper($datos["valor"]),
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ EL REGISTRO DE UN TIPO DE CAMBIO", $old_tipo_cambio, $tipo_cambio->withoutRelations());

        return $tipo_cambio;
    }

    /**
     * Eliminar tipo_cambio
     *
     * @param TipoCambio $tipo_cambio
     * @return boolean
     */
    public function eliminar(TipoCambio $tipo_cambio): bool
    {
        $usos = TipoCambio::where("tipo_cambio_id", $tipo_cambio->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el tipo de habitación porque está siendo utilizado en habitaciones.");
        }

        $old_tipo_cambio = clone $tipo_cambio;
        $tipo_cambio->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UN TIPO DE CAMBIO", $old_tipo_cambio);
        return true;
    }
}

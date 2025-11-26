<?php

namespace App\Services;

use App\Models\Habitacion;
use App\Models\TipoCambio;
use Carbon\Carbon;
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
    public function listadoPaginado(int $length, int $page, string $search, array $orderBy = []): LengthAwarePaginator
    {
        $tipo_cambios = TipoCambio::select("tipo_cambios.*")
            ->with(["moneda:id,nombre"])
            ->join("monedas", "monedas.id", "=", "tipo_cambios.moneda_id");


        if (!empty($search)) {
            // Detectar si el texto parece una fecha (ej: 12/10/2025 o 12-10-2025)
            $fecha = null;
            if (preg_match('/^(\d{1,2})[\/\-](\d{1,2})[\/\-](\d{4})$/', trim($search), $matches)) {
                try {
                    $fecha = Carbon::createFromFormat('d/m/Y', str_replace('-', '/', $search))->format('Y-m-d');
                } catch (\Exception $e) {
                    // Si falla el formato anterior, intentar con d-m-Y
                    try {
                        $fecha = Carbon::createFromFormat('d-m-Y', $search)->format('Y-m-d');
                    } catch (\Exception $e2) {
                        $fecha = null;
                    }
                }
            }

            // Agrupar ORs correctamente
            $tipo_cambios->where(function ($q) use ($search, $fecha) {
                if ($fecha) {
                    $q->orWhereDate("fecha", $fecha);
                }

                $q->orWhere("monedas.nombre", "LIKE", "%$search%");
                $q->orWhere("valor", "LIKE", "%$search%");
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

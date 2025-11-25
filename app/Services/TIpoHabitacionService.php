<?php

namespace App\Services;

use App\Models\Habitacion;
use App\Models\TipoHabitacion;
use Illuminate\Support\Facades\Auth;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class TipoHabitacionService
{
    private $modulo = "TIPO DE HABITACIÓN";
    public function __construct(private HistorialAccionService $historialAccionService) {}


    public function listado(string $search): array
    {
        // return TipoHabitacion::where(function ($query) use ($search) {
        //     $query->where("ci", "LIKE", "%$search%")
        //         ->orWhereRaw("CONCAT(nombre, ' ', paterno, ' ', materno) LIKE ?", ["%$search%"]);
        // })
        //     ->orderBy("nombre")
        //     ->get()
        //     ->toArray();
        return TipoHabitacion::select("tipo_habitacions.*")
            ->get()
            ->toArray();
    }

    /**
     * Lista de tipo_habitacions paginado con filtros
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
        $tipo_habitacions = TipoHabitacion::select("tipo_habitacions.*");

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $tipo_habitacions->where("tipo_habitacions.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $tipo_habitacions->whereBetween("tipo_habitacions.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $tipo_habitacions->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("tipo_habitacions.$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $tipo_habitacions->orderBy($value[0], $value[1]);
            }
        }


        $tipo_habitacions = $tipo_habitacions->paginate($length, ['*'], 'page', $page);
        return $tipo_habitacions;
    }

    /**
     * Crear tipo_habitacion
     *
     * @param array $datos
     * @return TipoHabitacion
     */
    public function crear(array $datos): TipoHabitacion
    {
        $tipo_habitacion = TipoHabitacion::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "capacidad" => $datos["capacidad"] ?? null,
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN TIPO DE HABITACIÓN", $tipo_habitacion);

        return $tipo_habitacion;
    }

    /**
     * Actualizar tipo_habitacion
     *
     * @param array $datos
     * @param TipoHabitacion $tipo_habitacion
     * @return TipoHabitacion
     */
    public function actualizar(array $datos, TipoHabitacion $tipo_habitacion): TipoHabitacion
    {
        $old_tipo_habitacion = clone $tipo_habitacion;
        $tipo_habitacion->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "capacidad" => $datos["capacidad"] ?? null,
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN", $old_tipo_habitacion, $tipo_habitacion->withoutRelations());

        return $tipo_habitacion;
    }

    /**
     * Eliminar tipo_habitacion
     *
     * @param TipoHabitacion $tipo_habitacion
     * @return boolean
     */
    public function eliminar(TipoHabitacion $tipo_habitacion): bool
    {
        $usos = Habitacion::where("tipo_habitacion_id", $tipo_habitacion->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el tipo de habitación porque está siendo utilizado en habitaciones.");
        }

        $old_tipo_habitacion = clone $tipo_habitacion;
        $tipo_habitacion->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UN TIPO DE HABITACIÓN", $old_tipo_habitacion);
        return true;
    }
}

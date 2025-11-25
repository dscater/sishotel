<?php

namespace App\Services;

use App\Models\Habitacion;
use App\Models\HabitacionFoto;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Log;

class HabitacionService
{
    private $modulo = "HABITACIONES";
    public function __construct(private HistorialAccionService $historialAccionService, private HabitacionFotoService $habitacionFotoService) {}


    public function listado(string $search): array
    {
        return Habitacion::where("status", 1)
            ->get()
            ->toArray();
    }

    /**
     * Lista de habitacions paginado con filtros
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
        $habitacions = Habitacion::with(["tipo_habitacion", "habitacion_fotos"])->select("habitacions.*");

        $habitacions->where("status", 1);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $habitacions->where("habitacions.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $habitacions->whereBetween("habitacions.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $habitacions->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("habitacions.$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $habitacions->orderBy($value[0], $value[1]);
            }
        }


        $habitacions = $habitacions->paginate($length, ['*'], 'page', $page);
        return $habitacions;
    }


    /**
     * Lista de habitacions paginado con filtros (eliminados)
     *
     * @param integer $length
     * @param integer $page
     * @param string $search
     * @param array $columnsSerachLike
     * @param array $columnsFilter
     * @return LengthAwarePaginator
     */
    public function listadoPaginadoEliminados(int $length, int $page, string $search, array $columnsSerachLike = [], array $columnsFilter = [], array $columnsBetweenFilter = [], array $orderBy = []): LengthAwarePaginator
    {
        $habitacions = Habitacion::with(["tipo_habitacion"])->select("habitacions.*")
            ->join("tipo_habitacions", "habitacions.tipo_habitacion_id", "=", "tipo_habitacions.id");

        $habitacions->where("status", 0);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $habitacions->where("habitacions.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $habitacions->whereBetween("habitacions.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $habitacions->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $habitacions->orderBy($value[0], $value[1]);
            }
        }


        $habitacions = $habitacions->paginate($length, ['*'], 'page', $page);
        return $habitacions;
    }

    /**
     * Crear habitacion
     *
     * @param array $datos
     * @return Habitacion
     */
    public function crear(array $datos): Habitacion
    {
        $habitacion = Habitacion::create([
            "numero_habitacion" => mb_strtoupper($datos["numero_habitacion"]),
            "tipo_habitacion_id" => $datos["tipo_habitacion_id"],
            "piso" => $datos["piso"],
            "precio" => $datos["precio"],
            "precio_temp" => $datos["precio_temp"],
            "capacidad" => $datos["capacidad"],
            "estado" => $datos["estado"],
        ]);

        // registrar archivos
        if (!empty($datos["habitacion_fotos"])) {
            foreach ($datos["habitacion_fotos"] as $key => $archivo) {
                $this->habitacionFotoService->guardarHabitacionFoto($habitacion, $archivo["file"], $key);
            }
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA HABITACIÓN", $habitacion, null, ["habitacion_fotos"]);

        return $habitacion;
    }

    /**
     * Actualizar habitacion
     *
     * @param array $datos
     * @param Habitacion $habitacion
     * @return Habitacion
     */
    public function actualizar(array $datos, Habitacion $habitacion): Habitacion
    {
        $old_habitacion = clone $habitacion;
        $old_habitacion->loadMissing(["habitacion_fotos"]);

        $habitacion->update([
            "numero_habitacion" => mb_strtoupper($datos["numero_habitacion"]),
            "tipo_habitacion_id" => $datos["tipo_habitacion_id"],
            "piso" => $datos["piso"],
            "precio" => $datos["precio"],
            "precio_temp" => $datos["precio_temp"],
            "capacidad" => $datos["capacidad"],
            "estado" => $datos["estado"],
        ]);

        // actualizar archivos
        if (!empty($datos["habitacion_fotos"])) {
            foreach ($datos["habitacion_fotos"] as $key => $imagen) {
                if ($imagen["id"] == 0) {
                    $this->habitacionFotoService->guardarHabitacionFoto($habitacion, $imagen["file"], $key);
                }
            }
        }

        // archivos eliminados
        if (!empty($datos["eliminados_fotos"])) {
            foreach ($datos["eliminados_fotos"] as $key => $eliminado) {
                $habitacionFoto = HabitacionFoto::find($eliminado);
                if ($habitacionFoto) {
                    $this->habitacionFotoService->eliminarHabitacionFoto($habitacionFoto);
                }
            }
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ EL REGISTRO DE UN HABITACIÓN", $old_habitacion, $habitacion, ["habitacion_fotos"]);

        return $habitacion;
    }

    /**
     * Eliminar habitacion
     *
     * @param Habitacion $habitacion
     * @return boolean
     */
    public function eliminar(Habitacion $habitacion): bool
    {
        // usos
        $usos = Registro::where("habitacion_id", $habitacion->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el registro de la habitación porque está siendo usado en otros procesos.");
        }

        // no eliminar users predeterminados para el funcionamiento del sistema
        $old_habitacion = clone $habitacion;
        $habitacion->status = 0;
        $habitacion->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UN HABITACIÓN " . $old_habitacion->numero_habitacion, $old_habitacion, $habitacion, ["habitacion_fotos"]);
        return true;
    }

    /**
     * Reestablecer habitacion
     *
     * @param Habitacion $habitacion
     * @return boolean
     */
    public function reestablecer(Habitacion $habitacion): bool
    {
        $old_habitacion = clone $habitacion;
        $habitacion->status = 1;
        $habitacion->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "REESTABLECER", "REESTABLECIÓ EL REGISTRO DE UN HABITACIÓN " . $old_habitacion->numero_habitacion, $old_habitacion, $habitacion, ["habitacion_fotos"]);
        return true;
    }

    /**
     * Eliminación permanente de habitacion
     *
     * @param Habitacion $habitacion
     * @return boolean
     */
    public function eliminacion_permanente(Habitacion $habitacion): bool
    {
        $old_habitacion = clone $habitacion;
        $habitacion->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN PERMANENTE", "ELIMINÓ PERMANENTEMENTE EL REGISTRO DE UN HABITACIÓN " . $old_habitacion->numero_habitacion, $old_habitacion, null, ["habitacion_fotos"]);
        return true;
    }
}

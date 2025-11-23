<?php

namespace App\Services;

use App\Models\Habitacion;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\UploadedFile;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class HabitacionService
{
    private $modulo = "HABITACIÓNES";
    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}


    public function listado(string $search): array
    {
        return Habitacion::where("status", 1)
            ->where(function ($query) use ($search) {
                $query->where("ci", "LIKE", "%$search%")
                    ->orWhereRaw("CONCAT(nombre, ' ', paterno, ' ', materno) LIKE ?", ["%$search%"]);
            })
            ->orderBy("nombre")
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
        $habitacions = Habitacion::select("habitacions.*");

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
        $habitacions = Habitacion::select("habitacions.*");

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
     * Crear habitacion
     *
     * @param array $datos
     * @return Habitacion
     */
    public function crear(array $datos): Habitacion
    {
        $habitacion = Habitacion::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "paterno" => mb_strtoupper($datos["paterno"]),
            "materno" => mb_strtoupper($datos["materno"]),
            "dir" => mb_strtoupper($datos["dir"]),
            "ci" => $datos["ci"],
            "ci_exp" => $datos["ci_exp"],
            "fono" => $datos["fono"],
            "correo" => $datos["correo"],
            "edad" => $datos["edad"],
            "nacionalidad" => mb_strtoupper($datos["nacionalidad"]),
            "pais" => mb_strtoupper($datos["pais"]),
            "fecha_registro" => date("Y-m-d"),
            "user_id" => Auth::user()->id,
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA HABITACIÓN", $habitacion);

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
        $old_user = clone $habitacion;

        $habitacion->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "paterno" => mb_strtoupper($datos["paterno"]),
            "materno" => mb_strtoupper($datos["materno"]),
            "dir" => mb_strtoupper($datos["dir"]),
            "ci" => $datos["ci"],
            "ci_exp" => $datos["ci_exp"],
            "fono" => $datos["fono"],
            "correo" => $datos["correo"],
            "edad" => $datos["edad"],
            "nacionalidad" => mb_strtoupper($datos["nacionalidad"]),
            "pais" => mb_strtoupper($datos["pais"]),
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ EL REGISTRO DE UN HABITACIÓN", $old_user, $habitacion->withoutRelations());

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
        // no eliminar users predeterminados para el funcionamiento del sistema
        $old_user = clone $habitacion;
        $habitacion->status = 0;
        $habitacion->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UN HABITACIÓN " . $old_user->usuario, $old_user, $habitacion);
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
        $this->historialAccionService->registrarAccion($this->modulo, "REESTABLECER", "REESTABLECIÓ EL REGISTRO DE UN HABITACIÓN " . $old_habitacion->usuario, $old_habitacion, $habitacion);
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
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN PERMANENTE", "ELIMINÓ PERMANENTEMENTE EL REGISTRO DE UN HABITACIÓN " . $old_habitacion->usuario, $old_habitacion);
        return true;
    }
}

<?php

namespace App\Services;

use App\Models\Registro;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\UploadedFile;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class RegistroService
{
    private $modulo = "REGISTROS";
    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}


    public function listado(string $search): array
    {
        return Registro::where("status", 1)
            ->where(function ($query) use ($search) {
                $query->where("ci", "LIKE", "%$search%")
                    ->orWhereRaw("CONCAT(nombre, ' ', paterno, ' ', materno) LIKE ?", ["%$search%"]);
            })
            ->orderBy("nombre")
            ->get()
            ->toArray();
    }

    /**
     * Lista de registros paginado con filtros
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
        $registros = Registro::select("registros.*");

        $registros->where("status", 1);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $registros->where("registros.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $registros->whereBetween("registros.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $registros->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("registros.$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $registros->orderBy($value[0], $value[1]);
            }
        }


        $registros = $registros->paginate($length, ['*'], 'page', $page);
        return $registros;
    }


    /**
     * Crear registro
     *
     * @param array $datos
     * @return Registro
     */
    public function crear(array $datos): Registro|array
    {

        Log::debug($datos);
        // $registro = Registro::create([]);

        // registrar accion
        // $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REALIZÓ UN REGISTRO", $registro);

        // return $registro;
        return [];
    }

    /**
     * Actualizar registro
     *
     * @param array $datos
     * @param Registro $registro
     * @return Registro
     */
    public function actualizar(array $datos, Registro $registro): Registro
    {
        $old_user = clone $registro;

        $registro->update([
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
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN REGISTRO", $old_user, $registro->withoutRelations());

        return $registro;
    }

    /**
     * Eliminar registro
     *
     * @param Registro $registro
     * @return boolean
     */
    public function eliminar(Registro $registro): bool
    {
        // no eliminar users predeterminados para el funcionamiento del sistema
        $old_user = clone $registro;
        $registro->status = 0;
        $registro->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UN REGISTRO " . $old_user->usuario, $old_user, $registro);
        return true;
    }
}

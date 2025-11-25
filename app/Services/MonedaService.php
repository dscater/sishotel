<?php

namespace App\Services;

use App\Models\Habitacion;
use App\Models\Moneda;
use App\Models\Registro;
use App\Models\RegistroServicio;
use App\Models\ServicioDetalle;
use App\Models\TipoCambio;
use Illuminate\Support\Facades\Auth;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class MonedaService
{
    private $modulo = "MONEDAS";
    public function __construct(private HistorialAccionService $historialAccionService) {}


    public function listado(string $search): array
    {
        // return Moneda::where(function ($query) use ($search) {
        //     $query->where("ci", "LIKE", "%$search%")
        //         ->orWhereRaw("CONCAT(nombre, ' ', paterno, ' ', materno) LIKE ?", ["%$search%"]);
        // })
        //     ->orderBy("nombre")
        //     ->get()
        //     ->toArray();
        return Moneda::select("monedas.*")
            ->get()
            ->toArray();
    }

    /**
     * Lista de monedas paginado con filtros
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
        $monedas = Moneda::select("monedas.*");

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $monedas->where("monedas.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $monedas->whereBetween("monedas.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $monedas->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("monedas.$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $monedas->orderBy($value[0], $value[1]);
            }
        }


        $monedas = $monedas->paginate($length, ['*'], 'page', $page);
        return $monedas;
    }

    /**
     * Crear moneda
     *
     * @param array $datos
     * @return Moneda
     */
    public function crear(array $datos): Moneda
    {
        $moneda = Moneda::create([
            "codigo" => $datos["codigo"],
            "nombre" => $datos["nombre"],
            "simbolo" => $datos["simbolo"],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA MONEDA", $moneda);

        return $moneda;
    }

    /**
     * Actualizar moneda
     *
     * @param array $datos
     * @param Moneda $moneda
     * @return Moneda
     */
    public function actualizar(array $datos, Moneda $moneda): Moneda
    {
        $old_moneda = clone $moneda;
        $moneda->update([
            "codigo" => $datos["codigo"],
            "nombre" => $datos["nombre"],
            "simbolo" => $datos["simbolo"],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ EL REGISTRO DE UNA MONEDA", $old_moneda, $moneda->withoutRelations());

        return $moneda;
    }

    /**
     * Eliminar moneda
     *
     * @param Moneda $moneda
     * @return boolean
     */
    public function eliminar(Moneda $moneda): bool
    {
        $usos = TipoCambio::where("moneda_id", $moneda->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el registro porque esta siendo utilizado.");
        }

        $usos = Registro::where("moneda_id", $moneda->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el registro porque esta siendo utilizado.");
        }

        $usos = Registro::where("moneda_id_tc", $moneda->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el registro porque esta siendo utilizado.");
        }

        $usos = RegistroServicio::where("moneda_id", $moneda->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el registro porque esta siendo utilizado.");
        }

        $usos = RegistroServicio::where("moneda_id_tc", $moneda->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el registro porque esta siendo utilizado.");
        }

        $usos = ServicioDetalle::where("moneda_id", $moneda->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el registro porque esta siendo utilizado.");
        }

        $usos = ServicioDetalle::where("moneda_id_tc", $moneda->id)->count();
        if ($usos > 0) {
            throw new \Exception("No se puede eliminar el registro porque esta siendo utilizado.");
        }

        $old_moneda = clone $moneda;
        $moneda->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UNA MONEDA", $old_moneda);
        return true;
    }
}

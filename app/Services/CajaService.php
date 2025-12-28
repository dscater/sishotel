<?php

namespace App\Services;

use App\Models\Caja;
use App\Models\Moneda;
use App\Models\MovimientoCaja;
use Illuminate\Support\Facades\Auth;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class CajaService
{
    private $modulo = "CAJA";
    public function __construct(private HistorialAccionService $historialAccionService, private MonedaService $monedaService) {}

    public function verificarCajaAbierta(): ?Caja
    {
        return Caja::orderBy("created_at", "DESC")
            ->where("status", 1)
            ->first();
    }

    public function verificarCajaAbiertaPorUsuario(int $user_id): ?Caja
    {
        return Caja::where("user_id", $user_id)
            ->where("status", 1)
            ->first();
    }

    public function aperturarCaja(): Caja
    {
        /***
         * Verificar y aperturar caja con los saldos del ultimo cierre
         */
        $ultimoCierreCaja = Caja::orderBy("created_at", "DESC")
            ->first();
        if ($ultimoCierreCaja && $ultimoCierreCaja->status == 1) {
            throw new \Exception("Ya existe una caja abierta por el usuario " . $ultimoCierreCaja->user->full_name);
        }

        $caja = Caja::create([
            "monto_inicial" => $ultimoCierreCaja ? $ultimoCierreCaja->monto_final : 0,
            "monto_efectivo_inicial" => $ultimoCierreCaja ? $ultimoCierreCaja->monto_efectivo_final : 0,
            "monto_banco_inicial" => $ultimoCierreCaja ? $ultimoCierreCaja->monto_banco_final : 0,
            "fecha_apertura" => date("Y-m-d"),
            "hora_apertura" => date("H:i:s"),
            "user_id" => Auth::user()->id,
        ]);

        return $caja;
    }

    public function cerrarCaja($caja_id, $fecha_cierre, $hora_cierre): Caja
    {

        $caja = Caja::findOrFail($caja_id);
        $caja->status = 2; // CERRADO
        $caja->fecha_cierre = $fecha_cierre;
        $caja->hora_cierre = $hora_cierre;
        $caja->save();

        return $caja;
    }

    public function registrarMontoIngreso($monto, $tipo_pago)
    {
        $caja = $this->verificarCajaAbierta();
        if (!$caja) {
            throw new \Exception("No hay una caja abierta para registrar el movimiento");
        }

        if ($tipo_pago == 'EFECTIVO') {
            $caja->monto_efectivo_final += (float)$monto + (float)$caja->monto_efectivo_inicial;
        } else {
            $caja->monto_banco_final += (float)$monto + (float)$caja->monto_banco_inicial;
        }

        $caja->monto_final += (float)$monto + (float)$caja->monto_inicial;
        $caja->save();

        return $caja;
    }

    public function registrarMontoEgreso($monto, $tipo_pago)
    {
        $caja = $this->verificarCajaAbierta();
        if (!$caja) {
            throw new \Exception("No hay una caja abierta para registrar el movimiento");
        }

        if ($tipo_pago == 'EFECTIVO') {
            $caja->monto_efectivo_final -= (float)$monto;
        } else {
            $caja->monto_banco_final -= (float)$monto;
        }

        $caja->monto_final -= (float)$monto;
        $caja->save();
        return $caja;
    }

    public function listado(string $search): array
    {
        return Caja::where("status", 1)
            ->where(function ($query) use ($search) {
                $query->where("ci", "LIKE", "%$search%")
                    ->orWhereRaw("CONCAT(nombre, ' ', paterno, ' ', materno) LIKE ?", ["%$search%"]);
            })
            ->orderBy("nombre")
            ->get()
            ->toArray();
    }

    /**
     * Lista de cajas paginado con filtros
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
        $cajas = MovimientoCaja::select("movimiento_cajas.*")
            ->with([
                "moneda",
                "moneda_tc",
                "user",
            ]);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $cajas->where("cajas.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $cajas->whereBetween("cajas.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $cajas->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("cajas.$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $cajas->orderBy($value[0], $value[1]);
            }
        }


        $cajas = $cajas->paginate($length, ['*'], 'page', $page);
        return $cajas;
    }


    /**
     * Lista de cajas paginado con filtros (eliminados)
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
        $cajas = Caja::select("cajas.*");

        $cajas->where("status", 0);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $cajas->where("cajas.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $cajas->whereBetween("cajas.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $cajas->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("cajas.$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $cajas->orderBy($value[0], $value[1]);
            }
        }


        $cajas = $cajas->paginate($length, ['*'], 'page', $page);
        return $cajas;
    }

    /**
     * Crear caja
     *
     * @param array $datos
     * @return Caja
     */
    public function crear(array $datos): Caja
    {
        $caja = Caja::create([
            "monto" => $datos["monto"],
            "moneda_id" => $datos["moneda_id"],
            "tc" => $datos["tc"],
            "monto_tc" => $datos["monto_tc"],
            "moneda_id_tc" => $datos["moneda_id_tc"],
            "tipo_cambio_id" => $datos["tipo_cambio_id"],
            "valor_tc" => $datos["valor_tc"],
            "tipo" => $datos["tipo"],
            "efectivo_banco" => $datos["efectivo_banco"],
            "descripcion" => $datos["descripcion"],
            "fecha_movimiento" => $datos["fecha_movimiento"],
            "hora_movimiento" => $datos["hora_movimiento"],
            "user_id" => Auth::user()->id,
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN CLIENTE", $caja);

        return $caja;
    }

    /**
     * Actualizar caja
     *
     * @param array $datos
     * @param Caja $caja
     * @return Caja
     */
    public function actualizar(array $datos, Caja $caja): Caja
    {
        $old_user = clone $caja;

        $caja->update([
            "monto" => $datos["monto"],
            "moneda_id" => $datos["moneda_id"],
            "tc" => $datos["tc"],
            "monto_tc" => $datos["monto_tc"],
            "moneda_id_tc" => $datos["moneda_id_tc"],
            "tipo_cambio_id" => $datos["tipo_cambio_id"],
            "valor_tc" => $datos["valor_tc"],
            "tipo" => $datos["tipo"],
            "efectivo_banco" => $datos["efectivo_banco"],
            "descripcion" => $datos["descripcion"],
            "fecha_movimiento" => $datos["fecha_movimiento"],
            "hora_movimiento" => $datos["hora_movimiento"],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ EL REGISTRO DE UN CLIENTE", $old_user, $caja->withoutRelations());

        return $caja;
    }

    /**
     * Eliminar caja
     *
     * @param Caja $caja
     * @return boolean
     */
    public function eliminar(Caja $caja): bool
    {
        // no eliminar users predeterminados para el funcionamiento del sistema
        $old_user = clone $caja;
        $caja->status = 0;
        $caja->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UN CLIENTE " . $old_user->usuario, $old_user, $caja);
        return true;
    }

    /**
     * Reestablecer caja
     *
     * @param Caja $caja
     * @return boolean
     */
    public function reestablecer(Caja $caja): bool
    {
        $old_caja = clone $caja;
        $caja->status = 1;
        $caja->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "REESTABLECER", "REESTABLECIÓ EL REGISTRO DE UN CLIENTE " . $old_caja->usuario, $old_caja, $caja);
        return true;
    }

    /**
     * Eliminación permanente de caja
     *
     * @param Caja $caja
     * @return boolean
     */
    public function eliminacion_permanente(Caja $caja): bool
    {
        $old_caja = clone $caja;
        $caja->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN PERMANENTE", "ELIMINÓ PERMANENTEMENTE EL REGISTRO DE UN CLIENTE " . $old_caja->nombre, $old_caja);
        return true;
    }
}

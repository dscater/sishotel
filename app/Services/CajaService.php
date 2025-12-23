<?php

namespace App\Services;

use App\Models\Caja;
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

    public function registrarMonto($monto, $tipo_pago)
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
}

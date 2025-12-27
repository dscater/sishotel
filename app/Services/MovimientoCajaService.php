<?php

namespace App\Services;

use App\Models\Moneda;
use App\Models\MovimientoCaja;
use Illuminate\Support\Facades\Auth;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class MovimientoCajaService
{
    private $modulo = "MOVIMIENTO DE CAJA";
    public function __construct(private HistorialAccionService $historialAccionService, private MonedaService $monedaService, private CajaService $cajaService) {}

    /**
     * Crear movimiento_caja
     *
     * @param array $datos
     * @return MovimientoCaja
     */
    public function crear(array $datos): MovimientoCaja
    {
        $monedaOficial = $this->monedaService->getMonedaPrincipal();
        if (!$monedaOficial) {
            throw new Exception("No se configuro la moneda oficial, contactese con el Administrador");
        }

        $caja = $this->cajaService->verificarCajaAbierta();

        if (!$caja) {
            throw new \Exception("No hay una caja abierta para registrar el movimiento");
        }


        if ($datos["tipo"] == 'EGRESO') {
            // antes de registrar un EGRESO
            $this->verificaSaldoEgresoPorMoneda($caja, $datos["efectivo_banco"] ?? 'EFECTIVO', $datos['monto_tc'] ?? $datos["monto"], $datos["moneda_id_tc"] ?? $monedaOficial->id);
        }

        $movimiento_caja = MovimientoCaja::create([
            "caja_id" => $caja->id,
            "modelo_id" => $datos["modelo_id"] ?? NULL,
            "modelo" => $datos["modelo"] ?? NULL,
            "monto" => $datos["monto"],
            "moneda_id" => $datos["moneda_id"] ?? $monedaOficial->id,
            "tc" => $datos["tc"] ?? 0,
            "valor_tc" => $datos["valor_tc"] ?? NULL,
            "monto_tc" => $datos["monto_tc"] ?? $datos["monto"],
            "moneda_id_tc" => $datos["moneda_id_tc"] ?? $monedaOficial->id,
            "tipo_cambio_id" => $datos["tipo_cambio_id"] ?? null,
            "tipo" => $datos["tipo"],
            "efectivo_banco" => $datos["efectivo_banco"] ?? null,
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "fecha_movimiento" => $datos["fecha_movimiento"],
            "hora_movimiento" => $datos["hora_movimiento"],
            "user_id" => Auth::user()->id,
        ]);

        // actualizar montos en caja
        if ($datos["tipo"] == 'INGRESO') {
            $this->cajaService->registrarMontoIngreso($movimiento_caja->monto, $datos["efectivo_banco"]);
        } else {
            $this->cajaService->registrarMontoEgreso($movimiento_caja->monto, $datos["efectivo_banco"]);
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN MOVIMIENTO DE CAJA", $movimiento_caja);

        return $movimiento_caja;
    }

    private function verificaSaldoEgresoPorMoneda($caja, $tipo_pago, $monto, $moneda_id_tc)
    {

        $moneda = Moneda::findOrFail($moneda_id_tc);

        $saldo = $this->getSaldoPorMoneda($moneda_id_tc, $caja->id, $tipo_pago);
        if ($saldo < $monto) {
            if ($tipo_pago == 'EFECTIVO') {
                throw new \Exception("Monto insuficiente EFECTIVO, para realizar el egreso. Saldo actual: " . $saldo . " " . $moneda->simbolo);

                return false;
            } else {
                throw new \Exception("Monto insuficiente BANCO, para realizar el egreso. Saldo actual: " . $saldo . " " . $moneda->simbolo);

                return false;
            }
        }

        return true;
    }


    public function getSaldoPorMoneda($moneda_id_tc, $caja_id, $efectivo_banco = 'EFECTIVO')
    {

        $saldo = MovimientoCaja::where("caja_id", $caja_id)
            ->where("moneda_id_tc", $moneda_id_tc)
            ->where("efectivo_banco", $efectivo_banco)
            ->sum("monto_tc");
        return $saldo;
    }
}

<?php

namespace App\Services;

use App\Models\RegistroServicio;
use Illuminate\Support\Facades\Auth;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Log;

class ServicioPagoService
{
    private $modulo = "SERVICIO PAGOS";
    public function __construct(private HistorialAccionService $historialAccionService, private MonedaService $monedaService, private MovimientoCajaService $movimiento_caja_service) {}

    public function pagarTotal(RegistroServicio $registro_servicio, $tipo_pago)
    {
        $monedaOficial = $this->monedaService->getMonedaPrincipal();
        if (!$monedaOficial) {
            throw new Exception("No se configuro la moneda oficial, contactese con el Administrador");
        }

        // registrar movimiento en caja
        $this->movimiento_caja_service->crear([
            "modelo_id" => $registro_servicio->id,
            "modelo" => "RegistroServicio",
            "monto" => $registro_servicio->saldo,
            "moneda_id" => $monedaOficial->id,
            "tipo" => "INGRESO",
            "efectivo_banco" => $tipo_pago,
            "descripcion" => "Pago por servicio/producto registrado con nro. de recibo " . $registro_servicio->id,
            "fecha_movimiento" => date("Y-m-d"),
            "hora_movimiento" => date("H:i:s"),
        ]);

        // actualizar datos
        $registro_servicio->saldo = 0;
        $registro_servicio->cancelado = $registro_servicio->total;
        $registro_servicio->save();

        return $registro_servicio;
    }

    public function pagoPorPartes(RegistroServicio $registro_servicio, $data)
    {
        $monedaOficial = $this->monedaService->getMonedaPrincipal();
        if (!$monedaOficial) {
            throw new Exception("No se configuro la moneda oficial, contactese con el Administrador");
        }

        if ($data["monto"] <= 0) {
            throw new \Exception("El monto a pagar debe ser mayor a cero.");
        }

        if ($data["monto"] > $registro_servicio->saldo) {
            throw new \Exception("El monto a pagar no puede ser mayor al saldo pendiente.");
        }

        // registrar movimiento en caja
        $movimiento_caja = $this->movimiento_caja_service->crear([
            "modelo_id" => $registro_servicio->id,
            "modelo" => "RegistroServicio",
            "monto" => $data["monto"],
            "moneda_id" => $monedaOficial->id,
            "tc" => $data["tc"] ?? 0,
            "monto_tc" => $data["monto_tc"] ?? null,
            "moneda_id_tc" => $data["moneda_id_tc"] ?? null,
            "tipo_cambio_id" => $data["tipo_cambio_id"] ?? null,
            "efectivo_banco" => $data["efectivo_banco"],
            "descripcion" => "Pago parcial por servicio/producto registrado con nro. de recibo " . $registro_servicio->id,
            "fecha_movimiento" => date("Y-m-d"),
            "hora_movimiento" => date("H:i:s"),
        ]);

        // actualizar datos
        $registro_servicio->cancelado += (float)$data["monto"];
        $registro_servicio->saldo -= (float)$data["monto"];

        if ($movimiento_caja->tc == 1) {
            $registro_servicio->cancelado_tc += (float)$data["monto_tc"];
            $registro_servicio->saldo_tc -= (float)$data["monto_tc"];
        }

        $registro_servicio->save();

        return $registro_servicio;
    }
}

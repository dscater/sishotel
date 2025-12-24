<?php

namespace App\Services;

use App\Models\Producto;
use App\Models\RegistroServicio;
use Illuminate\Support\Facades\Auth;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class RegistroServicioService
{
    private $modulo = "REGISTRO SERVICIOS";
    public function __construct(private HistorialAccionService $historialAccionService, private MonedaService $monedaService, private MovimientoCajaService $movimientoCajaService, private KardexProductoService $kardexProductoService) {}


    public function listado(string $search): array
    {
        return RegistroServicio::get()
            ->toArray();
    }


    public function listadoByRegistroId(int $registro_id): array
    {
        return RegistroServicio::select("registro_servicios.*")
            ->with(["registro", "servicio_detalles.producto"])
            ->where("registro_id", $registro_id)
            ->get()
            ->toArray();
    }

    /**
     * Crear registro_servicio
     *
     * @param array $datos
     * @return RegistroServicio
     */
    public function crear(array $datos): RegistroServicio
    {

        $monedaOficial = $this->monedaService->getMonedaPrincipal();
        if (!$monedaOficial) {
            throw new Exception("No se configuro la moneda oficial, contactese con el Administrador");
        }

        $registro_servicio = RegistroServicio::create([
            "registro_id" => $datos["registro_id"],
            "tipo" => $datos["tipo"],
            "total" => $datos["total"],
            "cancelado" => $datos["cancelado"],
            "saldo" => $datos["saldo"],
            "moneda_id" => $monedaOficial->id,
            "tc" => $datos["tc"] ?? 0,
            "total_tc" => $datos["total_tc"] ?? null,
            "cancelado_tc" => $datos["cancelado_tc"] ?? null,
            "saldo_tc" => $datos["saldo_tc"] ?? null,
            "moneda_id_tc" => $datos["moneda_id_tc"] ?? null,
            "tipo_cambio_id" => $datos["tipo_cambio_id"] ?? null,
            "efectivo_banco" => (float)$datos["cancelado"] > 0 ? $datos["efectivo_banco"] : "",
            "fecha" => date("Y-m-d"),
            "hora" => date("H:i:s"),
            "user_id" => Auth::user()->id,
        ]);


        if ((float)$datos["cancelado"] > 0) {
            // registrar cancelado en caja
            // registrar movimiento

            // TODO: verificar el tipo de cambio (probar con el registro inicial de habitaciones)
            $this->movimientoCajaService->crear([
                "modelo_id" => $registro_servicio->id,
                "modelo" => "RegistroServicio",
                "monto" => $datos["total"],
                "moneda_id" => $monedaOficial->id,
                "tipo" => "INGRESO",
                "efectivo_banco" => $datos["efectivo_banco"],
                "descripcion" => "Pago por servicio/producto registrado con nro. de recibo " . $registro_servicio->id,
                "fecha_movimiento" => date("Y-m-d"),
                "hora_movimiento" => date("H:i:s"),
            ]);
        }

        // detalles del servicio
        if ($datos["tipo"] === 'PRODUCTO/SERVICIO')
            foreach ($datos["servicio_detalles"] as $item) {
                // verificar stock segun tipo de producto
                $producto = Producto::findOrFail($item["producto_id"]);
                if ($producto->tipo_producto->tipo === 'PRODUCTO') {
                    if ($producto->stock < $item["cantidad"]) {
                        throw new \Exception("No hay stock suficiente del producto: " . $producto->nombre);
                    }
                }

                $registro_servicio->servicio_detalles()->create([
                    "registro_id" => $datos["registro_id"],
                    "producto_id" => $item["producto_id"],
                    "tipo" => $item["tipo"],
                    "descripcion_externo" => $item["descripcion_externo"],
                    "cantidad" => $item["cantidad"],
                    "precio_unitario" => $item["precio_unitario"],
                    "total" => $item["total"],
                ]);

                // descontar stock si es producto
                if ($producto->tipo_producto->tipo === 'PRODUCTO') {
                    $this->kardexProductoService->registroEgreso("REGISTRO SERVICIO", $producto, $item["cantidad"], $item["precio_unitario"], "VENTA DE PRODUCTO", $registro_servicio->id);
                }
            }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN SERVICIO", $registro_servicio);

        return $registro_servicio;
    }

    /**
     * Eliminar registro_servicio
     *
     * @param RegistroServicio $registro_servicio
     * @return boolean
     */
    public function eliminar(RegistroServicio $registro_servicio): bool
    {
        // no eliminar users predeterminados para el funcionamiento del sistema
        $old_registro = clone $registro_servicio;
        $registro_servicio->delete();
        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UN SERVICIO", $old_registro, null, ["servicio_detalles"]);
        return true;
    }
}

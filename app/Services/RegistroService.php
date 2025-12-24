<?php

namespace App\Services;

use App\Models\Habitacion;
use App\Models\Registro;
use App\Models\RegistroServicio;
use App\Models\Transferencia;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\UploadedFile;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class RegistroService
{
    private $modulo = "REGISTROS";
    public function __construct(
        private HistorialAccionService $historialAccionService,
        private HabitacionService $habitacionService,
        private MonedaService $monedaService,
        private RegistroServicioService $registroServicioService
    ) {}


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
        // Log::debug($datos);
        $monedaOficial = $this->monedaService->getMonedaPrincipal();
        if (!$monedaOficial) {
            throw new Exception("No se configuro la moneda oficial, contactese con el Administrador");
        }
        $registro = Registro::create([
            "habitacion_id" => $datos["habitacion_id"],
            "cliente_id" => $datos["cliente_id"],
            "desayuno" => $datos["desayuno"],
            "fecha_entrada" => $datos["fecha_entrada"],
            "hora_entrada" => $datos["hora_entrada"],
            "dias_estadia" => $datos["dias_estadia"],
            "fecha_salida" => $datos["fecha_salida"],
            "hora_salida" => $datos["hora_salida"],
            "cd" => $datos["cd"],
            "total" => $datos["total"],
            "adelanto" => $datos["adelanto"],
            "saldo" => $datos["saldo"],
            "garantia" => $datos["garantia"],
            "moneda_id" => $monedaOficial->id,
            "tc" => $datos["tc"] ?? 0,
            "cd_tc" => $datos["tc"] && $datos["tc"] == 1 ? $datos["cd_tc"] : NULL,
            "total_tc" => $datos["tc"] && $datos["tc"] == 1 ? $datos["total_tc"] : NULL,
            "adelanto_tc" => $datos["tc"] && $datos["tc"] == 1 ? $datos["adelanto_tc"] : NULL,
            "saldo_tc" => $datos["tc"] && $datos["tc"] == 1 ? $datos["saldo_tc"] : NULL,
            "garantia_tc" => $datos["tc"] && $datos["tc"] == 1 ? $datos["garantia_tc"] : NULL,
            "moneda_id_tc" => $datos["tc"] && $datos["tc"] == 1 ? $datos["moneda_id_tc"] : $monedaOficial->id,
            "tipo" => $datos["tipo"],
            "user_id" => Auth::user()->id,
        ]);


        // verificar si es tipo NORMAL, registrar servicio de hospedaje
        if ($datos["tipo"] == "NORMAL") {
            $this->registroServicioService->crear([
                "registro_id" => $registro->id,
                "tipo" => "HOSPEDAJE",
                "total" => $datos["total"],
                "cancelado" => $datos["adelanto"],
                "saldo" => $datos["saldo"],
                "tc" => $datos["tc"] ?? 0,
                "total_tc" => $datos["total_tc"] ?? null,
                "cancelado_tc" => $datos["adelanto_tc"] ?? null,
                "saldo_tc" => $datos["saldo_tc"] ?? null,
                "moneda_id_tc" => $datos["moneda_id_tc"] ?? null,
                "tipo_cambio_id" => $datos["tipo_cambio_id"] ?? null,
                "efectivo_banco" => $datos["efectivo_banco"] ?? null,
            ]);
        }


        // TODO: VERIFICAR RESERVAS CON FECHAS


        // habitacion ocupada
        $this->habitacionService->actualizarEstado($registro->habitacion_id, 1);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REALIZÓ UN REGISTRO", $registro);

        return $registro;
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
        $old_registro = clone $registro;
        $old_registro->loadMissing(["cliente"]);
        // Log::debug($datos);
        $monedaOficial = $this->monedaService->getMonedaPrincipal();
        if (!$monedaOficial) {
            throw new Exception("No se configuro la moneda oficial, contactese con el Administrador");
        }
        $registro->update([
            "cliente_id" => $datos["cliente_id"],
            "desayuno" => $datos["desayuno"],
            "fecha_entrada" => $datos["fecha_entrada"],
            "hora_entrada" => $datos["hora_entrada"],
            "dias_estadia" => $datos["dias_estadia"],
            "fecha_salida" => $datos["fecha_salida"],
            "hora_salida" => $datos["hora_salida"],
            "cd" => $datos["cd"],
            "total" => $datos["total"],
            // "adelanto" => $datos["adelanto"],
            "saldo" => $datos["saldo"],
            "garantia" => $datos["garantia"],
            // "moneda_id" => $monedaOficial->id,
            "tc" => $datos["tc"] ?? 0,
            "cd_tc" => $datos["tc"] && $datos["tc"] == 1 ? $datos["cd_tc"] : NULL,
            "total_tc" => $datos["tc"] && $datos["tc"] == 1 ? $datos["total_tc"] : NULL,
            "adelanto_tc" => $datos["tc"] && $datos["tc"] == 1 ? $datos["adelanto_tc"] : NULL,
            "saldo_tc" => $datos["tc"] && $datos["tc"] == 1 ? $datos["saldo_tc"] : NULL,
            "garantia_tc" => $datos["tc"] && $datos["tc"] == 1 ? $datos["garantia_tc"] : NULL,
            "moneda_id_tc" => $datos["tc"] && $datos["tc"] == 1 ? $datos["moneda_id_tc"] : $monedaOficial->id,
            "tipo" => $datos["tipo"],
            // "user_id" => Auth::user()->id,
        ]);

        // TODO: VERIFICAR RESERVAS CON FECHAS

        // verificar si es tipo NORMAL, registrar servicio de hospedaje
        if ($old_registro->tipo == 'RESERVA' &&  $datos["tipo"] == "NORMAL") {
            $this->registroServicioService->crear([
                "registro_id" => $registro->id,
                "tipo" => "HOSPEDAJE",
                "total" => $datos["total"],
                "cancelado" => $datos["adelanto"],
                "saldo" => $datos["saldo"],
                "tc" => $datos["tc"] ?? 0,
                "total_tc" => $datos["total_tc"] ?? null,
                "cancelado_tc" => $datos["adelanto_tc"] ?? null,
                "saldo_tc" => $datos["saldo_tc"] ?? null,
                "moneda_id_tc" => $datos["moneda_id_tc"] ?? null,
                "tipo_cambio_id" => $datos["tipo_cambio_id"] ?? null,
            ]);
        }


        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN REGISTRO", $old_registro, $registro, ["cliente"]);

        return $registro;
    }


    public function transferencia(Registro $registro, array $datos = [])
    {
        Log::debug($datos);
        if (!isset($datos["habitacion_destino_id"]) || !$datos["habitacion_destino_id"] || $datos["habitacion_destino_id"] == 0) {
            throw new Exception("Ocurrió un error al actualizar la transferencia");
        }

        $old_registro = clone $registro;
        $old_registro->loadMissing(["cliente"]);

        Transferencia::create([
            "registro_id" => $registro->id,
            "habitacion_id" => $registro->habitacion_id,
            "habitacion_destino_id" => $datos["habitacion_destino_id"],
            "motivo" => mb_strtoupper($datos["motivo"]),
            "fecha" => date("Y-m-d"),
        ]);

        // habitacion antes
        $habitacionAntes = Habitacion::findOrFail($registro->habitacion_id);
        $habitacionAntes->estado = 0;
        $habitacionAntes->save();

        $registro->update([
            "habitacion_id" => $datos["habitacion_destino_id"]
        ]);

        // TODO: VERIFICAR RESERVAS DE LA HABITACION CON FECHAS
        // si existe conflicto con la fecha de salida con reservas

        // habitacion unevo
        $habitacionNuevo = Habitacion::findOrFail($datos["habitacion_destino_id"]);
        $habitacionNuevo->estado = 1;
        $habitacionNuevo->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REALIZÓ UNA TRANSFERENCIA DE HABITACIÓN", $old_registro, $registro, ["cliente"]);

        return $registro;
    }

    public function finalizar_registro(Registro $registro)
    {
        $saldo = RegistroServicio::where("registro_id", $registro->id)
            ->sum("saldo");

        if ($saldo > 0) {
            throw new Exception("No se pudo finalizar el registro porque existen saldos pendientes");
        }

        $registro->habitacion->estado = 3;
        $registro->habitacion->save();
        $registro->estado = 0;
        $registro->save();

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
        // TODO: registrar EGRESO en CAJA si existe un adelanto

        $old_registro = clone $registro;
        $registro->status = 0;
        $registro->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL REGISTRO DE UN REGISTRO", $old_registro, $registro);
        return true;
    }


    public function verificarDiasAdicionales(Registro $registro)
    {
        $fechaSalida = Carbon::parse($registro->fecha_salida);
        $ahora = Carbon::now('America/La_Paz');
        $hora = $ahora->hour;
        $fecha_txt = $ahora->toDateString();
        $hora_txt = $ahora->toTimeString();

        // Si no se pasó la fecha, no hay días adicionales
        if ($ahora->lte($fechaSalida)) {
            return [0, $fecha_txt, $hora_txt];
        }

        // Días completos de diferencia
        $diasAdicionales = $fechaSalida->startOfDay()->diffInDays($ahora->startOfDay());

        // Si ya pasó el mediodía, suma 1 día más
        if ($hora >= 12) {
            $diasAdicionales++;
        }
        return [$diasAdicionales, $fecha_txt, $hora_txt]; // dias, fecha, hora
    }
}

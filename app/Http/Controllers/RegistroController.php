<?php

namespace App\Http\Controllers;

use App\Http\Requests\RegistroStoreRequest;
use App\Http\Requests\RegistroUpdateRequest;
use App\Models\Registro;
use App\Services\RegistroService;
use App\Services\RegistroServicioService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use Inertia\Response as InertiaResponse;
use PDF;

use Carbon\Carbon;

class RegistroController extends Controller
{
    public function __construct(private RegistroService $registroService, private RegistroServicioService $registro_servicio_service) {}

    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/Registros/Index");
    }


    public function historial(): InertiaResponse
    {
        return Inertia::render("Admin/Registros/Historial");
    }

    public function reservas()
    {
        return Inertia::render("Admin/Registros/Reservas");
    }


    public function listadoSalientesHoy(Request $request): JsonResponse
    {
        return response()->JSON([
            "registros" => $this->registroService->listadoSalientesHoy($request->input("serach", ""))
        ]);
    }

    public function listadoReservasHoy(Request $request): JsonResponse
    {
        return response()->JSON([
            "registros" => $this->registroService->listadoReservasHoy($request->input("serach", ""))
        ]);
    }


    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $orderBy = $request->orderBy;
        $orderAsc = $request->orderAsc;

        $columnsSerachLike = ["numero_habitacion", "tipo_habitacions.nombre"];
        $columnsFilter = [];
        $columnsBetweenFilter = [];
        $arrayOrderBy = [];
        if ($orderBy && $orderAsc) {
            $arrayOrderBy = [
                [$orderBy, $orderAsc]
            ];
        }

        $registros = $this->registroService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $registros->items(),
            "total" => $registros->total(),
            "lastPage" => $registros->lastPage()
        ]);
    }

    public function reservasPaginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $orderBy = $request->orderBy;
        $orderAsc = $request->orderAsc;

        $columnsSerachLike = ["numero_habitacion", "tipo_habitacions.nombre"];
        $columnsFilter = [];
        $columnsBetweenFilter = [];
        $arrayOrderBy = [];
        if ($orderBy && $orderAsc) {
            $arrayOrderBy = [
                [$orderBy, $orderAsc]
            ];
        }

        $registros = $this->registroService->reservasPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $registros->items(),
            "total" => $registros->total(),
            "lastPage" => $registros->lastPage()
        ]);
    }

    /**
     * Store registro
     *
     * @param RegistroStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(RegistroStoreRequest $request): RedirectResponse|Response|JsonResponse
    {
        DB::beginTransaction();
        try {
            $registro = $this->registroService->crear($request->validated());
            DB::commit();
            if ($registro->tipo == 'RESERVA') {

                return redirect()->route("registros.reservas")->with("bien", "Registro realizado")
                    ->with("codigoReserva", $registro->cod_reserva);
            }
            $url = route('registros.checkin', $registro->id);
            return redirect()->route("registros.index")->with("bien", "Registro realizado")
                ->with("urlPdf", $url);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Update registro
     *
     * @param Registro $registro
     * @param RegistroUpdateRequest $request
     * @return RedirectResponse|Response
     */
    public function update(Registro $registro, RegistroUpdateRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $registro =  $this->registroService->actualizar($request->validated(), $registro);
            DB::commit();
            if ($registro->tipo == 'RESERVA') {
                return redirect()->route("registros.reservas")->with("bien", "Registro realizado")
                    ->with("codigoReserva", $registro->cod_reserva);
            }
            return redirect()->route("registros.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function finalizar(Registro $registro)
    {
        // registrar dias adicionales
        $array_verifica = $this->registroService->verificarDiasAdicionales($registro);

        if ($array_verifica[0] > 0) {
            $dias_adicionales = $array_verifica[0];
            $ahora = Carbon::now('America/La_Paz');
            $existe = $registro->registro_servicios()
                ->where('tipo', 'HOSPEDAJE')
                ->whereDate('created_at', $ahora->toDateString())
                ->whereTime('created_at', '>=', '12:00:00')
                ->exists();
            if (!$existe) {
                // registrar servicio
                $this->registro_servicio_service->crear([
                    "registro_id" => $registro->id,
                    "tipo" => "HOSPEDAJE",
                    "cantidad" => $dias_adicionales,
                    "total" => (float)$registro->cd * (float)$dias_adicionales,
                    "cancelado" => 0,
                    "saldo" => $registro->cd * $dias_adicionales,
                    "tc" => 0,
                    "efectivo_banco" => "",
                ]);
                $registro->dias_estadia = (int)$registro->dias_estadia + $dias_adicionales;
                $registro->total = (float)$registro->cd * (float)$registro->dias_estadia;
                $registro->saldo = (float)$registro->total - (float)$registro->adelanto;
                $registro->fecha_salida = $array_verifica[1];
                $registro->hora_salida = $array_verifica[2];
                $registro->save();
            }
        }

        $registro = $registro->load(["habitacion.tipo_habitacion", "cliente", "registro_servicios"]);

        return Inertia::render("Admin/Registros/Finalizar", compact("registro"));
    }

    public function finalizar_registro(Registro $registro)
    {
        DB::beginTransaction();
        try {
            $registro =  $this->registroService->finalizar_registro($registro);
            DB::commit();
            $url = route('registros.checkout', $registro->id);
            return response()->JSON([
                "url" => $url,
                "registro" => $registro,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function transferencia(Registro $registro, Request $request)
    {
        DB::beginTransaction();
        try {
            $request->validate([
                "habitacion_destino_id" => "required",
                "motivo" => "required|min:2",
            ], [
                "habitacion_destino_id.required" => "Debes seleccionar la habitación de transferencia",
                "motivo.required" => "Debes indicar el motivo",
                "motivo.min" => "Debes ingresar al menos :min caracteres"
            ]);
            $registro =  $this->registroService->transferencia($registro, $request->only(["motivo", "habitacion_destino_id"]));
            DB::commit();
            return redirect()->route("registros.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function verificaHabitacion(Request $request)
    {
        $habitacion_id = $request->habitacion_id;
        $registro = Registro::where("habitacion_id", $habitacion_id)
            ->where("estado", 1)->get()->last();

        $array_verifica = $this->registroService->verificarDiasAdicionales($registro);

        if ($array_verifica[1] == $registro->fecha_salida) {
            $registro->habitacion->estado = 4;
        }
        if ($array_verifica[0] > 0) {
            $registro->habitacion->estado = 1;
        }
        $registro->habitacion->save();

        return response()->JSON($registro->load(["cliente:id,nombre,paterno,materno,ci,ci_exp"]));
    }

    public function actualizaGarantia(Registro $registro, Request $request)
    {
        $registro->dev_garantia = $request->dev_garantia;

        $registro->save();
        return response()->JSON(true);
    }

    public function atenderReserva(Registro $registro)
    {
        $habitacion = $registro->habitacion;
        $habitacion->estado = 1;
        $habitacion->save();
        $registro->estado = 1;
        $registro->save();
        return response()->JSON(true);
    }

    /**
     * Delete registro
     *
     * @param Registro $registro
     * @return JsonResponse|Response
     */
    public function destroy(Registro $registro): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->registroService->eliminar($registro);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function checkin(Registro $registro)
    {
        $nro_registro = $registro->id;
        if ($nro_registro < 10) {
            $nro_registro = '00000' . $nro_registro;
        } elseif ($nro_registro < 100) {
            $nro_registro = '0000' . $nro_registro;
        } elseif ($nro_registro < 1000) {
            $nro_registro = '000' . $nro_registro;
        } elseif ($nro_registro < 10000) {
            $nro_registro = '00' . $nro_registro;
        } elseif ($nro_registro < 100000) {
            $nro_registro = '0' . $nro_registro;
        }
        $pdf = PDF::loadView('reportes.checkin', compact('registro', 'nro_registro'))->setPaper('letter', 'portrait');
        return $pdf->stream('CheckIn.pdf');
    }
    public function checkout(Registro $registro)
    {
        $nro_registro = $registro->id;
        if ($nro_registro < 10) {
            $nro_registro = '00000' . $nro_registro;
        } elseif ($nro_registro < 100) {
            $nro_registro = '0000' . $nro_registro;
        } elseif ($nro_registro < 1000) {
            $nro_registro = '000' . $nro_registro;
        } elseif ($nro_registro < 10000) {
            $nro_registro = '00' . $nro_registro;
        } elseif ($nro_registro < 100000) {
            $nro_registro = '0' . $nro_registro;
        }
        $pdf = PDF::loadView('reportes.checkout', compact('registro', 'nro_registro'))->setPaper('letter', 'portrait');
        return $pdf->stream('CheckOut.pdf');
    }
}

<?php

namespace App\Http\Controllers;

use App\Http\Requests\RegistroStoreRequest;
use App\Http\Requests\RegistroUpdateRequest;
use App\Models\Registro;
use App\Services\RegistroService;
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


class RegistroController extends Controller
{
    public function __construct(private RegistroService $registroService) {}

    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/Registros/Index");
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
            return redirect()->route("registros.index")->with("bien", "Registro realizado");
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
            return redirect()->route("registros.index")->with("bien", "Registro actualizado");
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
        $registro = Registro::where("habitacion_id", $habitacion_id)->get()->first();
        return response()->JSON($registro->load(["cliente:id,nombre,paterno,materno,ci,ci_exp"]));
    }
}

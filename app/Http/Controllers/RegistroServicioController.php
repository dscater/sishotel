<?php

namespace App\Http\Controllers;

use App\Http\Requests\RegistroServicioStoreRequest;
use App\Models\Registro;
use App\Models\RegistroServicio;
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

class RegistroServicioController extends Controller
{
    public function __construct(private RegistroServicioService $registro_servicio_service) {}


    public function listadoByRegistroId(Request $request)
    {
        return response()->JSON([
            "registro" => Registro::findOrFail($request->get("registro_id")),
            "registro_servicios" => $this->registro_servicio_service->listadoByRegistroId($request->get("registro_id")),
        ]);
    }

    /**
     * Store registro_servicio
     *
     * @param RegistroServicioStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(RegistroServicioStoreRequest $request): RedirectResponse|Response|JsonResponse
    {
        DB::beginTransaction();
        try {
            $registro_servicio = $this->registro_servicio_service->crear($request->validated());
            DB::commit();
            return redirect()->route("registros.index")->with("bien", "Registro realizado");
            // return redirect()->route("registro_servicios.index")->with("bien", "RegsitroServicio realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
}

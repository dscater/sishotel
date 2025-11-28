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
}

<?php

namespace App\Http\Controllers;

use App\Http\Requests\TipoCambioStoreRequest;
use App\Http\Requests\TipoCambioUpdateRequest;
use App\Models\TipoCambio;
use App\Services\TipoCambioService;
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

class TipoCambioController extends Controller
{
    public function __construct(private TipoCambioService $tipo_cambioService) {}

    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/TipoCambios/Index");
    }

    public function listado(Request $request): JsonResponse
    {
        $tipo_cambios = TipoCambio::select("tipo_cambios.*");

        $tipo_cambios = $tipo_cambios->get();
        return response()->JSON([
            "tipo_cambios" => $tipo_cambios
        ]);
    }

    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $orderByCol = $request->orderByCol;
        $desc = $request->desc;

        $columnsSerachLike = ["nombre", "paterno", "materno", "ci", "fono", "dir"];
        $columnsFilter = [];
        $columnsBetweenFilter = [];
        $arrayOrderBy = [];
        if ($orderByCol && $desc) {
            $arrayOrderBy = [
                [$orderByCol, $desc]
            ];
        }

        $personas = $this->tipo_cambioService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $personas->items(),
            "total" => $personas->total(),
            "lastPage" => $personas->lastPage()
        ]);
    }

    /**
     * Store tipo_cambio
     *
     * @param TipoCambioStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(TipoCambioStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->tipo_cambioService->crear($request->validated());
            DB::commit();
            return redirect()->route("tipo_cambios.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(TipoCambio $tipo_cambio)
    {
        return response()->JSON($tipo_cambio);
    }

    /**
     * Update tipo_cambio
     *
     * @param TipoCambio $tipo_cambio
     * @param TipoCambioUpdateRequest $request
     * @return RedirectResponse|Response
     */
    public function update(TipoCambio $tipo_cambio, TipoCambioUpdateRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->tipo_cambioService->actualizar($request->validated(), $tipo_cambio);
            DB::commit();
            return redirect()->route("tipo_cambios.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Delete tipo_cambio
     *
     * @param TipoCambio $tipo_cambio
     * @return JsonResponse|Response
     */
    public function destroy(TipoCambio $tipo_cambio): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->tipo_cambioService->eliminar($tipo_cambio);
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
}

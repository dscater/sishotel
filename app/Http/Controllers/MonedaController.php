<?php

namespace App\Http\Controllers;

use App\Http\Requests\MonedaStoreRequest;
use App\Http\Requests\MonedaUpdateRequest;
use App\Models\Moneda;
use App\Services\MonedaService;
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

class MonedaController extends Controller
{
    public function __construct(private MonedaService $monedaService) {}

    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/Monedas/Index");
    }

    public function listado(Request $request): JsonResponse
    {
        $monedas = Moneda::select("monedas.*");

        if (isset($request->sinOficial) && $request->sinOficial == true) {
            $monedas->where("oficial", 0);
        }


        $monedas = $monedas->get();
        return response()->JSON([
            "monedas" => $monedas
        ]);
    }

    public function getMonedaOficial()
    {
        $oficial = Moneda::where("oficial", 1)->get()->first();
        return response()->JSON($oficial);
    }

    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $orderByCol = $request->orderByCol;
        $desc = $request->desc;

        $columnsSerachLike = ["nombre", "codigo", "simbolo"];
        $columnsFilter = [];
        $columnsBetweenFilter = [];
        $arrayOrderBy = [];
        if ($orderByCol && $desc) {
            $arrayOrderBy = [
                [$orderByCol, $desc]
            ];
        }

        $personas = $this->monedaService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $personas->items(),
            "total" => $personas->total(),
            "lastPage" => $personas->lastPage()
        ]);
    }

    /**
     * Store moneda
     *
     * @param MonedaStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(MonedaStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->monedaService->crear($request->validated());
            DB::commit();
            return redirect()->route("monedas.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Moneda $moneda)
    {
        return response()->JSON($moneda);
    }

    /**
     * Update moneda
     *
     * @param Moneda $moneda
     * @param MonedaUpdateRequest $request
     * @return RedirectResponse|Response
     */
    public function update(Moneda $moneda, MonedaUpdateRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->monedaService->actualizar($request->validated(), $moneda);
            DB::commit();
            return redirect()->route("monedas.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Delete moneda
     *
     * @param Moneda $moneda
     * @return JsonResponse|Response
     */
    public function destroy(Moneda $moneda): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->monedaService->eliminar($moneda);
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

<?php

namespace App\Http\Controllers;

use App\Models\MovimientoCaja;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;
use League\Config\Exception\ValidationException;
use App\Http\Requests\CajaStoreRequest;
use App\Http\Requests\CajaUpdateRequest;
use App\Models\Caja;
use App\Services\CajaService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Response as InertiaResponse;

class CajaController extends Controller
{

    public function __construct(private CajaService $cajaService) {}

    public function cierre_caja()
    {
        return Inertia::render("Admin/Cajas/CierreCaja");
    }

    public function verificaCajaAbierta()
    {
        return response()->JSON($this->cajaService->verificarCajaAbierta());
    }
    public function aperturarCaja()
    {
        DB::beginTransaction();
        try {
            $caja = $this->cajaService->aperturarCaja();
            DB::commit();
            return response()->JSON($caja);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function movimiento_cajas(Request $request)
    {
        return response()->JSON(MovimientoCaja::where("caja_id", $request->caja_id)->get());
    }


    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/Cajas/Index");
    }

    public function listado(Request $request): JsonResponse
    {
        $cajas = Caja::select("cajas.*");
        $cajas = $cajas->get();
        return response()->JSON([
            "cajas" => $cajas
        ]);
    }

    public function getCajaOficial()
    {
        $oficial = Caja::where("oficial", 1)->get()->first();
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

        $personas = $this->cajaService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $personas->items(),
            "total" => $personas->total(),
            "lastPage" => $personas->lastPage()
        ]);
    }

    /**
     * Store caja
     *
     * @param CajaStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(CajaStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->cajaService->crear($request->validated());
            DB::commit();
            return redirect()->route("cajas.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Caja $caja)
    {
        return response()->JSON($caja);
    }

    /**
     * Update caja
     *
     * @param Caja $caja
     * @param CajaUpdateRequest $request
     * @return RedirectResponse|Response
     */
    public function update(Caja $caja, CajaUpdateRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->cajaService->actualizar($request->validated(), $caja);
            DB::commit();
            return redirect()->route("cajas.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Delete caja
     *
     * @param Caja $caja
     * @return JsonResponse|Response
     */
    public function destroy(Caja $caja): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->cajaService->eliminar($caja);
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

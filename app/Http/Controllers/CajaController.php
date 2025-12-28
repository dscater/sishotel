<?php

namespace App\Http\Controllers;

use App\Models\MovimientoCaja;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;
use Illuminate\Validation\ValidationException;
use App\Http\Requests\CajaStoreRequest;
use App\Http\Requests\CajaUpdateRequest;
use App\Models\Caja;
use App\Models\Moneda;
use App\Services\CajaService;
use App\Services\MovimientoCajaService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Response as InertiaResponse;

class CajaController extends Controller
{

    public function __construct(private CajaService $cajaService, private MovimientoCajaService $movimiento_caja_service) {}

    public function cierre_caja()
    {
        return Inertia::render("Admin/Cajas/CierreCaja");
    }

    public function verificaCajaAbierta()
    {
        $caja = $this->cajaService->verificarCajaAbierta();
        if ($caja) {
            $caja = $caja->load(["user:id,usuario,nombre,paterno,materno"]);
        }

        return response()->JSON([
            "caja" => $caja,
        ]);
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

    public function cerrarCaja(Request $request)
    {
        DB::beginTransaction();
        try {
            $caja = $this->cajaService->cerrarCaja($request->get("caja_id", ""), $request->get("fecha_cierre", ""), $request->get("hora_cierre", ""));
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

        $caja_id = $request->caja_id;
        $movimiento_cajas = MovimientoCaja::where("caja_id", $caja_id)->get();

        $saldos_monedas = [];
        if (!$caja_id) {
            $ultima_caja = MovimientoCaja::get()->last();
            $caja_id = $ultima_caja->caja_id;
        }

        // saldos 
        if ($caja_id) {
            $saldos_monedas = MovimientoCaja::join('monedas', 'monedas.id', '=', 'movimiento_cajas.moneda_id_tc')
                ->select(
                    'moneda_id_tc',
                    'monedas.simbolo',
                    DB::raw("SUM(CASE WHEN tipo = 'INGRESO' THEN monto_tc ELSE 0 END) as ingresos"),
                    DB::raw("SUM(CASE WHEN tipo = 'EGRESO' THEN monto_tc ELSE 0 END) as egresos")
                )
                ->groupBy('moneda_id_tc', 'monedas.simbolo')
                ->get()
                ->map(function ($item) {
                    return [
                        'moneda_id_tc' => $item->moneda_id_tc,
                        'simbolo' => $item->simbolo,
                        'saldo' => number_format((float)$item->ingresos - (float)$item->egresos, 2, ".", "")
                    ];
                });
        }
        return response()->JSON([
            "movimiento_cajas" => $movimiento_cajas,
            "saldos_monedas" => $saldos_monedas
        ]);
    }


    public function index(): InertiaResponse
    {
        $saldos_monedas = MovimientoCaja::join('monedas', 'monedas.id', '=', 'movimiento_cajas.moneda_id_tc')
            ->select(
                'moneda_id_tc',
                'monedas.simbolo',
                DB::raw("SUM(CASE WHEN tipo = 'INGRESO' THEN monto_tc ELSE 0 END) as ingresos"),
                DB::raw("SUM(CASE WHEN tipo = 'EGRESO' THEN monto_tc ELSE 0 END) as egresos")
            )
            ->groupBy('moneda_id_tc', 'monedas.simbolo')
            ->get()
            ->map(function ($item) {
                return [
                    'moneda_id_tc' => $item->moneda_id_tc,
                    'simbolo' => $item->simbolo,
                    'saldo' => number_format((float)$item->ingresos - (float)$item->egresos, 2, ".", ""),
                ];
            });

        return Inertia::render("Admin/Cajas/Index", compact("saldos_monedas"));
    }

    public function listado(Request $request): JsonResponse
    {
        $cajas = Caja::select("cajas.*");
        $cajas = $cajas->get();
        return response()->JSON([
            "cajas" => $cajas
        ]);
    }

    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $orderBy = $request->orderBy;
        $orderAsc = $request->orderAsc;

        $columnsSerachLike = ["nombre", "codigo", "simbolo"];
        $columnsFilter = [];
        $columnsBetweenFilter = [];
        $arrayOrderBy = [];
        if ($orderBy && $orderAsc) {
            $arrayOrderBy = [
                [$orderBy, $orderAsc]
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
            $this->movimiento_caja_service->crear($request->validated());
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

<?php

namespace App\Http\Controllers;

use App\Http\Requests\EgresoProductoStoreRequest;
use App\Http\Requests\EgresoProductoUpdateRequest;
use App\Models\EgresoProducto;
use App\Services\EgresoProductoService;
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

class EgresoProductoController extends Controller
{
    public function __construct(private EgresoProductoService $egreso_productoService) {}

    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/EgresoProductos/Index");
    }

    public function listado(Request $request): JsonResponse
    {
        $egreso_productos = EgresoProducto::select("egreso_productos.*");

        $egreso_productos = $egreso_productos->get();
        return response()->JSON([
            "egreso_productos" => $egreso_productos
        ]);
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

        $personas = $this->egreso_productoService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $personas->items(),
            "total" => $personas->total(),
            "lastPage" => $personas->lastPage()
        ]);
    }

    /**
     * Store egreso_producto
     *
     * @param EgresoProductoStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(EgresoProductoStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->egreso_productoService->crear($request->validated());
            DB::commit();
            return redirect()->route("egreso_productos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(EgresoProducto $egreso_producto)
    {
        return response()->JSON($egreso_producto);
    }

    /**
     * Update egreso_producto
     *
     * @param EgresoProducto $egreso_producto
     * @param EgresoProductoUpdateRequest $request
     * @return RedirectResponse|Response
     */
    public function update(EgresoProducto $egreso_producto, EgresoProductoUpdateRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->egreso_productoService->actualizar($request->validated(), $egreso_producto);
            DB::commit();
            return redirect()->route("egreso_productos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Delete egreso_producto
     *
     * @param EgresoProducto $egreso_producto
     * @return JsonResponse|Response
     */
    public function destroy(EgresoProducto $egreso_producto): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->egreso_productoService->eliminar($egreso_producto);
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

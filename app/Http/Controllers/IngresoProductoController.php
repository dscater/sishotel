<?php

namespace App\Http\Controllers;

use App\Http\Requests\IngresoProductoStoreRequest;
use App\Http\Requests\IngresoProductoUpdateRequest;
use App\Models\IngresoProducto;
use App\Services\IngresoProductoService;
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

class IngresoProductoController extends Controller
{
    public function __construct(private IngresoProductoService $ingreso_productoService) {}

    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/IngresoProductos/Index");
    }

    public function listado(Request $request): JsonResponse
    {
        $ingreso_productos = IngresoProducto::select("ingreso_productos.*");

        $ingreso_productos = $ingreso_productos->get();
        return response()->JSON([
            "ingreso_productos" => $ingreso_productos
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

        $personas = $this->ingreso_productoService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $personas->items(),
            "total" => $personas->total(),
            "lastPage" => $personas->lastPage()
        ]);
    }

    /**
     * Store ingreso_producto
     *
     * @param IngresoProductoStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(IngresoProductoStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->ingreso_productoService->crear($request->validated());
            DB::commit();
            return redirect()->route("ingreso_productos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(IngresoProducto $ingreso_producto)
    {
        return response()->JSON($ingreso_producto);
    }

    /**
     * Update ingreso_producto
     *
     * @param IngresoProducto $ingreso_producto
     * @param IngresoProductoUpdateRequest $request
     * @return RedirectResponse|Response
     */
    public function update(IngresoProducto $ingreso_producto, IngresoProductoUpdateRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->ingreso_productoService->actualizar($request->validated(), $ingreso_producto);
            DB::commit();
            return redirect()->route("ingreso_productos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Delete ingreso_producto
     *
     * @param IngresoProducto $ingreso_producto
     * @return JsonResponse|Response
     */
    public function destroy(IngresoProducto $ingreso_producto): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->ingreso_productoService->eliminar($ingreso_producto);
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

<?php

namespace App\Http\Controllers;

use App\Http\Requests\TipoProductoStoreRequest;
use App\Http\Requests\TipoProductoUpdateRequest;
use App\Models\TipoProducto;
use App\Services\TipoProductoService;
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

class TipoProductoController extends Controller
{
    public function __construct(private TipoProductoService $tipo_productoService) {}

    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/TipoProductos/Index");
    }

    public function listado(Request $request): JsonResponse
    {
        $tipo_productos = TipoProducto::select("tipo_productos.*");

        if (isset($request->sinOficial) && $request->sinOficial == true) {
            $tipo_productos->where("oficial", 0);
        }

        $tipo_productos = $tipo_productos->get();
        return response()->JSON([
            "tipo_productos" => $tipo_productos
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

        $personas = $this->tipo_productoService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $personas->items(),
            "total" => $personas->total(),
            "lastPage" => $personas->lastPage()
        ]);
    }

    /**
     * Store tipo_producto
     *
     * @param TipoProductoStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(TipoProductoStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->tipo_productoService->crear($request->validated());
            DB::commit();
            return redirect()->route("tipo_productos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(TipoProducto $tipo_producto)
    {
        return response()->JSON($tipo_producto);
    }

    /**
     * Update tipo_producto
     *
     * @param TipoProducto $tipo_producto
     * @param TipoProductoUpdateRequest $request
     * @return RedirectResponse|Response
     */
    public function update(TipoProducto $tipo_producto, TipoProductoUpdateRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->tipo_productoService->actualizar($request->validated(), $tipo_producto);
            DB::commit();
            return redirect()->route("tipo_productos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Delete tipo_producto
     *
     * @param TipoProducto $tipo_producto
     * @return JsonResponse|Response
     */
    public function destroy(TipoProducto $tipo_producto): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->tipo_productoService->eliminar($tipo_producto);
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

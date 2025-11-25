<?php

namespace App\Http\Controllers;

use App\Http\Requests\TipoHabitacionStoreRequest;
use App\Http\Requests\TipoHabitacionUpdateRequest;
use App\Models\TipoHabitacion;
use App\Services\TipoHabitacionService;
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

class TipoHabitacionController extends Controller
{
    public function __construct(private TipoHabitacionService $tipo_habitacionService) {}

    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/TipoHabitacions/Index");
    }

    public function listado(Request $request): JsonResponse
    {
        $tipo_habitacions = TipoHabitacion::select("tipo_habitacions.*");

        $tipo_habitacions = $tipo_habitacions->get();
        return response()->JSON([
            "tipo_habitacions" => $tipo_habitacions
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

        $personas = $this->tipo_habitacionService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $personas->items(),
            "total" => $personas->total(),
            "lastPage" => $personas->lastPage()
        ]);
    }

    /**
     * Store tipo_habitacion
     *
     * @param TipoHabitacionStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(TipoHabitacionStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->tipo_habitacionService->crear($request->validated());
            DB::commit();
            return redirect()->route("tipo_habitacions.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(TipoHabitacion $tipo_habitacion)
    {
        return response()->JSON($tipo_habitacion);
    }

    /**
     * Update tipo_habitacion
     *
     * @param TipoHabitacion $tipo_habitacion
     * @param TipoHabitacionUpdateRequest $request
     * @return RedirectResponse|Response
     */
    public function update(TipoHabitacion $tipo_habitacion, TipoHabitacionUpdateRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->tipo_habitacionService->actualizar($request->validated(), $tipo_habitacion);
            DB::commit();
            return redirect()->route("tipo_habitacions.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Delete tipo_habitacion
     *
     * @param TipoHabitacion $tipo_habitacion
     * @return JsonResponse|Response
     */
    public function destroy(TipoHabitacion $tipo_habitacion): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->tipo_habitacionService->eliminar($tipo_habitacion);
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

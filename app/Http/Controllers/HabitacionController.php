<?php

namespace App\Http\Controllers;

use App\Http\Requests\HabitacionStoreRequest;
use App\Http\Requests\HabitacionUpdateRequest;
use App\Models\Habitacion;
use App\Services\HabitacionService;
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

class HabitacionController extends Controller
{
    public function __construct(private HabitacionService $habitacionService) {}

    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/Habitacions/Index");
    }

    public function listado(Request $request): JsonResponse
    {
        $habitacions = Habitacion::select("habitacions.*");

        if (isset($request->tipo) && $request->tipo) {
            $habitacions->where("tipo", $request->tipo);
        }

        $habitacions = $habitacions->where("status", 1)->get();
        return response()->JSON([
            "habitacions" => $habitacions
        ]);
    }

    public function listadoCheckIn(Request $request)
    {
        $tipoHabitaciones = $request->input('tipo_habitacion_id', []); // será un array
        $capacidad = $request->input('capacidad'); // número o null

        $habitacions = Habitacion::with(["tipo_habitacion"])->select("habitacions.*");

        if (!empty($tipoHabitaciones)) {
            $habitacions->whereIn('tipo_habitacion_id', $tipoHabitaciones);
        }

        if (isset($capacidad) && $capacidad) {
            $habitacions->where("capacidad", $capacidad);
        }

        $habitacions = $habitacions->where("status", 1)
            ->where("estado", 0)
            ->get();
        return response()->JSON([
            "habitacions" => $habitacions
        ]);
    }

    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $orderByCol = $request->orderByCol;
        $desc = $request->desc;

        $columnsSerachLike = ["numero_habitacion", "tipo_habitacions.nombre"];
        $columnsFilter = [];
        $columnsBetweenFilter = [];
        $arrayOrderBy = [];
        if ($orderByCol && $desc) {
            $arrayOrderBy = [
                [$orderByCol, $desc]
            ];
        }

        $personas = $this->habitacionService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $personas->items(),
            "total" => $personas->total(),
            "lastPage" => $personas->lastPage()
        ]);
    }

    /**
     * Store habitacion
     *
     * @param HabitacionStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(HabitacionStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->habitacionService->crear($request->validated());
            DB::commit();
            return redirect()->route("habitacions.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Habitacion $habitacion)
    {
        return response()->JSON($habitacion->load("habitacion_fotos"));
    }

    /**
     * Update habitacion
     *
     * @param Habitacion $habitacion
     * @param HabitacionUpdateRequest $request
     * @return RedirectResponse|Response
     */
    public function update(Habitacion $habitacion, HabitacionUpdateRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->habitacionService->actualizar($request->validated(), $habitacion);
            DB::commit();
            return redirect()->route("habitacions.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Delete habitacion
     *
     * @param Habitacion $habitacion
     * @return JsonResponse|Response
     */
    public function destroy(Habitacion $habitacion): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->habitacionService->eliminar($habitacion);
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

    /**
     * Página eliminados
     *
     * @return Response
     */
    public function eliminados(): InertiaResponse
    {
        return Inertia::render("Admin/Habitacions/Eliminados");
    }

    /**
     * Listado Páginado de personas eliminados
     *
     * @param Request $request
     * @return void
     */
    public function paginado_eliminados(Request $request): JsonResponse
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

        $personas = $this->habitacionService->listadoPaginadoEliminados($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $personas->items(),
            "total" => $personas->total(),
            "lastPage" => $personas->lastPage()
        ]);
    }

    /**
     * Reestablecer una persona
     *
     * @param Habitacion $habitacion
     * @return JsonResponse
     */
    public function reestablecer(Habitacion $habitacion)
    {
        DB::beginTransaction();
        try {
            $this->habitacionService->reestablecer($habitacion);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se reestableció correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminación permanente de una habitacion
     *
     * @param Habitacion $habitacion
     * @return JsonResponse
     */
    public function eliminacion_permanente(Habitacion $habitacion)
    {
        DB::beginTransaction();
        try {
            $this->habitacionService->eliminacion_permanente($habitacion);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó permanentemente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
}

<?php

namespace App\Http\Controllers;

use App\Http\Requests\ClienteStoreRequest;
use App\Http\Requests\ClienteUpdateRequest;
use App\Models\Cliente;
use App\Services\ClienteService;
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

class ClienteController extends Controller
{
    public function __construct(private ClienteService $clienteService) {}

    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/Clientes/Index");
    }


    public function listado(Request $request): JsonResponse
    {
        $clientes = Cliente::select("clientes.*");

        if (isset($request->tipo) && $request->tipo) {
            $clientes->where("tipo", $request->tipo);
        }

        $clientes = $clientes->where("status", 1)->get();
        return response()->JSON([
            "clientes" => $clientes
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

        $personas = $this->clienteService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $personas->items(),
            "total" => $personas->total(),
            "lastPage" => $personas->lastPage()
        ]);
    }

    /**
     * Store cliente
     *
     * @param ClienteStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(ClienteStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->clienteService->crear($request->validated());
            DB::commit();
            return redirect()->route("clientes.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Cliente $cliente)
    {
        return response()->JSON($cliente->load("persona"));
    }

    /**
     * Update cliente
     *
     * @param Cliente $cliente
     * @param ClienteUpdateRequest $request
     * @return RedirectResponse|Response
     */
    public function update(Cliente $cliente, ClienteUpdateRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->clienteService->actualizar($request->validated(), $cliente);
            DB::commit();
            return redirect()->route("clientes.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Delete cliente
     *
     * @param Cliente $cliente
     * @return JsonResponse|Response
     */
    public function destroy(Cliente $cliente): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->clienteService->eliminar($cliente);
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
        return Inertia::render("Admin/Clientes/Eliminados");
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

        $personas = $this->clienteService->listadoPaginadoEliminados($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $personas->items(),
            "total" => $personas->total(),
            "lastPage" => $personas->lastPage()
        ]);
    }

    /**
     * Reestablecer una persona
     *
     * @param Cliente $cliente
     * @return JsonResponse
     */
    public function reestablecer(Cliente $cliente)
    {
        DB::beginTransaction();
        try {
            $this->clienteService->reestablecer($cliente);
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
     * Eliminación permanente de una cliente
     *
     * @param Cliente $cliente
     * @return JsonResponse
     */
    public function eliminacion_permanente(Cliente $cliente)
    {
        DB::beginTransaction();
        try {
            $this->clienteService->eliminacion_permanente($cliente);
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

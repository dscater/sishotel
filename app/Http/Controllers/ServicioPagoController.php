<?php

namespace App\Http\Controllers;

use App\Models\RegistroServicio;
use App\Services\ServicioPagoService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class ServicioPagoController extends Controller
{
    public function __construct(private ServicioPagoService $servicioPagoService) {}

    public function pagoTotal(RegistroServicio $registro_servicio, Request $request)
    {
        DB::beginTransaction();
        try {
            $resultado =   $this->servicioPagoService->pagarTotal($registro_servicio, $request->input("efectivo_banco", "EFECTIVO"));
            DB::commit();
            return response()->JSON($resultado);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function pagoPorPartes(RegistroServicio $registro_servicio, Request $request)
    {
        DB::beginTransaction();
        try {
            $data = [
                "monto" => $request->input("monto"),
                "efectivo_banco" => $request->input("efectivo_banco", "EFECTIVO"),
            ];
            $resultado =   $this->servicioPagoService->pagoPorPartes($registro_servicio, $data);
            DB::commit();
            return response()->JSON($resultado);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
}

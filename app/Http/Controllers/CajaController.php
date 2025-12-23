<?php

namespace App\Http\Controllers;

use App\Services\CajaService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use League\Config\Exception\ValidationException;

class CajaController extends Controller
{

    public function __construct(private CajaService $cajaService) {}

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
}

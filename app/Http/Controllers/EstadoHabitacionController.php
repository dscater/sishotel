<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class EstadoHabitacionController extends Controller
{
    public function getEstadosHabitacion()
    {
        return response()->json($this->listEstados());
    }

    private function listEstados()
    {
        // 0: DISPONIBLE, 1: OCUPADO, 2: EN MANTENIMIENTO
        return [
            0 =>  "DISPONIBLE",
            1 => "OCUPADO",
            2 => "EN MANTENIMIENTO",
        ];
    }

    public function getEstadoHabitacionText(int $estado): string
    {
        $estados = $this->listEstados();
        return $estados[$estado] ?? "DESCONOCIDO";
    }
}

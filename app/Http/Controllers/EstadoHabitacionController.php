<?php

namespace App\Http\Controllers;

use App\Models\Habitacion;
use Illuminate\Http\Request;

class EstadoHabitacionController extends Controller
{
    public function getEstadosHabitacion()
    {
        return response()->json($this->listEstados());
    }

    public function getEstadosConteoHabitacion()
    {
        return response()->JSON($this->listEstadosConteo());
    }


    private function listEstadosConteo()
    {
        $estados = $this->listEstados();

        $resultado = [];

        $clasesTextEstados = $this->clasesTextEstados();
        $bgEstados = $this->bgEstados();

        foreach ($estados as $key => $estado) {
            $resultado[] = [
                "id" => $key,
                "label" => $estado,
                "count" =>  Habitacion::where("estado", $key)->where("status", 1)->count(),
                "classText" => $clasesTextEstados[$key],
                "classBg" => $bgEstados[$key],
            ];
        }

        return $resultado;
    }


    private function listEstados()
    {
        // 0: DISPONIBLE, 1: OCUPADO, 2: EN MANTENIMIENTO, 3: EN LIMPIEZA, 4: SALIENTE
        return [
            0 => "DISPONIBLE",
            1 => "OCUPADO",
            2 => "EN MANTENIMIENTO",
            3 => "EN LIMPIEZA",
            4 => "SALIENTE",
        ];
    }

    private function clasesTextEstados()
    {
        return [
            0 => "text-success",
            1 => "text-danger",
            2 => "text-primary",
            3 => "text-orange",
            4 => "text-info",
        ];
    }

    private function bgEstados()
    {
        return [
            0 => "bg-success",
            1 => "bg-danger",
            2 => "bg-blue",
            3 => "bg-orange",
            4 => "bg-info",
        ];
    }

    public function getEstadoHabitacionText(int $estado): string
    {
        $estados = $this->listEstados();
        return $estados[$estado] ?? "DESCONOCIDO";
    }
}

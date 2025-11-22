<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class TipoUsuarioController extends Controller
{
    public function getTipos()
    {
        return response()->json($this->listTipos());
    }

    private function listTipos()
    {
        return [
            "ADMINISTRADOR",
            "RECEPCIONISTA",
            "CONTADOR",
        ];
    }
}

<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use App\Models\Registro;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class UserController extends Controller
{

    public function permisosUsuario(Request $request)
    {
        return response()->JSON([
            "permisos" => Auth::user()->permisos
        ]);
    }

    public function getUser()
    {
        return response()->JSON([
            "user" => Auth::user()
        ]);
    }

    public static function getInfoBoxUser()
    {
        $permisos = [];
        $array_infos = [];
        if (Auth::check()) {
            $oUser = new User();
            $permisos = $oUser->permisos;
            if ($permisos == '*' || (is_array($permisos) && in_array('usuarios.index', $permisos))) {
                $array_infos[] = [
                    'label' => 'USUARIOS',
                    'cantidad' => User::where('id', '!=', 1)->count(),
                    'color' => 'bg-secundario',
                    'icon' => "fa-users",
                    "url" => "usuarios.index"
                ];
            }

            if ($permisos == '*' || (is_array($permisos) && in_array('registros.index', $permisos))) {
                $registros = Registro::where("estado", 1)->where("status", 1)->count();
                $array_infos[] = [
                    'label' => 'REGISTROS ACTIVOS',
                    'cantidad' => $registros,
                    'color' => 'bg-secundario',
                    'icon' => "fa-list",
                    "url" => "registros.index"
                ];
            }

            if ($permisos == '*' || (is_array($permisos) && in_array('clientes.index', $permisos))) {
                $clientes = Cliente::where("status", 1)->count();
                $array_infos[] = [
                    'label' => 'CLIENTES REGISTRADOS',
                    'cantidad' => $clientes,
                    'color' => 'bg-secundario',
                    'icon' => "fa-list",
                    "url" => "clientes.index"
                ];
            }
        }

        return $array_infos;
    }
}

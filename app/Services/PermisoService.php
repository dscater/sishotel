<?php

namespace App\Services;

use Illuminate\Support\Facades\Auth;

class PermisoService
{
    protected $arrayPermisos = [
        "ADMINISTRADOR" => [
            "usuarios.paginado",
            "usuarios.index",
            "usuarios.listado",
            "usuarios.create",
            "usuarios.store",
            "usuarios.edit",
            "usuarios.show",
            "usuarios.update",
            "usuarios.destroy",
            "usuarios.password",
            "usuarios.eliminados",
            "usuarios.paginado_eliminados",
            "usuarios.reestablecer",
            "usuarios.eliminacion_permanente",

            "tipo_usuarios.getTipos",

            "clientes.listado",
            "clientes.paginado",
            "clientes.index",
            "clientes.create",
            "clientes.store",
            "clientes.edit",
            "clientes.show",
            "clientes.update",
            "clientes.destroy",
            "clientes.eliminados",
            "clientes.paginado_eliminados",
            "clientes.reestablecer",
            "clientes.eliminacion_permanente",

            "registros.checkin",

            "configuracions.index",
            "configuracions.create",
            "configuracions.edit",
            "configuracions.update",
            "configuracions.destroy",

            "reportes.usuarios",
            "reportes.r_usuarios",
        ],
        "GERENTE" => [
            "reportes.tareas",
            "reportes.r_tareas",
        ],
        "EMPLEADO" => [],
    ];

    public function getPermisosUser()
    {
        $user = Auth::user();
        $permisos = [];
        if ($user) {
            return $this->arrayPermisos[$user->tipo];
        }

        return $permisos;
    }
}

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

            "estado_habitacions.getEstadosHabitacion",

            "habitacions.listado",
            "habitacions.listadoCheckIn",
            "habitacions.paginado",
            "habitacions.index",
            "habitacions.create",
            "habitacions.store",
            "habitacions.edit",
            "habitacions.show",
            "habitacions.update",
            "habitacions.destroy",
            "habitacions.eliminados",
            "habitacions.paginado_eliminados",
            "habitacions.reestablecer",
            "habitacions.eliminacion_permanente",

            "tipo_habitacions.listado",
            "tipo_habitacions.paginado",
            "tipo_habitacions.index",
            "tipo_habitacions.create",
            "tipo_habitacions.store",
            "tipo_habitacions.edit",
            "tipo_habitacions.show",
            "tipo_habitacions.update",
            "tipo_habitacions.destroy",

            "monedas.listado",
            "monedas.paginado",
            "monedas.index",
            "monedas.create",
            "monedas.store",
            "monedas.edit",
            "monedas.show",
            "monedas.update",
            "monedas.destroy",
            "monedas.getMonedaOficial",

            "tipo_cambios.listado",
            "tipo_cambios.paginado",
            "tipo_cambios.index",
            "tipo_cambios.create",
            "tipo_cambios.store",
            "tipo_cambios.edit",
            "tipo_cambios.show",
            "tipo_cambios.update",
            "tipo_cambios.destroy",

            "registros.index",

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

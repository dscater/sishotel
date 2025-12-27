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
            "clientes.listadoSelectElementUi",
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
            "estado_habitacions.getEstadosConteoHabitacion",

            "habitacions.listado",
            "habitacions.listadoRecepcion",
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
            "habitacions.actualizar_estado",
            "habitacions.imagenes",
            "habitacions.verificaHabitacionesReserva",
            "habitacions.verificaReservasHabitacion",

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
            "tipo_cambios.listadoByMonedaId",
            "tipo_cambios.paginado",
            "tipo_cambios.index",
            "tipo_cambios.create",
            "tipo_cambios.store",
            "tipo_cambios.edit",
            "tipo_cambios.show",
            "tipo_cambios.update",
            "tipo_cambios.destroy",

            "tipo_productos.listado",
            "tipo_productos.paginado",
            "tipo_productos.index",
            "tipo_productos.create",
            "tipo_productos.store",
            "tipo_productos.edit",
            "tipo_productos.show",
            "tipo_productos.update",
            "tipo_productos.destroy",

            "productos.listado",
            "productos.listadoByTipo",
            "productos.paginado",
            "productos.index",
            "productos.create",
            "productos.store",
            "productos.edit",
            "productos.show",
            "productos.update",
            "productos.destroy",

            "ingreso_productos.listado",
            "ingreso_productos.paginado",
            "ingreso_productos.index",
            "ingreso_productos.create",
            "ingreso_productos.store",
            "ingreso_productos.edit",
            "ingreso_productos.show",
            "ingreso_productos.update",
            "ingreso_productos.destroy",

            "egreso_productos.listado",
            "egreso_productos.paginado",
            "egreso_productos.index",
            "egreso_productos.create",
            "egreso_productos.store",
            "egreso_productos.edit",
            "egreso_productos.show",
            "egreso_productos.update",
            "egreso_productos.destroy",

            "registros.index",
            "registros.historial",
            "registros.paginado",
            "registros.store",
            "registros.update",
            "registros.verificaHabitacion",
            "registros.transferencia",
            "registros.finalizar",
            "registros.finalizar_registro",
            "registros.actualizaGarantia",
            "registros.reservas",
            "registros.create",
            "registros.edit",
            "registros.destroy",
            "registros.reservasPaginado",
            "registros.atenderReserva",
            "registros.listadoSalientesHoy",
            "registros.listadoReservasHoy",
            "registros.checkin",
            "registros.checkout",

            // servicios
            "registro_servicios.store",
            "registro_servicios.listadoByRegistroId",
            "registro_servicios.comanda",

            // cajas
            "cajas.listado",
            "cajas.paginado",
            "cajas.index",
            "cajas.create",
            "cajas.store",
            "cajas.edit",
            "cajas.show",
            "cajas.update",
            "cajas.destroy",
            "cajas.verificaCajaAbierta",
            "cajas.aperturarCaja",

            "cajas.cierre_caja",
            "cajas.movimiento_cajas",

            // servicio-pagos
            "servicio_pagos.pagoTotal",
            "servicio_pagos.pagoPorPartes",

            "configuracions.index",
            "configuracions.create",
            "configuracions.edit",
            "configuracions.update",
            "configuracions.destroy",

            "reportes.usuarios",
            "reportes.r_usuarios",
        ],
        "RECEPCIONISTA" => [],
        "CONTADOR" => [],
    ];

    public function getPermisosUser()
    {
        $user = Auth::user();
        // if ($user->id == 1) {
        //     return "*";
        // }
        $permisos = [];
        if ($user) {
            return $this->arrayPermisos[$user->tipo];
        }

        return $permisos;
    }
}

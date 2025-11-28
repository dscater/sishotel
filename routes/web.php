<?php

use App\Http\Controllers\AreaController;
use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\ClienteController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\EstadoHabitacionController;
use App\Http\Controllers\HabitacionController;
use App\Http\Controllers\InicioController;
use App\Http\Controllers\MonedaController;
use App\Http\Controllers\PersonaController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\RegistroController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\TipoCambioController;
use App\Http\Controllers\TipoHabitacionController;
use App\Http\Controllers\TipoUsuarioController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UsuarioController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
});

Route::get('/clear-cache', function () {
    Artisan::call('config:cache');
    Artisan::call('config:clear');
    Artisan::call('optimize');
    return 'Cache eliminado <a href="/">Ir al inicio</a>';
})->name('clear.cache');

Route::get('/login', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
})->name("login");

Route::post('/registro/validaForm1', [RegisteredUserController::class, 'validaForm1'])->name("registro.validaForm1");
Route::get('/registro', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Register');
})->name("registro");

Route::get("configuracions/getConfiguracion", [ConfiguracionController::class, 'getConfiguracion'])->name("configuracions.getConfiguracion");

// PORTAL

// ADMINISTRACION
Route::middleware(['auth', 'permisoUsuario'])->prefix("admin")->group(function () {
    // INICIO
    Route::get('/inicio', [InicioController::class, 'inicio'])->name('inicio');

    // CONFIGURACION
    Route::resource("configuracions", ConfiguracionController::class)->only(
        ["index", "show", "update"]
    );

    // USUARIO
    Route::get('profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::patch('profile/update_foto', [ProfileController::class, 'update_foto'])->name('profile.update_foto');
    Route::delete('profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    Route::get("getUser", [UserController::class, 'getUser'])->name('users.getUser');
    Route::get("permisosUsuario", [UserController::class, 'permisosUsuario']);


    // PERSONAS
    Route::get("personas/paginado", [PersonaController::class, 'paginado'])->name("personas.paginado");
    Route::get("personas/listado", [PersonaController::class, 'listado'])->name("personas.listado");
    Route::get("personas/eliminados", [PersonaController::class, 'eliminados'])->name("personas.eliminados");
    Route::get("personas/paginado_eliminados", [PersonaController::class, 'paginado_eliminados'])->name("personas.paginado_eliminados");
    Route::patch("personas/reestablecer/{persona}", [PersonaController::class, 'reestablecer'])->name("personas.reestablecer");
    Route::delete("personas/eliminacion_permanente/{persona}", [PersonaController::class, 'eliminacion_permanente'])->name("personas.eliminacion_permanente");
    Route::resource("personas", PersonaController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // USUARIOS
    Route::get("usuarios/eliminados", [UsuarioController::class, 'eliminados'])->name("usuarios.eliminados");
    Route::get("usuarios/paginado_eliminados", [UsuarioController::class, 'paginado_eliminados'])->name("usuarios.paginado_eliminados");
    Route::patch("usuarios/reestablecer/{user}", [UsuarioController::class, 'reestablecer'])->name("usuarios.reestablecer");
    Route::delete("usuarios/eliminacion_permanente/{user}", [UsuarioController::class, 'eliminacion_permanente'])->name("usuarios.eliminacion_permanente");
    Route::put("usuarios/password/{user}", [UsuarioController::class, 'actualizaPassword'])->name("usuarios.password");
    Route::get("usuarios/api", [UsuarioController::class, 'api'])->name("usuarios.api");
    Route::get("usuarios/paginado", [UsuarioController::class, 'paginado'])->name("usuarios.paginado");
    Route::get("usuarios/listado", [UsuarioController::class, 'listado'])->name("usuarios.listado");
    Route::get("usuarios/listado/byTipo", [UsuarioController::class, 'byTipo'])->name("usuarios.byTipo");
    Route::get("usuarios/show/{user}", [UsuarioController::class, 'show'])->name("usuarios.show");
    Route::put("usuarios/update/{user}", [UsuarioController::class, 'update'])->name("usuarios.update");
    Route::delete("usuarios/{user}", [UsuarioController::class, 'destroy'])->name("usuarios.destroy");
    Route::resource("usuarios", UsuarioController::class)->only(
        ["index", "store"]
    );

    // TIPO USUARIOS
    Route::get("tipo_usuarios/getTipos", [TipoUsuarioController::class, 'getTipos'])->name("tipo_usuarios.getTipos");

    // ESTADOS DE HABITACIÓN
    Route::get("estado_habitacions/getEstadosHabitacion", [EstadoHabitacionController::class, 'getEstadosHabitacion'])->name("estado_habitacions.getEstadosHabitacion");
    Route::get("estado_habitacions/getEstadosConteoHabitacion", [EstadoHabitacionController::class, 'getEstadosConteoHabitacion'])->name("estado_habitacions.getEstadosConteoHabitacion");


    // CLIENTES
    Route::get("clientes/eliminados", [ClienteController::class, 'eliminados'])->name("clientes.eliminados");
    Route::get("clientes/paginado_eliminados", [ClienteController::class, 'paginado_eliminados'])->name("clientes.paginado_eliminados");
    Route::patch("clientes/reestablecer/{cliente}", [ClienteController::class, 'reestablecer'])->name("clientes.reestablecer");
    Route::delete("clientes/eliminacion_permanente/{cliente}", [ClienteController::class, 'eliminacion_permanente'])->name("clientes.eliminacion_permanente");
    Route::get("clientes/api", [ClienteController::class, 'api'])->name("clientes.api");
    Route::get("clientes/paginado", [ClienteController::class, 'paginado'])->name("clientes.paginado");
    Route::get("clientes/listado", [ClienteController::class, 'listado'])->name("clientes.listado");
    Route::get("clientes/listadoSelectElementUi", [ClienteController::class, 'listadoSelectElementUi'])->name("clientes.listadoSelectElementUi");
    Route::resource("clientes", ClienteController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // TIPO DE HABITACIONES
    Route::get("tipo_habitacions/api", [TipoHabitacionController::class, 'api'])->name("tipo_habitacions.api");
    Route::get("tipo_habitacions/paginado", [TipoHabitacionController::class, 'paginado'])->name("tipo_habitacions.paginado");
    Route::get("tipo_habitacions/listado", [TipoHabitacionController::class, 'listado'])->name("tipo_habitacions.listado");
    Route::resource("tipo_habitacions", TipoHabitacionController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // HABITACIONES
    Route::get("habitacions/listadoRecepcion", [HabitacionController::class, 'listadoRecepcion'])->name("habitacions.listadoRecepcion");
    Route::get("habitacions/eliminados", [HabitacionController::class, 'eliminados'])->name("habitacions.eliminados");
    Route::get("habitacions/paginado_eliminados", [HabitacionController::class, 'paginado_eliminados'])->name("habitacions.paginado_eliminados");
    Route::patch("habitacions/reestablecer/{habitacion}", [HabitacionController::class, 'reestablecer'])->name("habitacions.reestablecer");
    Route::delete("habitacions/eliminacion_permanente/{habitacion}", [HabitacionController::class, 'eliminacion_permanente'])->name("habitacions.eliminacion_permanente");
    Route::get("habitacions/api", [HabitacionController::class, 'api'])->name("habitacions.api");
    Route::get("habitacions/paginado", [HabitacionController::class, 'paginado'])->name("habitacions.paginado");
    Route::get("habitacions/listado", [HabitacionController::class, 'listado'])->name("habitacions.listado");
    Route::resource("habitacions", HabitacionController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // MONEDAS
    Route::get("monedas/getMonedaOficial", [MonedaController::class, 'getMonedaOficial'])->name("monedas.getMonedaOficial");
    Route::get("monedas/api", [MonedaController::class, 'api'])->name("monedas.api");
    Route::get("monedas/paginado", [MonedaController::class, 'paginado'])->name("monedas.paginado");
    Route::get("monedas/listado", [MonedaController::class, 'listado'])->name("monedas.listado");
    Route::resource("monedas", MonedaController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // TIPO DE CAMBIO
    Route::get("tipo_cambios/api", [TipoCambioController::class, 'api'])->name("tipo_cambios.api");
    Route::get("tipo_cambios/paginado", [TipoCambioController::class, 'paginado'])->name("tipo_cambios.paginado");
    Route::get("tipo_cambios/listado", [TipoCambioController::class, 'listado'])->name("tipo_cambios.listado");
    Route::resource("tipo_cambios", TipoCambioController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // REGISTROS
    Route::get("registros", [RegistroController::class, 'index'])->name("registros.index");
    Route::post("registros", [RegistroController::class, 'store'])->name("registros.store");
    Route::put("registros/update/{registro}", [RegistroController::class, 'update'])->name("registros.update");

    // REPORTES
    Route::get('reportes/usuarios', [ReporteController::class, 'usuarios'])->name("reportes.usuarios");
    Route::get('reportes/r_usuarios', [ReporteController::class, 'r_usuarios'])->name("reportes.r_usuarios");
});
require __DIR__ . '/auth.php';

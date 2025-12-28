<?php

namespace App\Http\Controllers;

use App\Models\Area;
use App\Models\Caja;
use App\Models\Cliente;
use App\Models\Configuracion;
use App\Models\HistorialOferta;
use App\Models\KardexProducto;
use App\Models\MovimientoCaja;
use App\Models\Producto;
use App\Models\Publicacion;
use App\Models\PublicacionDetalle;
use App\Models\Registro;
use App\Models\SubastaCliente;
use App\Models\Tarea;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;
use PDF;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class ReporteController extends Controller
{
    public function usuarios()
    {
        return Inertia::render("Admin/Reportes/Usuarios");
    }

    public function r_usuarios(Request $request)
    {
        $tipo =  $request->tipo;
        $usuarios = User::select("users.*")
            ->where('id', '!=', 1);

        if ($tipo != 'TODOS') {
            $usuarios->where('tipo', $tipo);
        }

        $usuarios = $usuarios->orderBy("paterno", "ASC")->get();

        $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('usuarios.pdf');
    }

    public function movimiento_cajas()
    {
        return Inertia::render("Admin/Reportes/MovimientoCajas");
    }

    public function r_movimiento_cajas(Request $request)
    {
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;
        $caja_id = $request->caja_id;

        $movimiento_cajas = [];
        $saldos_monedas = [];

        if ($caja_id) {
            $movimiento_cajas = MovimientoCaja::where("caja_id", $caja_id)->get();
            // saldos 
            $saldos_monedas = MovimientoCaja::join('monedas', 'monedas.id', '=', 'movimiento_cajas.moneda_id_tc')
                ->select(
                    'moneda_id_tc',
                    'monedas.simbolo',
                    DB::raw("SUM(CASE WHEN tipo = 'INGRESO' THEN monto_tc ELSE 0 END) as ingresos"),
                    DB::raw("SUM(CASE WHEN tipo = 'EGRESO' THEN monto_tc ELSE 0 END) as egresos")
                )
                ->where("caja_id", $caja_id)
                ->groupBy('moneda_id_tc', 'monedas.simbolo')
                ->get()
                ->map(function ($item) {
                    return [
                        'moneda_id_tc' => $item->moneda_id_tc,
                        'simbolo' => $item->simbolo,
                        'saldo' => number_format((float)$item->ingresos - (float)$item->egresos, 2, ".", "")
                    ];
                });
        } else {
            if ($fecha_ini && $fecha_fin) {
                $movimiento_cajas = MovimientoCaja::whereBetween("fecha_movimiento", [$fecha_ini, $fecha_fin])->get();
                // saldos 
                $saldos_monedas = MovimientoCaja::join('monedas', 'monedas.id', '=', 'movimiento_cajas.moneda_id_tc')
                    ->select(
                        'moneda_id_tc',
                        'monedas.simbolo',
                        DB::raw("SUM(CASE WHEN tipo = 'INGRESO' THEN monto_tc ELSE 0 END) as ingresos"),
                        DB::raw("SUM(CASE WHEN tipo = 'EGRESO' THEN monto_tc ELSE 0 END) as egresos")
                    )
                    ->whereBetween("fecha_movimiento", [$fecha_ini, $fecha_fin])
                    ->groupBy('moneda_id_tc', 'monedas.simbolo')
                    ->get()
                    ->map(function ($item) {
                        return [
                            'moneda_id_tc' => $item->moneda_id_tc,
                            'simbolo' => $item->simbolo,
                            'saldo' => number_format((float)$item->ingresos - (float)$item->egresos, 2, ".", "")
                        ];
                    });
            }
        }

        $saldos_monedas_totales = MovimientoCaja::join('monedas', 'monedas.id', '=', 'movimiento_cajas.moneda_id_tc')
            ->select(
                'moneda_id_tc',
                'monedas.simbolo',
                DB::raw("SUM(CASE WHEN tipo = 'INGRESO' THEN monto_tc ELSE 0 END) as ingresos"),
                DB::raw("SUM(CASE WHEN tipo = 'EGRESO' THEN monto_tc ELSE 0 END) as egresos")
            )
            ->groupBy('moneda_id_tc', 'monedas.simbolo')
            ->get()
            ->map(function ($item) {
                return [
                    'moneda_id_tc' => $item->moneda_id_tc,
                    'simbolo' => $item->simbolo,
                    'saldo' => number_format((float)$item->ingresos - (float)$item->egresos, 2, ".", "")
                ];
            });

        $caja = null;
        if ($caja_id) {
            $caja = Caja::findOrFail($caja_id);
        }

        $pdf = PDF::loadView('reportes.movimiento_cajas', compact('movimiento_cajas', 'saldos_monedas', 'saldos_monedas_totales', 'caja'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('movimiento_cajas.pdf');
    }

    public function kardex_productos()
    {
        return Inertia::render("Admin/Reportes/KardexProductos");
    }

    public function r_kardex_productos(Request $request)
    {
        $producto_id = $request->producto_id;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;

        $productos = Producto::select("productos.*");
        if ($producto_id != 'todos') {
            $productos->where("id", $producto_id);
        }
        $productos = $productos->get();

        $array_kardex = [];
        $array_saldo_anterior = [];
        foreach ($productos as $registro) {
            $array_kardex[$registro->id] = [
                "kardex" => [],
                "array_saldo_anterior" => [],
            ];

            $kardex = KardexProducto::where('producto_id', $registro->id)
                ->get();
            $array_saldo_anterior = [
                'sw' => false,
                'saldo_anterior' => []
            ];
            if ($fecha_ini && $fecha_fin) {
                $kardex = KardexProducto::where('producto_id', $registro->id)

                    ->whereBetween('fecha', [$fecha_ini, $fecha_fin])->get();
                // buscar saldo anterior si existe
                $saldo_anterior = KardexProducto::where('producto_id', $registro->id)
                    ->where('fecha', '<', $fecha_ini)
                    ->orderBy('created_at', 'asc')->get()->last();
                if ($saldo_anterior) {
                    $cantidad_saldo = $saldo_anterior->cantidad_saldo;
                    $monto_saldo = $saldo_anterior->monto_saldo;
                    $array_saldo_anterior = [
                        'sw' => true,
                        'saldo_anterior' => [
                            'cantidad_saldo' => $cantidad_saldo,
                            'monto_saldo' => $monto_saldo,
                        ]
                    ];
                }
            }

            $array_kardex[$registro->id]["kardex"] = $kardex;
            $array_kardex[$registro->id]["array_saldo_anterior"] = $array_saldo_anterior;
        }

        $pdf = PDF::loadView('reportes.kardex_productos', compact('productos', "array_kardex"))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('kardex.pdf');
    }
    public function productos()
    {
        return Inertia::render("Admin/Reportes/Productos");
    }

    public function r_productos(Request $request)
    {
        $tipo =  $request->tipo;
        $productos = Producto::select("productos.*");
        $productos = $productos->get();
        $pdf = PDF::loadView('reportes.productos', compact('productos'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('productos.pdf');
    }
    public function clientes()
    {
        return Inertia::render("Admin/Reportes/Clientes");
    }

    public function r_clientes(Request $request)
    {
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $clientes = Cliente::select("clientes.*");

        if ($fecha_ini && $fecha_fin) {
            $clientes->whereBetween("fecha_registro", [$fecha_ini, $fecha_fin]);
        }

        $clientes = $clientes->get();

        $pdf = PDF::loadView('reportes.clientes', compact('clientes'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('clientes.pdf');
    }
    public function registros()
    {
        return Inertia::render("Admin/Reportes/Registros");
    }

    public function r_registros(Request $request)
    {
        $estado =  $request->estado;
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $registros = Registro::select("registros.*")
            ->where('status', 1);

        if ($estado != 'todos') {
            $registros->where('estado', $estado);
        }

        if ($fecha_ini && $fecha_fin) {
            $registros->whereBetween('fecha_entrada', [$fecha_ini, $fecha_fin]);
        }

        $registros = $registros->get();

        $pdf = PDF::loadView('reportes.registros', compact('registros'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('registros.pdf');
    }
}

<?php

namespace App\Http\Controllers;

use App\Models\Area;
use App\Models\Cliente;
use App\Models\Configuracion;
use App\Models\HistorialOferta;
use App\Models\MovimientoCaja;
use App\Models\Publicacion;
use App\Models\PublicacionDetalle;
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

        if ($tipo != 'todos') {
            $request->validate([
                'tipo' => 'required',
            ]);
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

        $pdf = PDF::loadView('reportes.movimiento_cajas', compact('movimiento_cajas', 'saldos_monedas'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('movimiento_cajas.pdf');
    }

    public function ingresos_recepcion()
    {
        return Inertia::render("Admin/Reportes/Usuarios");
    }

    public function r_ingresos_recepcion(Request $request)
    {

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
}

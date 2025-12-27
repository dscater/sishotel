<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>CheckOut</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1cm;
            margin-bottom: 1cm;
            margin-left: 1.5cm;
            margin-right: 0.3cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: 20px;
            page-break-before: avoid;
        }

        table thead tr th,
        tbody tr td {
            padding: 3px;
            word-wrap: break-word;
        }

        table th {
            font-size: 10pt;
        }

        table td {
            font-size: 9pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            height: 70px;
            top: -20px;
            left: 0px;
        }

        .nro_registro {
            position: absolute;
            top: -20px;
            right: 0px;
            border: solid 1px #A42A2A;
            color: #A42A2A;
            padding: 10px;
            border-radius: 6px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 0PX;
            margin-bottom: 5px;
            text-align: center;
            font-size: 14pt;
        }

        .texto {
            width: 450px;
            text-align: left;
            margin: auto;
            margin-top: 5px;
            font-weight: bold;
            font-size: 1em;
            text-align: center;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: normal;
            font-size: 0.85em;
        }

        table {
            width: 100%;
        }

        table thead {
            background: rgb(236, 236, 236)
        }

        tr {
            page-break-inside: avoid !important;
        }

        .centreado {
            padding-left: 0px;
            text-align: center;
        }

        .txt_center {
            font-weight: bold;
            text-align: center;
        }

        .bg-principal {
            background: #153f59;
            color: white;
        }

        .img_celda img {
            width: 45px;
        }

        .info_habitacion {
            margin: auto;
            margin-top: 6px;
            width: 80%;
        }

        .text-right {
            text-align: right;
        }

        .text-left {
            text-align: left;
        }

        .bold {
            font-weight: bold;
        }

        .datos {
            border: solid 1px black;
            padding: 3px;
            border-collapse: separate;
            border-spacing: 10px 0px;
            margin: auto;
            margin-top: 5px;
        }

        .border {
            border: solid 1px black;
        }

        .text {
            color: #18186F;
        }

        .text2 {
            color: #00008A;
        }

        .border_b {
            border-bottom: solid 1px black;
        }

        .pt-2 {
            padding-top: 5px;
        }

        .info2 {
            width: 100%;
            margin-top: 10px;
            margin-bottom: 0px;
        }

        .txt_reglamento {
            font-size: 7.5pt;
            margin-top: 0cm;
            margin-bottom: 0cm;
            text-align: justify;
        }

        .txt_reglamento2 {
            font-size: 7.5pt;
            margin-bottom: 0px;
            text-align: left;
            word-break: break-all;
        }

        .txt_punteado {
            width: 100%;
            border-bottom: dotted 1px #00008A;
            margin-bottom: 0.5cm;
        }

        .border_firma {
            border-bottom: dotted 1px #00008A;
        }



        .datos2 {
            border-collapse: separate;
            border-spacing: 5px 0px;
            margin: auto;
            margin-top: 5px;
        }


        .table_detalles {
            border: solid 1px black;
        }

        .table_detalles thead {
            background: none;
            border-bottom: solid 1px black;
        }

        .table_detalles tfoot {
            background: none;
            border-top: solid 1px black;
        }

        .tabletraspasos {
            width: 60%;
            margin: 0;
            margin-top: 10px;
        }

        .firma {
            margin-top: 50px;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
    @inject('moneda', 'App\Models\Moneda')
    @php
        $oMoneda = $moneda->where('oficial', 1)->get()->first();
        $simbolo = $oMoneda ? $oMoneda->simbolo : 'Bs';
    @endphp
    <div class="encabezado">
        <div class="logo">
            <img src="{{ $configuracion->first()->logo_b64 }}">
        </div>
        <h2 class="text titulo">
            {{ $configuracion->first()->razon_social }}
        </h2>
        <h4 class="text texto">DETALLE DE MOVIMIENTO</h4>
        <h4 class="nro_registro">{{ $nro_registro }}</h4>
    </div>

    <table class="info_habitacion">
        <tbody>
            <tr class="text2">
                <td class="text-right bold">Nro. Habitación: </td>
                <td>{{ $registro->habitacion->numero_habitacion }}</td>
                <td class="text-right bold">Tipo de Habitación: </td>
                <td>{{ $registro->habitacion->tipo_habitacion->nombre }}</td>
            </tr>
        </tbody>
    </table>

    <table class="info2" class="datos">
        <tbody>
            <tr>
                <td class="centreado text2">Nombre(s) y Apellido(s) (Name):</td>
                <td class="centreado text2" width="20%">C.I./Pasaporte (Passport Number):</td>
                <td class="centreado text2" width="20%">Fecha de Nacimiento (Date of Birth):</td>
                <td class="centreado text2" width="9%">Edad (Age):</td>
            </tr>

            <tr>
                <td class="border centreado">{{ $registro->cliente->nombre }} {{ $registro->cliente->paterno }}
                    {{ $registro->cliente->materno }}
                </td>
                <td class="border centreado">{{ $registro->cliente->ci }}</td>
                <td class="border centreado">{{ $registro->cliente->fecha_nac }}</td>
                <td class="border centreado">{{ $registro->cliente->edad }}</td>
            </tr>
        </tbody>
    </table>
    <h4 class="text texto">Detalle del Hospedaje</h4>
    <table class="datos2">
        <tbody>
            <tr>
                <td class="border">
                    Fecha Ingreso: {{ $registro->fecha_hora_entrada }}
                </td>
                <td class="border">
                    Fecha Salida: {{ $registro->fecha_hora_entrada }}
                </td>
                <td class="border">
                    P/Día: {{ $registro->cd }} {{ $simbolo }}
                </td>
                <td class="border">
                    Nro. Días: {{ $registro->dias_estadia }}
                </td>
                <td class="border">
                    {{ $registro->total }} {{ $simbolo }}
                </td>
            </tr>
        </tbody>
    </table>
    <table class="table_detalles">
        <thead>
            <tr>
                <th width="10%">Nro. Comanda</th>
                <th>Fecha</th>
                <th class="text-left">Descripción</th>
                <th class="text-right">Cantidad</th>
                <th class="text-right">P/U</th>
                <th class="text-right">Total</th>
            </tr>
        </thead>
        <tbody>
            @php
                $hospedajes = $registro->registro_servicios->where('tipo', 'HOSPEDAJE');
                $servicios = $registro->registro_servicios->where('tipo', 'PRODUCTO/SERVICIO');
            @endphp
            <tr>
                <td></td>
                <td colspan="2" class="centreado bold">CONSUMO</td>
                <td colspan="3"></td>
            </tr>
            @foreach ($servicios as $key => $item)
                @php
                    $detalles = $item->servicio_detalles;
                @endphp
                @foreach ($detalles as $key_detalle => $detalle)
                    <tr>
                        <td class="centreado">
                            @if ($key_detalle == 0)
                                {{ $item->id }}
                            @endif
                        </td>
                        <td class="centreado">{{ $item->fecha_t }}</td>
                        <td class="">{{ $detalle->producto->nombre }}</td>
                        <td class="text-right">{{ $detalle->cantidad }}</td>
                        <td class="text-right">{{ $detalle->precio_unitario }}</td>
                        <td class="text-right">{{ $detalle->total }}</td>
                    </tr>
                @endforeach
            @endforeach
            <tr>
                <td></td>
                <td colspan="2" class="centreado bold">HOSPEDAJE</td>
                <td colspan="3"></td>
            </tr>
            @foreach ($hospedajes as $key => $item)
                <tr>
                    <td class="centreado">
                        {{ $item->id }}
                    </td>
                    <td class="centreado">{{ $item->fecha_t }}</td>
                    <td class="">{{ $item->tipo }}</td>
                    <td class="text-right">{{ $item->cantidad }}</td>
                    <td class="text-right">{{ $registro->cd }}</td>
                    <td class="text-right">{{ $item->total }}</td>
                </tr>
            @endforeach
        </tbody>
        <tfoot>
            <tr>
                <th colspan="5" class="text-right">TOTAL</th>
                <th class="text-right">{{ number_format($registro->registro_servicios->sum('total'), 2, '.', '') }}
                </th>
            </tr>
        </tfoot>
    </table>


    <table border="1" class="tabletraspasos">
        <thead>
            <tr>
                <th class="centreado" colspan="4">TRASPASOS</th>

            </tr>
            <tr>
                <th>Origen</th>
                <th>Destino</th>
                <th>Fecha</th>
                <th>Motivo</th>
            </tr>
        </thead>
        <tbody>
            @if (count($registro->transferencias) > 0)
                @foreach ($registro->transferencias as $item)
                    <tr>
                        <td>
                            {{ $item->habitacion->numero_habitacion }}

                        </td>
                        <td>
                            {{ $item->habitacion_destino->numero_habitacion }}
                        </td>
                        <td>
                            {{ $item->fecha }}
                        </td>
                        <td>
                            {{ $item->motivo }}
                        </td>
                    </tr>
                @endforeach
            @else
                <tr>
                    <td colspan="4">SIN REGISTROS</td>
                </tr>
            @endif
        </tbody>
    </table>
    <table class="info2" style="margin-top:20px;">
        <tbody>
            <tr>
                <td class="text2 bold text-right">GARANTÍA</td>
                <td class="">{{ $registro->garantia }} {{ $simbolo }}</td>
                <td>{{ $registro->garantia && $registro->garantia > 0 ? $registro->desc_garantia : '' }}</td>
            </tr>
        </tbody>
    </table>
    <table class="firma">
        <tbody>
            <tr>
                <td class="border_firma"></td>
                <td class="centreado">{{ $registro->user->usuario }}</td>
                <td class="border_firma"></td>
            </tr>
            <tr>
                <td class="centreado text2">
                    Firma del huesped
                </td>
                <td class="centreado text2">
                    Recepcionista de Turno
                </td>
                <td class="centreado text2">
                    Firma Recepcionsita de Turno
                </td>
            </tr>
        </tbody>
    </table>
</body>

</html>

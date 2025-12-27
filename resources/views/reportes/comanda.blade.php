<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Comanda</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 0.3cm;
            margin-bottom: 0.3cm;
            margin-left: 0.3cm;
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
            font-size: 9pt;
        }

        table td {
            font-size: 7pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            height: 50px;
            top: 0px;
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
            width: 100%;
            margin: auto;
            margin-top: 40px;
            margin-bottom: 5px;
            text-align: center;
            font-size: 10pt;
        }

        .texto {
            width: 100%;
            text-align: left;
            margin: auto;
            margin-top: 5px;
            font-weight: bold;
            font-size: 9pt;
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

        .info_habitacion {
            margin: auto;
            margin-top: 6px;
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


        .fecha_hora {
            width: 100%;
            text-align: right;
            font-size: 8pt;
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


        .firma {
            margin: auto;
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
        <h4 class="text texto">COMANDA DE CONTABILIDAD</h4>
        <h4 class="nro_registro">{{ $nro_registro }}</h4>
    </div>

    <table class="info_habitacion">
        <tbody>
            <tr class="text2">
                <td class="text-right bold">Nro. Habitación: </td>
                <td>{{ $registro_servicio->registro->habitacion->numero_habitacion }}</td>
            </tr>
            <tr class="text2">
                <td class="text-right bold">Tipo de Habitación: </td>
                <td>{{ $registro_servicio->registro->habitacion->tipo_habitacion->nombre }}</td>
            </tr>
        </tbody>
    </table>

    <h4 class="text texto">Detalle</h4>
    <table class="table_detalles">
        <thead>
            <tr>
                <th width="13%">Cant</th>
                <th class="text-left" width="37%">Descripción</th>
                <th class="text-right">P/U</th>
                <th class="text-right">Total</th>
            </tr>
        </thead>
        <tbody>
            @php
                $detalles = $registro_servicio->servicio_detalles;
            @endphp
            @foreach ($detalles as $key_detalle => $detalle)
                <tr>
                    <td class="centreado">{{ $detalle->cantidad }}</td>
                    <td class="">{{ $detalle->producto->nombre }}</td>
                    <td class="text-right">{{ $detalle->precio_unitario }}</td>
                    <td class="text-right">{{ $detalle->total }}</td>
                </tr>
            @endforeach
        </tbody>
        <tfoot>
            <tr>
                <th colspan="3" class="text-right">TOTAL</th>
                <th class="text-right">{{ number_format($registro_servicio->total, 2, '.', '') }}
                </th>
            </tr>
        </tfoot>
    </table>

    <table class="firma">
        <tbody>
            <tr>
                <td class="border_firma"></td>
            </tr>
            <tr>
                <td class="centreado text2">
                    Firma del huesped
                </td>
            </tr>
        </tbody>
    </table>
    <p class="fecha_hora">{{ $registro_servicio->fecha_hora }}</p>
</body>

</html>

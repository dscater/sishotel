<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>MovimientoCajas</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1.5cm;
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

        table th,
        tbody td {
            padding: 3px;
            word-wrap: break-word;
        }

        table th {
            font-size: 9pt;
        }

        table td {
            font-size: 8pt;
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

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 0PX;
            margin-bottom: 15px;
            text-align: center;
            font-size: 14pt;
        }

        .texto {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: bold;
            font-size: 1.1em;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: normal;
            font-size: 0.85em;
        }

        .total {
            text-align: right;
            padding-right: 15px;
            font-weight: bold;
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

        .datos {
            margin-left: 15px;
            border-top: solid 1px;
            border-collapse: collapse;
            width: 250px;
        }

        .txt {
            font-weight: bold;
            text-align: right;
            padding-right: 5px;
        }

        .txt_center {
            font-weight: bold;
            text-align: center;
        }

        .cumplimiento {
            position: absolute;
            width: 150px;
            right: 0px;
            top: 86px;
        }

        .b_top {
            border-top: solid 1px black;
        }

        .gray {
            background: rgb(202, 202, 202);
        }

        .bg-principal {
            background: #153f59;
            color: white;
        }

        .egreso {
            color: red;
        }

        .img_celda img {
            width: 45px;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
    <div class="encabezado">
        <div class="logo">
            <img src="{{ $configuracion->first()->logo_b64 }}">
        </div>
        <h2 class="titulo">
            {{ $configuracion->first()->razon_social }}
        </h2>
        <h4 class="texto">MOVIMIENTOS DE CAJA</h4>
        <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
    </div>
    <table border="1">
        <thead class="bg-principal">
            <tr>
                <th width="3%">N°</th>
                <th width="8%">FECHA</th>
                <th>DESCRIPCIÓN</th>
                @foreach ($saldos_monedas as $sm)
                    <th width="12%">{{ $sm['simbolo'] }}</th>
                @endforeach
            </tr>
        </thead>
        <tbody>
            @php
                $cont = 1;
            @endphp
            @foreach ($movimiento_cajas as $item)
                <tr>
                    <td class="centreado">{{ $cont++ }}</td>
                    <td>{{ $item->fecha_hora }}</td>
                    <td>{{ $item->descripcion }}</td>
                    @foreach ($saldos_monedas as $sm)
                        <th>
                            @if ($sm['moneda_id_tc'] == $item->moneda_id_tc)
                                <span class="{{ $item->tipo == 'EGRESO' ? 'egreso' : '' }}">
                                    @if ($item->tipo == 'EGRESO')
                                        -
                                    @endif
                                    {{ $item->monto_tc }}
                                </span>
                            @endif
                        </th>
                    @endforeach
                </tr>
            @endforeach
        </tbody>
        <tfoot class="bg-principal">
            <tr>
                <th colspan="3">SALDOS TOTALES</th>
                @foreach ($saldos_monedas as $sm)
                    <th>
                        {{ $sm['saldo'] }}
                    </th>
                @endforeach
            </tr>
        </tfoot>
    </table>
</body>

</html>

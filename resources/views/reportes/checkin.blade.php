<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>CheckIn</title>
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
        <h4 class="text texto">FORMULARIO DE REGISTRO</h4>
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
    <table class="info2">
        <tbody>
            <tr>
                <td class="text2" width="15%">País (Country):</td>
                <td class="border_b">{{ $registro->cliente->pais }}</td>
                <td class="text2" width="13%">Ciudad (City):</td>
                <td class="border_b"></td>
                <td class="text2" width="12%">Nacionalidad (Nacionality):</td>
                <td class="border_b">{{ $registro->cliente->nacionalidad }}</td>
            </tr>
            <tr>
                <td class="text2">Empresa (Country):</td>
                <td class="border_b"></td>
                <td class="text2">Teléfono/Celular (Phone):</td>
                <td class="border_b">{{ $registro->cliente->fono }}</td>
                <td></td>
                <td></td>
            </tr>
        </tbody>
    </table>
    <table class="info2">
        <tbody>
            <tr>
                <td class="text2">Fecha de Ingreso (Check-In):</td>
                <td class="border_b">{{ $registro->fecha_entrada_t }}</td>
                <td class="text2">Fecha de Salida (Check-Out):</td>
                <td class="border_b">{{ $registro->fecha_salida_t }}</td>
            </tr>
            <tr>
                <td class="pt-2 text2">Hora/Time (Check-In):</td>
                <td class="pt-2 border_b">{{ $registro->hora_entrada }}</td>
                <td class="pt-2 text2">Hora/Time (Check-Out):</td>
                <td class="pt-2 border_b">{{ $registro->estado = 0 ? $registro->hora_salida : '12:00:00' }}</td>
            </tr>
        </tbody>
    </table>
    <table class="info2" style="margin-top:20px;">
        <tbody>
            <tr>
                <td class="text2 text-right bold" width="15%">TARIFA</td>
                <td class="border" width="20%">{{ $registro->cd }} {{ $simbolo }}</td>
                <td class="text2">{{ $registro->desayuno == 1 ? 'CON DESAYUNO' : '' }}</td>
                <td></td>
                <td class="text2" width="12%">Con Reserva:</td>
                <td class="border">{{ $registro->cod_reserva ? 'SI' : 'NINGUNO' }}</td>
            </tr>
            <tr>
                <td class="text2 bold text-right">GARANTÍA</td>
                <td class="">{{ $registro->garantia }} {{ $simbolo }}</td>
                <td>{{ $registro->garantia && $registro->garantia > 0 ? $registro->desc_garantia : '' }}</td>
                <td></td>
                <td class="text2" width="12%">Fecha de Reserva:</td>
                <td class="">{{ $registro->cod_reserva ? $registro->fecha_hora_reserva : '' }}</td>
            </tr>
        </tbody>
    </table>
    <table class="info2" style="margin-top:10px;">
        <tbody>
            <tr>
                <td class="text2 bold" width="43%">MONTO DE PAGO DEL INGRESO DEL HOSPEDAJE</td>
                <td class="border" width="15%">{{ $registro->adelanto }} {{ $simbolo }}</td>
                <td></td>
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

    <h4 class="text texto">REGLAMENTO DE HOSPEDAJE</h4>
    <p class="text2 txt_reglamento">
        1.- Toda persona que solicite hospedaje, debera presentar un documento de identidad, como ser (extranjeros)
        pasaportes internacionales salvo conducto de frontera o carnet
        de identidad de residencia en (nacionales) carnet de identidad, libreta militar, pasaporte nacional.<br />
        En caso de menores de edad carnet de identidad y libreta de familia que acredite parentesco con los
        acompañantes.
    </p>
    <p class="text2 txt_reglamento">
        2.- El ingreso es exclusivo para mayores de 18 anos, el hotel se reserva el derecho admision por irregularidades
        de identidad.
    </p>
    <p class="text2 txt_reglamento">
        3.- La tarifa es por noche, y se cobrara por adelantado, la hora de salida o Check out es 12:30 pm. del dia
        siguiente del pernocte, pasara la hora se cobrara media tarifa mas
        hasta las 18:00 pm. y tarifa completa pasado las 18:00 horas.
    </p>
    <p class="text2 txt_reglamento">
        4.- Las visitas se recibiran en el lobby del hotel o en el restaurante, queda terminantemente prohibido recibir
        visitas en las habitaciones, caso contrario se registrara el visitante
        como huesped y se cobrara una tarifa adicional al huesped.
    </p>
    <p class="text2 txt_reglamento">
        5.- En caso de que el huesped no retire sus pertenecias de la habitacion, contabiliza como habitacion ocupada y
        se cobrara como hospedaje.
    </p>
    <p class="text2 txt_reglamento">
        6.- Todo huesped portador de: (dinero, joyas, artefactos, de valor y otros)debe usar el servicio de caja de
        seguridad del hotel, esto para evitar perdidas y robos. EL HOTEL, no
        se responzabiliza por perdidas o extravios que no hayan sido registrados o depositados en la caja de seguridad.
    </p>
    <p class="text2 txt_reglamento">
        7.- El husped debera depositar en recepcion la suma Bs. 150, como garantia de hospedaje, el mismo que sera
        devuelto en el momento de Check-out salida.
    </p>
    <p class="text2 txt_reglamento">
        8.- El huesped es responsable de todos los items ubicados en las habitaciones como ser: toallas, telefono,
        televisor, control remoto y otros, en caso de perdidas, destrozos o
        roturas de los mencionados items, se descontara de la garantia o sea se cobrara directamente al huesped.
    </p>
    <p class="text2 txt_reglamento">
        9.- El ingreso en horas tope 05:00 a.m. (madrugada) es considerada pernocte y la salida sera a las 12:30 p.m.
        del mismo dia.
    </p>
    <p class="text2 txt_reglamento">
        10.- El ingreso a partir de las 06:00 a.m. es considerado un check-in normal y su salida sera hasta horas 12:30
        p.m. del dia siguiente.
    </p>
    <p class="text2 txt_reglamento">
        11.- En caso de que el huesped incurra en la comision de alguno o varios de los delitos tipificados por la Ley
        1008 utilizando la habitacion contratada, estos seran
        de la unica y exclusiva responsabilidad del huesped no alcanzando estos hechos en cuanto a sus efectos legales,
        a la empresa de hospedaje turistico por ser
        totalmente ajena a las actividades ilicitas del huesped.
    </p>
    <p class="text2 txt_reglamento">
        12.- Servicio de Room Service tiene un costo de 10 Bs.
    </p>
    <p class="text2 txt_reglamento">
        13.-
        Yo..............................................................................................................acepto
        cada una de las clausulas mencionadas en el reglamento de hospedaje, y en senal de
        conformidad firmo al pie del presente registro el,
        Dia............................ de .................................. de 20............
    </p>
    <h4 class="text texto">CUESTIONARIO</h4>
    <p class="text2 txt_reglamento2">
        Qué opina del servicio de hospedaje que se le brindo en el hotel?
    </p>
    <p class="text2 txt_punteado"></p>
    <p class="text2 txt_punteado"></p>
    <p class="text2 txt_reglamento2">
        Sugerencias
    </p>
    <p class="text2 txt_punteado"></p>
    <p class="text2 txt_punteado"></p>
</body>

</html>

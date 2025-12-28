<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
const { props: props_page } = usePage();
const appStore = useAppStore();

onBeforeMount(() => {});

const oCaja = ref(null);
const verificaCaja = () => {
    axios.get(route("cajas.verificaCajaAbierta")).then((response) => {
        oCaja.value = response.data.caja;
        if (oCaja.value) {
            oCaja.value.fecha_hora_cierre = getFechaHoraCierre();
            oCaja.value.fecha_cierre = getFechaActual();
            oCaja.value.hora_cierre = getHoraActual();
            cargarMovimientoCajas();
        }
    });
};

const updateFechaCierre = () => {
    oCaja.value.fecha_cierre = getFechaActual();
    oCaja.value.hora_cierre = getHoraActual();
    oCaja.value.fecha_hora_cierre = getFechaHoraCierre();
};

const abrirCaja = () => {
    Swal.fire({
        title: "¿Realizar apertura de caja?",
        html: `Se abrirá la caja para el día de hoy.`,
        showCancelButton: true,
        confirmButtonText: "Si, aperturar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
        customClass: {
            confirmButton: "btn-primary",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            axios.post(route("cajas.aperturarCaja")).then((response) => {
                Swal.fire({
                    icon: "success",
                    title: "¡Aperturada!",
                    html: `La caja ha sido aperturada con éxito.`,
                    confirmButtonText: `Aceptar`,
                    customClass: {
                        confirmButton: "btn-success",
                    },
                });
                verificaCaja();
            });
        }
    });
};

const getFechaActual = () => {
    const fecha = new Date();
    const dia = String(fecha.getDate()).padStart(2, "0");
    const mes = String(fecha.getMonth() + 1).padStart(2, "0");
    const anio = fecha.getFullYear();
    return `${anio}-${mes}-${dia}`;
};

const getFechaActualTxt = () => {
    const fecha = new Date();
    const dia = String(fecha.getDate()).padStart(2, "0");
    const mes = String(fecha.getMonth() + 1).padStart(2, "0");
    const anio = fecha.getFullYear();
    return `${dia}/${mes}/${anio}`;
};

const getHoraActual = () => {
    const fecha = new Date();
    const horas = String(fecha.getHours()).padStart(2, "0");
    const minutos = String(fecha.getMinutes()).padStart(2, "0");
    const segundos = String(fecha.getSeconds()).padStart(2, "0");
    return `${horas}:${minutos}:${segundos}`;
};

const getFechaHoraCierre = () => {
    return getFechaActualTxt() + " " + getHoraActual();
};

const listMovimientoCajas = ref([]);
const listMonedasSaldos = ref([]);
const cargarMovimientoCajas = () => {
    if (!oCaja.value) return;
    axios
        .get(route("cajas.movimiento_cajas", { caja_id: oCaja.value.id }))
        .then((response) => {
            listMovimientoCajas.value = response.data.movimiento_cajas;
            listMonedasSaldos.value = response.data.saldos_monedas;
        });
};

const reporteMovimientos = () => {
    window.open(
        route("reportes.r_movimiento_cajas") + "?caja_id=" + oCaja.value.id,
        "_blank"
    );
};

onMounted(async () => {
    verificaCaja();
    appStore.stopLoading();
});
</script>
<template>
    <Head title="Cierre de Caja"></Head>

    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Cierre de Caja</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">Cierre de Caja</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>

        <div class="row">
            <div class="col-12 font-weight-bold mb-2">
                CAJA:
                <span
                    class="badge text-sm"
                    :class="{
                        'bg4 text-success': oCaja,
                        'bg8 text-danger': !oCaja,
                    }"
                    ><i class="fa fa-circle"></i
                    >{{ oCaja ? " ABIERTO" : " CERRADO" }}</span
                >
                <button
                    class="btn bg-primary btn-sm text-xs ml-1"
                    title="Aperturar Caja"
                    @click.prevent="abrirCaja"
                    v-if="!oCaja"
                >
                    <i class="fa fa-external-link-alt"></i>
                </button>
            </div>

            <div class="col-12" v-if="oCaja">
                <div class="card">
                    <div class="card-body">
                        <div class="row bg7">
                            <div class="col-md-6 py-2">
                                <div class="row">
                                    <div
                                        class="col-4 font-weight-bold text-right"
                                    >
                                        Fecha Apertura:
                                    </div>
                                    <div class="col-8">
                                        {{ oCaja.fecha_hora_apertura }}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 py-2 bg4">
                                <div class="row">
                                    <div
                                        class="col-4 font-weight-bold text-right"
                                    >
                                        Fecha Cierre:
                                    </div>
                                    <div class="col-8">
                                        {{ oCaja.fecha_hora_cierre }}
                                        <i
                                            class="fa fa-sync cursor-pointer ml-2"
                                            @click.prevent="updateFechaCierre()"
                                        ></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">
                        <h5>
                            Registros realizados:
                            {{ listMovimientoCajas.length }}
                        </h5>
                        <div class="row mb-2">
                            <div
                                class="col-12 d-flex w-100 justify-content-between"
                            >
                                <button class="btn bg-danger" @click="">
                                    Cerrar Caja <i class="fa fa-times"></i>
                                </button>
                                <!-- <button class="btn bg-principal">
                                    Exportar Ingresos de Recepción
                                    <i class="fa fa-file-pdf"></i>
                                </button> -->
                                <button
                                    class="btn bg-secundario"
                                    @click.prevent="reporteMovimientos"
                                >
                                    Exportar <i class="fa fa-file-pdf"></i>
                                </button>
                            </div>
                        </div>
                        <table class="table table-bordered table-container">
                            <thead class="bg2">
                                <th>N°</th>
                                <th>Fecha</th>
                                <th>Descripción</th>
                                <th v-for="item_moneda in listMonedasSaldos">
                                    {{ item_moneda.simbolo }}
                                </th>
                            </thead>
                            <tbody>
                                <tr
                                    v-for="(item, index) in listMovimientoCajas"
                                >
                                    <td>{{ index + 1 }}</td>
                                    <td>{{ item.fecha_hora }}</td>
                                    <td>{{ item.descripcion }}</td>

                                    <td
                                        v-for="item_moneda in listMonedasSaldos"
                                        :class="{
                                            bg7:
                                                item_moneda.moneda_id_tc !=
                                                item.moneda_id_tc,
                                        }"
                                    >
                                        <span
                                            :class="{
                                                'text-success':
                                                    item.tipo == 'INGRESO',
                                                'text-danger':
                                                    item.tipo == 'EGRESO',
                                            }"
                                            v-if="
                                                item_moneda.moneda_id_tc ==
                                                item.moneda_id_tc
                                            "
                                            ><i
                                                class="fa"
                                                :class="{
                                                    'fa-arrow-up':
                                                        item.tipo == 'INGRESO',
                                                    'fa-arrow-down':
                                                        item.tipo == 'EGRESO',
                                                }"
                                            ></i>
                                            {{ item.monto_tc }}
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr class="bg2">
                                    <th colspan="3" class="text-right">
                                        SALDOS CIERRE
                                    </th>
                                    <th
                                        v-for="item_moneda in listMonedasSaldos"
                                    >
                                        {{ item_moneda.saldo }}
                                        {{ item_moneda.simbolo }}
                                    </th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-12" v-else>
                <div class="alert alert-info">
                    No hay ninguna caja abierta en este momento.
                </div>
            </div>
        </div>
    </Content>
</template>

<style scoped>
.table-container {
    max-height: 200px;
    overflow-y: auto;
    border: 1px solid #ccc;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th,
td {
    padding: 8px;
    border-bottom: 1px solid #ddd;
}

thead th {
    position: sticky;
    top: 0;
}
</style>

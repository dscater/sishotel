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
        oCaja.value = response.data;
        if (oCaja.value) {
            oCaja.value.fecha_hora_cierre = getFechaHoraCierre();
            oCaja.value.fecha_cierre = getFechaActual();
            oCaja.value.hora_cierre = getHoraActual();
            cargarMovimientoCajas();
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

const getHoraActual = () => {
    const fecha = new Date();
    const horas = String(fecha.getHours()).padStart(2, "0");
    const minutos = String(fecha.getMinutes()).padStart(2, "0");
    const segundos = String(fecha.getSeconds()).padStart(2, "0");
    return `${horas}:${minutos}:${segundos}`;
};

const getFechaHoraCierre = () => {
    return getFechaActual() + " " + getHoraActual();
};

const listMovimientoCajas = ref([]);
const cargarMovimientoCajas = () => {
    if (!oCaja.value) return;
    axios
        .get(route("cajas.movimiento_cajas", { caja_id: oCaja.value.id }))
        .then((response) => {
            listMovimientoCajas.value = response.data;
        });
};

const listMonedas = ref([]);
const cargarMonedas = () => {
    axios.get(route("monedas.listado")).then((response) => {
        listMonedas.value = response.data.monedas;
    });
};

onMounted(async () => {
    verificaCaja();
    cargarMonedas();
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
                            <div class="col-md-6 py-2 bg8">
                                <div class="row">
                                    <div
                                        class="col-4 font-weight-bold text-right"
                                    >
                                        Fecha Cierre:
                                    </div>
                                    <div class="col-8">
                                        {{ oCaja.fecha_hora_cierre }}
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- TODO: Obtener suma total por monedas -->
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">
                        <h5>
                            Registros realizados:
                            {{ listMovimientoCajas.length }}
                        </h5>
                        <table class="table table-bordered">
                            <thead>
                                <th>N°</th>
                                <th>Descripción</th>
                                <th v-for="item_moneda in listMonedas">
                                    {{ item_moneda.simbolo }}
                                </th>
                            </thead>
                            <tbody>
                                <tr
                                    v-for="(item, index) in listMovimientoCajas"
                                >
                                    <td>{{ index + 1 }}</td>
                                    <td>{{ item.descripcion }}</td>

                                    <td v-for="item_moneda in listMonedas">
                                        <span
                                            v-if="
                                                item_moneda.id == 1 &&
                                                item.tc == 0
                                            "
                                            >{{ item.monto }}</span
                                        >
                                        <span
                                            v-if="
                                                item.tc == 1 &&
                                                item_moneda.id ==
                                                    item.moneda_id_tc
                                            "
                                            >{{ item.monto }}</span
                                        >
                                    </td>
                                </tr>
                            </tbody>
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

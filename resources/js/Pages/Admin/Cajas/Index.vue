<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { useCajas } from "@/composables/cajas/useCajas";
import { ref, onMounted, onBeforeMount } from "vue";
import Formulario from "./Formulario.vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useAxios } from "@/composables/axios/useAxios";
const { props: props_page } = usePage();
const props = defineProps({
    saldos_monedas: {
        type: Array,
        default: [],
    },
    saldos_efectivo: {
        type: Array,
        default: [],
    },
    saldos_banco: {
        type: Array,
        default: [],
    },
});
const appStore = useAppStore();
const { axiosDelete } = useAxios();

onBeforeMount(() => {});

const { setCaja, limpiarCaja } = useCajas();

const miTable = ref(null);

const headers = [
    // {
    //     label: "Nro.",
    //     key: "id",
    //     sortable: true,
    //     width: "1%",
    //     fixed: true,
    // },
    {
        label: "DESCRIPCIÓN",
        key: "descripcion",
        sortable: true,
        fixed: true,
    },
    {
        label: "MONTO",
        key: "monto",
        sortable: true,
    },
    {
        label: "TIPO DE MOVIMIENTO",
        key: "tipo",
        sortable: true,
    },
    {
        label: "TIPO",
        key: "efectivo_banco",
        sortable: true,
    },
    {
        label: "RESPONSABLE",
        key: "user.full_name",
        sortable: true,
    },
    {
        label: "FECHA",
        key: "fecha_hora",
        sortable: true,
    },
];

const multiSearch = ref({
    search: "",
    filtro: [],
});

const accion_formulario = ref(0);
const muestra_formulario = ref(false);

const agregarRegistro = () => {
    limpiarCaja();
    accion_formulario.value = 0;
    muestra_formulario.value = true;
};

const updateDatatable = async () => {
    if (miTable.value) {
        await miTable.value.cargarDatos();
        muestra_formulario.value = false;
    }
};

const eliminarCaja = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.nombre}</strong>`,
        showCancelButton: true,
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
        customClass: {
            confirmButton: "btn-danger",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await axiosDelete(route("cajas.destroy", item.id));
            if (respuesta && respuesta.sw) {
                updateDatatable();
            }
        }
    });
};

const oCaja = ref(null);
const verificaCaja = () => {
    axios.get(route("cajas.verificaCajaAbierta")).then((response) => {
        oCaja.value = response.data.caja;
    });
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

onMounted(async () => {
    verificaCaja();
    appStore.stopLoading();
});
</script>
<template>
    <Head title="Cajas"></Head>

    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Cajas</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">Cajas</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>

        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-12 font-weight-bold mb-2">
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
                        <table class="saldos_caja mt-1">
                            <thead class="bg-secundario">
                                <tr>
                                    <th
                                        class="text-center font-weight-bold"
                                        :colspan="saldos_monedas.length + 1"
                                    >
                                        SALDOS
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-secundario">
                                <tr>
                                    <td></td>
                                    <td v-for="item in saldos_monedas">
                                        {{ item.simbolo }}
                                    </td>
                                </tr>
                                <tr class="bg4 text-dark">
                                    <td class="text-left">EFECTIVO</td>
                                    <td
                                        v-for="(
                                            item_moneda, index
                                        ) in saldos_monedas"
                                    >
                                        <span v-if="saldos_efectivo[index]">
                                            {{ saldos_efectivo[index].saldo }}
                                            {{ saldos_efectivo[index].simbolo }}
                                        </span>
                                        <span v-else
                                            >0.00
                                            {{ item_moneda.simbolo }}</span
                                        >
                                    </td>
                                </tr>
                                <tr class="bg7 text-dark">
                                    <td class="text-left">BANCO</td>
                                    <td
                                        v-for="(
                                            item_moneda, index
                                        ) in saldos_monedas"
                                    >
                                        <span v-if="saldos_banco[index]">
                                            {{ saldos_banco[index].saldo }}
                                            {{ saldos_banco[index].simbolo }}
                                        </span>
                                        <span v-else
                                            >0.00
                                            {{ item_moneda.simbolo }}</span
                                        >
                                    </td>
                                </tr>
                                <tr>
                                    <td>TOTAL</td>
                                    <td class="" v-for="item in saldos_monedas">
                                        {{ item.saldo }}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <button
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'cajas.create'
                                )
                            "
                            type="button"
                            class="btn btn-primary"
                            @click="agregarRegistro"
                        >
                            <i class="fa fa-plus"></i> Nuevo Movimiento
                        </button>
                    </div>
                    <div class="col-md-8 my-1">
                        <div class="row justify-content-end">
                            <div class="col-md-5">
                                <div
                                    class="input-group"
                                    style="align-items: end"
                                >
                                    <input
                                        type="search"
                                        v-model="multiSearch.search"
                                        placeholder="Buscar"
                                        class="form-control border-1 border-right-0"
                                    />
                                    <div class="input-append">
                                        <button
                                            class="btn btn-default rounded-0 border-left-0"
                                            @click="updateDatos"
                                        >
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <MiTable
                            :tableClass="'bg-white mitabla'"
                            ref="miTable"
                            :cols="headers"
                            :api="true"
                            :url="route('cajas.paginado')"
                            :numPages="5"
                            :multiSearch="multiSearch"
                            :syncOrderBy="'id'"
                            :syncOrderAsc="'DESC'"
                            table-responsive
                            :header-class="'bg__primary'"
                            fixed-header
                        >
                            <template #monto="{ item }">
                                <span>
                                    {{ item.monto_tc }}
                                    {{ item.moneda_tc?.simbolo }}
                                </span>
                            </template>
                            <template #tipo="{ item }">
                                <span
                                    class="badge text-sm"
                                    :class="{
                                        'bg4 text-success':
                                            item.tipo == 'INGRESO',
                                        'bg8 text-danger':
                                            item.tipo == 'EGRESO',
                                    }"
                                >
                                    {{ item.tipo }}
                                </span>
                            </template>

                            <template #accion="{ item }">
                                <el-tooltip
                                    class="box-item"
                                    effect="dark"
                                    content="Editar"
                                    placement="left-start"
                                >
                                    <button
                                        class="btn btn-warning"
                                        @click="
                                            setCaja(item);
                                            accion_formulario = 1;
                                            muestra_formulario = true;
                                        "
                                        v-if="
                                            props_page.auth?.user.permisos ==
                                                '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'cajas.edit'
                                            )
                                        "
                                    >
                                        <i class="fa fa-pen"></i></button
                                ></el-tooltip>
                                <template v-if="item.id != 1">
                                    <el-tooltip
                                        class="box-item"
                                        effect="dark"
                                        content="Eliminar"
                                        placement="left-start"
                                    >
                                        <button
                                            class="btn btn-danger"
                                            @click="eliminarCaja(item)"
                                            v-if="
                                                props_page.auth?.user
                                                    .permisos == '*' ||
                                                props_page.auth?.user.permisos.includes(
                                                    'cajas.destroy'
                                                )
                                            "
                                        >
                                            <i
                                                class="fa fa-trash-alt"
                                            ></i></button
                                    ></el-tooltip>
                                </template>
                            </template>
                        </MiTable>
                    </div>
                </div>
            </div>
        </div>
        <Formulario
            :muestra_formulario="muestra_formulario"
            :accion_formulario="accion_formulario"
            @envio-formulario="updateDatatable"
            @cerrar-formulario="muestra_formulario = false"
        ></Formulario>
    </Content>
</template>

<style scoped>
.saldos_caja {
    margin-bottom: 10px;
}

.saldos_caja td {
    padding: 5px;
    border: solid 1px;
    font-size: 1.1em;
    text-align: center;
}

.saldos_caja tr:nth-child(1) {
    font-weight: bold;
}
</style>

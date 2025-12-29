<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useRegistros } from "@/composables/registros/useRegistros";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useAxios } from "@/composables/axios/useAxios";
import FormularioReserva from "./FormularioReserva.vue";
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
// toast.success("Operación completada correctamente!");
const { props: props_page } = usePage();
const appStore = useAppStore();
const { axiosDelete } = useAxios();
const { oRegistro, limpiarRegistro, setRegistro } = useRegistros();

onBeforeMount(() => {});

const miTable = ref(null);

const headers = [
    {
        label: "N°",
        key: "id",
        sortable: true,
        width: "3%",
        fixed: true,
    },
    {
        label: "FECHA ENTRADA",
        key: "fecha_hora_entrada",
        sortable: true,
        width: "3%",
        fixed: true,
    },
    {
        label: "FECHA SALIDA",
        key: "fecha_hora_salida",
        sortable: true,
        width: "3%",
        fixed: true,
    },
    {
        label: "ESTADO",
        key: "estado",
        sortable: true,
        width: "110px",
        fixed: true,
    },
    {
        label: "CLIENTE",
        key: "cliente.nombre",
        sortable: true,
    },
    {
        label: "HABITACIÓN",
        key: "habitacion.numero_habitacion",
        sortable: true,
    },
    {
        label: "DÍAS ESTADÍA",
        key: "dias_estadia",
        sortable: true,
    },
    {
        label: "PRECIO/DÍA",
        key: "cd",
        sortable: true,
    },
    {
        label: "TOTAL",
        key: "total",
        sortable: true,
    },
    {
        label: "TIPO REGISTRO",
        key: "tipo",
        sortable: true,
    },
    {
        label: "FECHA DE RESERVA",
        key: "fecha_hora_reserva",
        sortable: true,
    },
    {
        label: "ACCIÓN",
        key: "accion",
        fixed: "right",
        width: "4%",
    },
];

const multiSearch = ref({
    search: "",
    filtro: [],
});

const accion_formulario = ref(0);
const muestra_formulario = ref(false);

const agregarRegistro = () => {
    limpiarRegistro();
    accion_formulario.value = 0;
    muestra_formulario.value = true;
};

const updateDatatable = async () => {
    if (miTable.value) {
        await miTable.value.cargarDatos();
        muestra_formulario.value = false;
    }
};

const eliminarRegistro = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.cod_reserva}</strong>`,
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
            let respuesta = await axiosDelete(
                route("registros.destroy", item.id)
            );
            if (respuesta && respuesta.sw) {
                updateDatatable();
            }
        }
    });
};

const getCheckIn = (item) => {
    window.open(route("registros.checkin", item.id), "_blank");
};
const getCheckOut = (item) => {
    window.open(route("registros.checkout", item.id), "_blank");
};

onMounted(async () => {
    appStore.stopLoading();
});
</script>
<template>
    <Head title="Historial de Registros"></Head>

    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Historial de Registros</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Historial de Registros
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>

        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-4"></div>
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
                            :url="route('registros.paginado')"
                            :numPages="5"
                            :multiSearch="multiSearch"
                            :syncOrderBy="'id'"
                            :syncOrderAsc="'DESC'"
                            table-responsive
                            :header-class="'bg__primary'"
                            fixed-header
                        >
                            <template #estado="{ item }">
                                <span
                                    class="badge text-wrap text-xs"
                                    :class="{
                                        'bg-info': item.estado == 2,
                                        'bg-success': item.estado == 1,
                                        'bg-warning': item.estado == 0,
                                    }"
                                >
                                    {{
                                        item.estado == 2
                                            ? "RESERVA PENDIENTE"
                                            : item.estado == 1
                                            ? "ACTIVO"
                                            : "FINALIZADO"
                                    }}
                                </span>
                            </template>

                            <template
                                #[`habitacion.numero_habitacion`]="{ item }"
                            >
                                {{ item.habitacion.numero_habitacion }}<br />
                                {{ item.habitacion.tipo_habitacion.nombre }}
                            </template>
                            <template v-slot:[`cliente.nombre`]="{ item }">
                                {{ item.cliente.nombre }}
                                {{ item.cliente.paterno }}
                                {{ item.cliente.materno }}
                            </template>

                            <template #accion="{ item }">
                                <el-tooltip
                                    class="box-item"
                                    effect="dark"
                                    content="Check-In"
                                    placement="left-start"
                                    v-if="item.estado != 2"
                                >
                                    <button
                                        class="btn btn-success"
                                        @click="getCheckIn(item)"
                                    >
                                        <i class="fa fa-file-pdf"></i></button
                                ></el-tooltip>
                                <el-tooltip
                                    class="box-item"
                                    effect="dark"
                                    content="Check-Out"
                                    placement="left-start"
                                    v-if="item.estado != 2"
                                >
                                    <button
                                        class="btn btn-warning"
                                        @click="getCheckOut(item)"
                                    >
                                        <i class="fa fa-file-pdf"></i></button
                                ></el-tooltip>
                            </template>
                        </MiTable>
                    </div>
                </div>
            </div>
        </div>
        <FormularioReserva
            :muestra_formulario="muestra_formulario"
            :accion_formulario="accion_formulario"
            @envio-formulario="updateDatatable"
            @cerrar-formulario="muestra_formulario = false"
        ></FormularioReserva>
    </Content>
</template>

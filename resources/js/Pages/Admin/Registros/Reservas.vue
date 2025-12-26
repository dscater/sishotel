<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { useRegistros } from "@/composables/registros/useRegistros";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useAxios } from "@/composables/axios/useAxios";
import FormularioReserva from "./FormularioReserva.vue";
// TOAST
// import { toast } from "vue3-toastify";
// import "vue3-toastify/dist/index.css";
// toast.success("Operación completada correctamente!");
const { props: props_page } = usePage();
const appStore = useAppStore();
const { axiosDelete } = useAxios();
const { oRegistro, limpiarRegistro, setRegistro } = useRegistros();

onBeforeMount(() => {});

const miTable = ref(null);

const headers = [
    {
        label: "CÓDIGO",
        key: "cod_reserva",
        sortable: true,
        width: "3%",
    },
    {
        label: "FECHA ENTRADA",
        key: "fecha_entrada_t",
        sortable: true,
        width: "3%",
    },
    {
        label: "FECHA SALIDA",
        key: "fecha_salida_t",
        sortable: true,
        width: "3%",
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
        label: "FECHA DE RESERVA",
        key: "fecha_hora_reserva",
        sortable: true,
    },
    {
        label: "ESTADO",
        key: "estado",
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

onMounted(async () => {
    appStore.stopLoading();
});
</script>
<template>
    <Head title="Lista de Reservas"></Head>

    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Lista de Reservas</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Lista de Reservas
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
                    <div class="col-md-4">
                        <button
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'registros.create'
                                )
                            "
                            type="button"
                            class="btn btn-primary"
                            @click="agregarRegistro"
                        >
                            <i class="fa fa-plus"></i> Nueva Reserva
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
                            :url="route('registros.reservasPaginado')"
                            :numPages="5"
                            :multiSearch="multiSearch"
                            :syncOrderBy="'id'"
                            :syncOrderAsc="'DESC'"
                            table-responsive
                            :header-class="'bg__primary'"
                            fixed-header
                        >
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
                                <!-- TODO: Habilitar Boton para iniciar HOSPEDAJE de reservas con fecha de hoy -->
                                <el-tooltip
                                    class="box-item"
                                    effect="dark"
                                    content="Editar"
                                    placement="left-start"
                                >
                                    <button
                                        class="btn btn-warning"
                                        @click="
                                            setRegistro(item);
                                            accion_formulario = 1;
                                            muestra_formulario = true;
                                        "
                                        v-if="
                                            props_page.auth?.user.permisos ==
                                                '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'registros.edit'
                                            )
                                        "
                                    >
                                        <i class="fa fa-pen"></i></button
                                ></el-tooltip>
                                <el-tooltip
                                    class="box-item"
                                    effect="dark"
                                    content="Eliminar"
                                    placement="left-start"
                                >
                                    <button
                                        class="btn btn-danger"
                                        @click="eliminarRegistro(item)"
                                        v-if="
                                            props_page.auth?.user.permisos ==
                                                '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'registros.destroy'
                                            )
                                        "
                                    >
                                        <i class="fa fa-trash-alt"></i></button
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

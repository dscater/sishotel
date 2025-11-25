<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { useHabitacions } from "@/composables/habitacions/useHabitacions";
import { ref, onMounted, onBeforeMount } from "vue";
import Formulario from "./Formulario.vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useAxios } from "@/composables/axios/useAxios";
// TOAST
// import { toast } from "vue3-toastify";
// import "vue3-toastify/dist/index.css";
// toast.success("Operación completada correctamente!");
const { props: props_page } = usePage();
const appStore = useAppStore();
const { axiosDelete } = useAxios();

onBeforeMount(() => {});

const { setHabitacion, limpiarHabitacion } = useHabitacions();

const miTable = ref(null);

const headers = [
    {
        label: "CÓDIGO",
        key: "numero_habitacion",
        sortable: true,
        width: "3%",
    },
    {
        label: "TIPO DE HABITACIÓN",
        key: "tipo_habitacion.nombre",
        keySortable: "tipo_habitacions.nombre",
        sortable: true,
    },
    {
        label: "PISO",
        key: "piso",
        sortable: true,
    },
    {
        label: "PRECIO",
        key: "precio",
        sortable: true,
    },
    {
        label: "PRECIO TEMPORAL",
        key: "precio_temp",
        sortable: true,
    },
    {
        label: "CAPACIDAD",
        key: "capacidad",
        sortable: true,
    },
    {
        label: "ESTADO",
        key: "estado_t",
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
    limpiarHabitacion();
    accion_formulario.value = 0;
    muestra_formulario.value = true;
};

const updateDatatable = async () => {
    if (miTable.value) {
        await miTable.value.cargarDatos();
        muestra_formulario.value = false;
    }
};

const eliminarHabitacion = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.full_name}</strong>`,
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
                route("habitacions.destroy", item.id)
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
    <Head title="Habitaciones"></Head>

    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Habitaciones</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">Habitaciones</li>
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
                                    'habitacions.create'
                                )
                            "
                            type="button"
                            class="btn btn-primary"
                            @click="agregarRegistro"
                        >
                            <i class="fa fa-plus"></i> Nueva Habitación
                        </button>
                        <Link
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'habitacions.eliminados'
                                )
                            "
                            class="btn btn-outline-danger mx-1"
                            :href="route('habitacions.eliminados')"
                        >
                            <i class="fa fa-trash"></i> Eliminados
                        </Link>
                    </div>
                    <div class="col-md-8 my-1">
                        <div class="row justify-content-end">
                            <div class="col-md-5">
                                <div
                                    class="input-group"
                                    style="align-items: end"
                                >
                                    <input
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
                            :url="route('habitacions.paginado')"
                            :numPages="5"
                            :multiSearch="multiSearch"
                            :syncOrderBy="'id'"
                            :syncOrderAsc="'DESC'"
                            table-responsive
                            :header-class="'bg__primary'"
                            fixed-header
                        >
                            <template #estado_t="{ item }">
                                <span
                                    class="badge text-xs"
                                    :class="[
                                        {
                                            'badge-success': item.estado == 0,
                                            'badge-danger': item.estado == 1,
                                            'badge-warning': item.estado == 2,
                                        },
                                    ]"
                                    >{{ item.estado_t }}</span
                                >
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
                                            setHabitacion(item);
                                            accion_formulario = 1;
                                            muestra_formulario = true;
                                        "
                                        v-if="
                                            props_page.auth?.user.permisos ==
                                                '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'habitacions.edit'
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
                                        @click="eliminarHabitacion(item)"
                                        v-if="
                                            props_page.auth?.user.permisos ==
                                                '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'habitacions.destroy'
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

        <Formulario
            :muestra_formulario="muestra_formulario"
            :accion_formulario="accion_formulario"
            @envio-formulario="updateDatatable"
            @cerrar-formulario="muestra_formulario = false"
        ></Formulario>
    </Content>
</template>

<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { useClientes } from "@/composables/clientes/useClientes";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useAxios } from "@/composables/axios/useAxios";
const { props: props_page } = usePage();
const appStore = useAppStore();
const { axiosDelete, axiosPost } = useAxios();

onBeforeMount(() => {
    appStore.startLoading();
});

const { setCliente, limpiaCliente } = useClientes();

const miTable = ref(null);

const headers = [
    {
        label: "",
        key: "id",
        sortable: true,
        width: "3%",
    },
    {
        label: "AP. PATERNO",
        key: "paterno",
        sortable: true,
    },
    {
        label: "AP. MATERNO",
        key: "materno",
        sortable: true,
    },
    {
        label: "NOMBRE(S)",
        key: "nombre",
        sortable: true,
    },
    {
        label: "C.I.",
        key: "full_ci",
        sortable: true,
    },
    {
        label: "DIRECCIÓN",
        key: "dir",
        sortable: true,
    },
    {
        label: "CORREO",
        key: "correo",
    },
    {
        label: "TELÉFONO",
        key: "fono",
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

const updateDatatable = async () => {
    if (miTable.value) {
        await miTable.value.cargarDatos();
    }
};

const restaurar = (item) => {
    Swal.fire({
        title: "¿Quierés resturar este registro?",
        html: `<strong>${item.full_name}</strong>`,
        showCancelButton: true,
        confirmButtonText: "Si, restaurar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
        customClass: {
            confirmButton: "btn-success",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await axiosPost(
                route("clientes.reestablecer", item.id),
                {
                    _method: "patch",
                }
            );
            if (respuesta && respuesta.sw) {
                updateDatatable();
            }
        }
    });
};

const eliminarCliente = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar definitivamente este registro?",
        html: `<strong>${item.full_name}</strong><br/>Esta acción no se puede deshacer.`,
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
                route("clientes.eliminacion_permanente", item.id)
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
    <Head title="Clientes"></Head>

    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0 text-lg">
                        Clientes <small>> Eliminados</small>
                    </h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item">
                            <Link :href="route('clientes.index')"
                                >Clientes</Link
                            >
                        </li>
                        <li class="breadcrumb-item active">Eliminados</li>
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
                                    'clientes.create'
                                )
                            "
                            type="button"
                            class="btn btn-primary"
                            @click="agregarRegistro"
                        >
                            <i class="fa fa-plus"></i> Nueva Cliente
                        </button>
                        <Link
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'clientes.index'
                                )
                            "
                            class="btn btn-outline-dark mx-1"
                            :href="route('clientes.index')"
                        >
                            <i class="fa fa-arrow-left"></i> Volver
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
                            :url="route('clientes.paginado_eliminados')"
                            :numPages="5"
                            :multiSearch="multiSearch"
                            :syncOrderBy="'id'"
                            :syncOrderAsc="'DESC'"
                            table-responsive
                            :header-class="'bg__primary'"
                            fixed-header
                        >
                            <template #accion="{ item }">
                                <el-tooltip
                                    class="box-item"
                                    effect="dark"
                                    content="Restaurar"
                                    placement="left-start"
                                >
                                    <button
                                        class="btn btn-success"
                                        @click="restaurar(item)"
                                        v-if="
                                            props_page.auth.user.permisos ==
                                                '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'clientes.reestablecer'
                                            )
                                        "
                                    >
                                        <i class="fa fa-sync"></i></button
                                ></el-tooltip>
                                <el-tooltip
                                    class="box-item"
                                    effect="dark"
                                    content="Eliminar definitivamente"
                                    placement="left-start"
                                >
                                    <button
                                        class="btn btn-danger"
                                        @click="eliminarCliente(item)"
                                        v-if="
                                            props_page.auth.user.permisos ==
                                                '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'clientes.eliminacion_permanente'
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
    </Content>
</template>

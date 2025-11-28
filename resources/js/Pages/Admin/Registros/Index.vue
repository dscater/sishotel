<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount, onBeforeUnmount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import FormRegistro from "./FormRegistro.vue";
const { props: props_page } = usePage();
const appStore = useAppStore();

onBeforeMount(() => {
    document.getElementsByTagName("body")[0].classList.add("sidebar-mini");
    document.getElementsByTagName("body")[0].classList.add("sidebar-collapse");
});

onBeforeUnmount(() => {
    document.getElementsByTagName("body")[0].classList.remove("sidebar-mini");
    document
        .getElementsByTagName("body")[0]
        .classList.remove("sidebar-collapse");
});
onMounted(async () => {
    cargarListas();
    appStore.stopLoading();
});

const muestra_formulario = ref(false);
const accion_formulario = ref(0);

const listTipoHabitacions = ref([]);
const listEstadosHabitacions = ref([]);
const cargarTipoHabitacions = async () => {
    try {
        const response = await axios.get(route("tipo_habitacions.listado"));
        listTipoHabitacions.value = response.data.tipo_habitacions;
    } catch (error) {
        listTipoHabitacions.value = [];
    }
};
const cargarListEstadosHabitacions = () => {
    axios
        .get(route("estado_habitacions.getEstadosConteoHabitacion"))
        .then((response) => {
            listEstadosHabitacions.value = response.data;
        });
};

const oHabitacion = ref(null);
const listHabitacions = ref([]);
const loadingHabitacions = ref(false);
const paramHabitacions = ref({
    tipo_habitacion_id: [],
    capacidad: null,
    numero_habitacion: "",
    estados: [],
});
const cargarHabitacions = async () => {
    loadingHabitacions.value = true;
    try {
        const response = await axios.get(
            route("habitacions.listadoRecepcion"),
            {
                params: paramHabitacions.value,
            }
        );
        listHabitacions.value = response.data.habitacions;
    } catch (error) {
        listHabitacions.value = [];
    } finally {
        loadingHabitacions.value = false;
    }
};

const cargarHabitacionsTimeout = ref(null);
const precarCargarHabitacions = () => {
    if (cargarHabitacionsTimeout.value) {
        clearTimeout(cargarHabitacionsTimeout.value);
    }
    cargarHabitacionsTimeout.value = setTimeout(() => {
        cargarHabitacions();
    }, 300);
};

const muestraFormulario = (item) => {
    oHabitacion.value = item;
    muestra_formulario.value = true;
    accion_formulario.value = 0;
};

const cargarListas = () => {
    cargarTipoHabitacions();
    cargarHabitacions();
    cargarListEstadosHabitacions();
};
</script>
<template>
    <Head title="Recepción-CheckIn"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Recepción</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">Recepción</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>

        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3 col-lg-2">
                                <b>Filtros</b>
                                <div class="row mb-1">
                                    <div
                                        class="col-sm-6 col-md-12"
                                        v-for="item in listTipoHabitacions"
                                        :key="item.id"
                                    >
                                        <label
                                            class="btn btn-default w-100 rounded-0"
                                            :class="
                                                paramHabitacions.tipo_habitacion_id.includes(
                                                    item.id
                                                )
                                                    ? 'bg-success'
                                                    : 'bg-white'
                                            "
                                            :for="`th${item.id}`"
                                            >{{ item.nombre }}</label
                                        >
                                        <input
                                            class="d-none"
                                            type="checkbox"
                                            v-model="
                                                paramHabitacions.tipo_habitacion_id
                                            "
                                            :value="item.id"
                                            @change="cargarHabitacions"
                                            :id="`th${item.id}`"
                                        />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <small
                                            class="text-muted font-weight-bold"
                                            >Capacidad</small
                                        >
                                        <input
                                            type="number"
                                            class="form-control"
                                            v-model="paramHabitacions.capacidad"
                                            @keyup="precarCargarHabitacions"
                                        />
                                    </div>
                                </div>
                                <div class="row mb-1">
                                    <div class="col-12">
                                        <small
                                            class="text-muted font-weight-bold"
                                            >Código/Número Habitación</small
                                        >
                                        <input
                                            type="text"
                                            class="form-control"
                                            v-model="
                                                paramHabitacions.numero_habitacion
                                            "
                                            @keyup="precarCargarHabitacions"
                                        />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-9 col-lg-10">
                                <div class="row">
                                    <div class="col-12 mb-2">
                                        <label
                                            :class="[`${item.classText}`]"
                                            class="mx-2 cursor-pointer"
                                            v-for="item in listEstadosHabitacions"
                                            :for="`e${item.id}`"
                                        >
                                            <input
                                                type="checkbox"
                                                v-model="
                                                    paramHabitacions.estados
                                                "
                                                :value="item.id"
                                                :id="`e${item.id}`"
                                                @change="cargarHabitacions"
                                            />
                                            {{ item.label }}
                                            <span
                                                class="badge text-sm"
                                                :class="[`${item.classBg}`]"
                                                >{{ item.count }}</span
                                            >
                                        </label>
                                        <i
                                            class="fa fa-sync ml-2 text-primary cursor-pointer"
                                            @click.prevent="cargarListas"
                                        ></i>
                                    </div>
                                    <div class="col-12">
                                        <el-skeleton
                                            :loading="loadingHabitacions"
                                            animated
                                            class="w-100 row"
                                            :count="9"
                                        >
                                            <template #template>
                                                <div class="card col-md-4">
                                                    <div
                                                        class="card-body"
                                                        style="padding: 14px"
                                                    >
                                                        <el-skeleton-item
                                                            variant="h1"
                                                            class="w-100"
                                                        />
                                                        <el-skeleton-item
                                                            variant="text"
                                                            class="w-100"
                                                        />
                                                        <el-skeleton-item
                                                            variant="text"
                                                            class="w-100"
                                                        />
                                                    </div>
                                                </div>
                                            </template>
                                            <template #default>
                                                <div
                                                    class="row contenedorHabiaciones"
                                                    v-if="
                                                        listHabitacions.length >
                                                        0
                                                    "
                                                >
                                                    <div
                                                        class="col-md-3 col-lg-2 d-flex justify-content-center"
                                                        v-for="item in listHabitacions"
                                                    >
                                                        <div
                                                            href="#"
                                                            class="card habitacion cursor-pointer"
                                                        >
                                                            <div
                                                                class="card-header p-0"
                                                            >
                                                                <div
                                                                    class="contenedorBotones"
                                                                >
                                                                    <div
                                                                        class="boton"
                                                                    >
                                                                        <button
                                                                            class="btn btn-info w-100 rounded-0"
                                                                        >
                                                                            <i
                                                                                class="fa fa-info"
                                                                            ></i>
                                                                        </button>
                                                                    </div>
                                                                    <div
                                                                        class="boton"
                                                                        v-if="
                                                                            item.estado ==
                                                                            1
                                                                        "
                                                                    >
                                                                        <button
                                                                            class="btn btn-warning w-100 rounded-0"
                                                                        >
                                                                            <i
                                                                                class="fa fa-sync"
                                                                            ></i>
                                                                        </button>
                                                                    </div>
                                                                    <div
                                                                        class="boton"
                                                                        v-if="
                                                                            item.estado ==
                                                                            1
                                                                        "
                                                                    >
                                                                        <button
                                                                            class="btn btn-primary w-100 rounded-0"
                                                                        >
                                                                            <i
                                                                                class="fa fa-shopping-cart"
                                                                            ></i>
                                                                        </button>
                                                                    </div>
                                                                    <div
                                                                        class="boton"
                                                                        v-if="
                                                                            item.estado ==
                                                                            1
                                                                        "
                                                                    >
                                                                        <button
                                                                            class="btn btn-danger w-100 rounded-0"
                                                                        >
                                                                            <i
                                                                                class="fa fa-power-off"
                                                                            ></i>
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div
                                                                class="card-body text-center contenedorHabitacion"
                                                                @click="
                                                                    muestraFormulario(
                                                                        item
                                                                    )
                                                                "
                                                            >
                                                                <h5
                                                                    class="font-weight-bold"
                                                                >
                                                                    {{
                                                                        item.numero_habitacion
                                                                    }}
                                                                </h5>
                                                                <div
                                                                    class="row mb-1"
                                                                >
                                                                    <div
                                                                        class="col-12 text-muted"
                                                                    >
                                                                        {{
                                                                            item
                                                                                ?.tipo_habitacion
                                                                                ?.nombre
                                                                        }}
                                                                    </div>
                                                                </div>
                                                                <div
                                                                    class="row"
                                                                >
                                                                    <div
                                                                        class="col-4 offset-2 text-primary"
                                                                    >
                                                                        {{
                                                                            item.piso
                                                                        }}
                                                                        <br />
                                                                        <i
                                                                            class="fa fa-building"
                                                                        ></i>
                                                                    </div>
                                                                    <div
                                                                        class="col-4 text-success"
                                                                    >
                                                                        {{
                                                                            item.capacidad
                                                                        }}
                                                                        <br />
                                                                        <i
                                                                            class="fa fa-users"
                                                                        ></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div
                                                                class="card-footer"
                                                                @click="
                                                                    muestraFormulario(
                                                                        item
                                                                    )
                                                                "
                                                                :class="[
                                                                    {
                                                                        'bg-success':
                                                                            item.estado ==
                                                                            0,
                                                                        'bg-danger':
                                                                            item.estado ==
                                                                            1,
                                                                        'bg-primary':
                                                                            item.estado ==
                                                                            2,
                                                                        'bg-orange':
                                                                            item.estado ==
                                                                            3,
                                                                    },
                                                                ]"
                                                            >
                                                                <h5
                                                                    class="p-0 m-0 text-center font-weight-bold h6"
                                                                >
                                                                    {{
                                                                        item.estado_t
                                                                    }}
                                                                </h5>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row" v-else>
                                                    <div class="col-12">
                                                        <h4>
                                                            No se encontrarón
                                                            registros
                                                        </h4>
                                                    </div>
                                                </div>
                                            </template>
                                        </el-skeleton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <FormRegistro
            :o-habitacion="oHabitacion"
            :muestra_formulario="muestra_formulario"
            :accion_formulario="accion_formulario"
            @cerrar-formulario="
                oHabitacion = null;
                muestra_formulario = false;
            "
        ></FormRegistro>
    </Content>
</template>

<style></style>

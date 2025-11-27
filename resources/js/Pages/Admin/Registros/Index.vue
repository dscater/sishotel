<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount, onBeforeUnmount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useAxios } from "@/composables/axios/useAxios";
import { useMonedaOficial } from "@/composables/monedaOficial/useMonedaOficial";
const { monedaOficial } = useMonedaOficial();
const { props: props_page } = usePage();
const appStore = useAppStore();
const { axiosDelete } = useAxios();

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
    caclularFechaSalida();
    cargarListas();
    appStore.stopLoading();
});

const getFechaAtual = () => {
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, "0");
    const day = String(today.getDate()).padStart(2, "0");
    return `${year}-${month}-${day}`;
};

const getHoraActual = () => {
    const now = new Date();
    const hours = String(now.getHours()).padStart(2, "0");
    const minutes = String(now.getMinutes()).padStart(2, "0");
    return `${hours}:${minutes}`;
};

const caclularFechaSalida = () => {
    if (!form.fecha_entrada) {
        form.fecha_salida = null;
    } else {
        // Convertir la fecha a local para evitar bug de UTC
        const [y, m, d] = form.fecha_entrada.split("-").map(Number);
        const fecha = new Date(y, m - 1, d);

        fecha.setDate(fecha.getDate() + Number(form.dias_estadia));

        const year = fecha.getFullYear();
        const month = String(fecha.getMonth() + 1).padStart(2, "0");
        const day = String(fecha.getDate()).padStart(2, "0");

        form.fecha_salida = `${year}-${month}-${day}`;
    }
};

const form = useForm({
    habitacion_id: null,
    cliente_id: null,
    desayuno: 0,
    fecha_entrada: getFechaAtual(),
    hora_entrada: getHoraActual(),
    dias_estadia: 1,
    fecha_salida: null,
    hora_salida: "12:00",
    cd: 0,
    total: 0,
    adelanto: 0,
    saldo: 0,
    garantia: 0,
    moneda_id: null,
    tc: 0,
    cd_tc: null,
    total_tc: null,
    adelanto_tc: null,
    saldo_tc: null,
    garantia_tc: null,
    moneda_id_tc: null,
});

const listClientes = ref([]);
const loadingClientes = ref(false);
const remoteMethod = async (query) => {
    if (query !== "") {
        loadingClientes.value = true;
        try {
            const response = await axios.get(
                route("clientes.listado") +
                    `?search=${encodeURIComponent(query)}`
            );
            const data = response.data.clientes;
            // Suponiendo que data es un array de clientes [{id, nombre}]
            listClientes.value = data.map((persona) => ({
                value: persona.id,
                label: `${persona.full_name} - ${persona.ci}`,
            }));
        } catch (error) {
            listClientes.value = [];
        }
        loadingClientes.value = false;
    } else {
        listClientes.value = [];
    }
};

const listTipoHabitacions = ref([]);
const cargarTipoHabitacions = async () => {
    try {
        const response = await axios.get(route("tipo_habitacions.listado"));
        listTipoHabitacions.value = response.data.tipo_habitacions;
    } catch (error) {
        listTipoHabitacions.value = [];
    }
};

const listHabitacions = ref([]);
const loadingHabitacions = ref(false);
const paramHabitacions = ref({
    tipo_habitacion_id: [],
    capacidad: null,
    numero_habitacion: "",
});
const cargarHabitacions = async () => {
    loadingHabitacions.value = true;
    try {
        const response = await axios.get(route("habitacions.listado"), {
            params: paramHabitacions.value,
        });
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

const actualizaFechaIngreso = () => {
    form.fecha_entrada = getFechaAtual();
    form.hora_entrada = getHoraActual();
};

const cargarListas = () => {
    cargarTipoHabitacions();
    cargarHabitacions();
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
                                <div class="row mb-3">
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
                            </div>
                            <div class="col-md-9 col-lg-10">
                                <div class="row">
                                    <div class="col-12 mb-2">
                                        <!-- 
                                        TO DO: HACER ESTO MEDIANTE UN FOR DE LOS 
                                        ESTADOS DEL CONTROLADOR EstadoHabitacionController -->
                                        <span class="text-success">
                                            <b>Disponibles: </b>
                                            <b
                                                class="badge bg-primary text-md"
                                                >{{ listHabitacions.length }}</b
                                            >
                                        </span>
                                        <span class="mx-2 text-danger">
                                            <b>Ocupados: </b>
                                            <b
                                                class="badge bg-danger text-md"
                                                >{{ listHabitacions.length }}</b
                                            >
                                        </span>
                                        <span class="mx-2 text-primary">
                                            <b>En Mantenimiento: </b>
                                            <b class="badge bg-blue text-md">{{
                                                listHabitacions.length
                                            }}</b></span
                                        >
                                        <span class="mx-2 text-orange">
                                            <b>Limpieza: </b>
                                            <b
                                                class="badge bg-orange text-md"
                                                >{{ listHabitacions.length }}</b
                                            ></span
                                        >
                                        <i
                                            class="fa fa-sync ml-2 text-primary cursor-pointer"
                                            @click.prevent="cargarHabitacions"
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
                                                >
                                                    <div
                                                        class="col-md-4 col-lg-4"
                                                        v-for="item in listHabitacions"
                                                    >
                                                        <div class="card">
                                                            <div
                                                                class="card-body text-center contenedorHabitacion"
                                                            >
                                                                <h5>
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
                                                                class="card-footer p-0"
                                                            >
                                                                <div
                                                                    class="row justify-content-end"
                                                                >
                                                                    <div
                                                                        class="col-3"
                                                                    >
                                                                        <button
                                                                            class="btn btn-sm bg-secundario w-100"
                                                                        >
                                                                            <i
                                                                                class="fa fa-info"
                                                                            ></i>
                                                                        </button>
                                                                    </div>
                                                                    <div
                                                                        class="col-3"
                                                                    >
                                                                        <button
                                                                            class="btn btn-sm btn-success w-100"
                                                                        >
                                                                            <i
                                                                                class="fa fa-check"
                                                                            ></i>
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
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
    </Content>
</template>

<style></style>

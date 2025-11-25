<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount, onBeforeUnmount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useAxios } from "@/composables/axios/useAxios";
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
    cliente_id: null,
    fecha_entrada: getFechaAtual(),
    hora_entrada: getHoraActual(),
    dias_estadia: 1,
    fecha_salida: null,
    hora_salida: "12:00",
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
});
const cargarHabitacions = async () => {
    loadingHabitacions.value = true;
    try {
        const response = await axios.get(route("habitacions.listadoCheckIn"), {
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
                    <h1 class="m-0">Check-In</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">Check-In</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>

        <div class="row">
            <div class="col-md-12">
                <!-- <div class="row">
                    <div class="col-md-4">
                        <button
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'usuarios.create'
                                )
                            "
                            type="button"
                            class="btn btn-primary"
                            @click="agregarRegistro"
                        >
                            <i class="fa fa-plus"></i> Agregar Cliente
                        </button>
                    </div>
                </div> -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <form>
                                    <div class="row">
                                        <div class="col-12 mb-1">
                                            <label>Buscar cliente</label>
                                            <div class="input-group mb-3">
                                                <el-select-v2
                                                    v-model="form.cliente_id"
                                                    style="
                                                        width: calc(
                                                            100% - 40px
                                                        );
                                                    "
                                                    filterable
                                                    remote
                                                    :remote-method="
                                                        remoteMethod
                                                    "
                                                    clearable
                                                    :options="listClientes"
                                                    :loading="loadingClientes"
                                                    placeholder="Nombre o C.I./Pasaporte..."
                                                    size="large"
                                                    no-data-text="Sin resultados"
                                                    loading-text="Buscando..."
                                                    :class="{
                                                        'is-invalid':
                                                            form.errors
                                                                ?.cliente_id,
                                                    }"
                                                    class="rounded-0"
                                                />
                                                <div class="input-group-append">
                                                    <button
                                                        class="btn btn-primary"
                                                    >
                                                        <i
                                                            class="fa fa-plus"
                                                        ></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <ul
                                                v-if="form.errors?.cliente_id"
                                                class="parsley-errors-list filled"
                                            >
                                                <li class="parsley-required">
                                                    {{
                                                        form.errors?.cliente_id
                                                    }}
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <h4 class="h5 text-center">
                                                Ingreso
                                            </h4>
                                        </div>
                                        <div class="col-md-4 mb-1">
                                            <label> Fecha de Ingreso </label>
                                            <input
                                                type="date"
                                                class="form-control"
                                                :class="{
                                                    'parsley-error':
                                                        form.errors
                                                            ?.fecha_entrada,
                                                }"
                                                v-model="form.fecha_entrada"
                                                @keyup="caclularFechaSalida"
                                            />
                                            <ul
                                                v-if="
                                                    form.errors?.fecha_entrada
                                                "
                                                class="parsley-errors-list filled"
                                            >
                                                <li class="parsley-required">
                                                    {{
                                                        form.errors
                                                            ?.fecha_entrada
                                                    }}
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-md-4 mb-1">
                                            <label> Hora de Ingreso </label>
                                            <input
                                                type="time"
                                                class="form-control"
                                                :class="{
                                                    'parsley-error':
                                                        form.errors
                                                            ?.hora_entrada,
                                                }"
                                                v-model="form.hora_entrada"
                                            />
                                            <ul
                                                v-if="form.errors?.hora_entrada"
                                                class="parsley-errors-list filled"
                                            >
                                                <li class="parsley-required">
                                                    {{
                                                        form.errors
                                                            ?.hora_entrada
                                                    }}
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-md-4 mb-1">
                                            <label>Días de estadía</label>
                                            <el-input-number
                                                class="w-100"
                                                v-model="form.dias_estadia"
                                                :min="1"
                                                @change="caclularFechaSalida"
                                            >
                                                <template #suffix>
                                                    <span>Día(s)</span>
                                                </template></el-input-number
                                            >
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-12">
                                            <hr class="mt-2 mb-2" />
                                        </div>
                                        <div class="col-12">
                                            <h4 class="h5 text-center mb-0">
                                                Salida
                                            </h4>
                                            <small
                                                class="text-center w-100 d-block"
                                                >(Automatico)</small
                                            >
                                        </div>
                                        <div class="col-md-4 mb-1 offset-md-2">
                                            <label> Fecha de Salida </label>
                                            <input
                                                type="date"
                                                class="form-control"
                                                :class="{
                                                    'parsley-error':
                                                        form.errors
                                                            ?.fecha_salida,
                                                }"
                                                v-model="form.fecha_salida"
                                                readonly
                                            />
                                            <ul
                                                v-if="form.errors?.fecha_salida"
                                                class="parsley-errors-list filled"
                                            >
                                                <li class="parsley-required">
                                                    {{
                                                        form.errors
                                                            ?.fecha_salida
                                                    }}
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-md-4 mb-1">
                                            <label> Hora de Salida </label>
                                            <input
                                                type="time"
                                                class="form-control"
                                                :class="{
                                                    'parsley-error':
                                                        form.errors
                                                            ?.hora_salida,
                                                }"
                                                v-model="form.hora_salida"
                                                readonly
                                            />
                                            <ul
                                                v-if="form.errors?.hora_salida"
                                                class="parsley-errors-list filled"
                                            >
                                                <li class="parsley-required">
                                                    {{
                                                        form.errors?.hora_salida
                                                    }}
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-12">
                                        <h4 class="h5 text-center">
                                            Asignar Habitación
                                        </h4>
                                    </div>
                                    <div class="col-12">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <b>Filtros</b>
                                                <div class="row mb-1">
                                                    <div class="col-12">
                                                        <input
                                                            type="number"
                                                            class="form-control"
                                                            placeholder="Capacidad"
                                                            v-model="
                                                                paramHabitacions.capacidad
                                                            "
                                                            @keyup="
                                                                precarCargarHabitacions
                                                            "
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
                                                            >{{
                                                                item.nombre
                                                            }}</label
                                                        >
                                                        <input
                                                            class="d-none"
                                                            type="checkbox"
                                                            v-model="
                                                                paramHabitacions.tipo_habitacion_id
                                                            "
                                                            :value="item.id"
                                                            @change="
                                                                cargarHabitacions
                                                            "
                                                            :id="`th${item.id}`"
                                                        />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-9">
                                                <div class="row">
                                                    <div class="col-12">
                                                        Habitaciones
                                                        Disponibles:
                                                        <b class="text-md">{{
                                                            listHabitacions.length
                                                        }}</b>

                                                        <i
                                                            class="fa fa-sync ml-2 text-primary cursor-pointer"
                                                            @click.prevent="
                                                                cargarHabitacions
                                                            "
                                                        ></i>
                                                    </div>
                                                    <el-skeleton
                                                        :loading="
                                                            loadingHabitacions
                                                        "
                                                        animated
                                                        class="w-100 row"
                                                        :count="9"
                                                    >
                                                        <template #template>
                                                            <div
                                                                class="col-md-4"
                                                            >
                                                                <div
                                                                    style="
                                                                        padding: 14px;
                                                                    "
                                                                >
                                                                    <el-skeleton-item
                                                                        variant="h2"
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
                                                                class="col-md-4 col-lg-4"
                                                                v-for="item in listHabitacions"
                                                            >
                                                                <div
                                                                    class="card"
                                                                >
                                                                    <div
                                                                        class="card-body text-center"
                                                                    >
                                                                        <h5>
                                                                            {{
                                                                                item.numero_habitacion
                                                                            }}
                                                                        </h5>
                                                                        <div
                                                                            class="row"
                                                                        >
                                                                            <div
                                                                                class="col-12"
                                                                            >
                                                                                <b
                                                                                    >Piso:</b
                                                                                >
                                                                                {{
                                                                                    item.piso
                                                                                }}
                                                                            </div>
                                                                            <div
                                                                                class="col-12"
                                                                            >
                                                                                {{
                                                                                    item
                                                                                        ?.tipo_habitacion
                                                                                        ?.nombre
                                                                                }}
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
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-12">
                                        <h4 class="h5 text-center">
                                            Información del Registro
                                        </h4>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="row">
                                            <div class="col-6 text-right">
                                                <b>Cliente:</b>
                                            </div>
                                            <div class="col-6">Juan Perez</div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="row">
                                            <div class="col-6 text-right">
                                                <b>Nro. C.I. / Pasaporte:</b>
                                            </div>
                                            <div class="col-6">11111111</div>
                                        </div>
                                    </div>
                                    <!-- 
                                    to do: VER COMO SE MANEJARA CON DIFERENTES MONEDAS -->
                                    <div class="col-12 mb-2">
                                        <div class="row">
                                            <div class="col-6 text-right">
                                                <b>Costo/Día Moneda:</b>
                                            </div>
                                            <div class="col-6">
                                                <input
                                                    type="number"
                                                    class="form-control"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 mb-2">
                                        <div class="row">
                                            <div class="col-6 text-right">
                                                <b>Total:</b>
                                            </div>
                                            <div class="col-6">
                                                <input
                                                    type="number"
                                                    class="form-control"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 mb-2">
                                        <div class="row">
                                            <div class="col-6 text-right">
                                                <b>Cancelado:</b>
                                            </div>
                                            <div class="col-6">
                                                <input
                                                    type="number"
                                                    class="form-control"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 mb-2">
                                        <div class="row">
                                            <div class="col-6 text-right">
                                                <b>Moneda:</b>
                                            </div>
                                            <div class="col-6">
                                                <select class="form-control">
                                                    <option value="">
                                                        Moneda por Defecto
                                                    </option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- SOLO MOSTRAR SI LA MONEDA ES DIFERENTE A LA POR DEFECTO -->
                                    <div class="col-12 mb-2">
                                        <div class="row">
                                            <div class="col-6 text-right">
                                                <b>Tipo de Cambio:</b>
                                            </div>
                                            <div class="col-6">
                                                <select class="form-control">
                                                    <option value="">
                                                        Moneda por Defecto
                                                    </option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 mb-2">
                                        <div class="row">
                                            <div class="col-6 text-right">
                                                <b>Saldo:</b>
                                            </div>
                                            <div class="col-6">
                                                <input
                                                    type="number"
                                                    class="form-control"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 mb-2">
                                        <div class="row">
                                            <div class="col-6 offset-6">
                                                <button
                                                    class="btn btn-primary w-100"
                                                >
                                                    Finalizar Registro
                                                </button>
                                            </div>
                                        </div>
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

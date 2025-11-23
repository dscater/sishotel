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
                <div class="row mt-2">
                    <div class="col-12">
                        <p class="text-muted text-xs mb-0">
                            Todos los campos con
                            <span class="text-danger">(*)</span> son
                            obligatorios.
                        </p>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <form>
                                    <div class="row">
                                        <div class="col-12 mb-1">
                                            <label class="required"
                                                >Buscar cliente</label
                                            >
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
                                            <label class="required">
                                                Fecha de Ingreso
                                            </label>
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
                                            <label class="required">
                                                Hora de Ingreso
                                            </label>
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
                                            <label class="required"
                                                >Días de estadía</label
                                            >
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
                                            <label class="required">
                                                Fecha de Salida
                                            </label>
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
                                            <label class="required">
                                                Hora de Salida
                                            </label>
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
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-12">
                                        <h4 class="h5 text-center">
                                            Asignar Habitación
                                        </h4>
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

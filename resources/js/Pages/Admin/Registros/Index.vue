<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount, onBeforeUnmount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import Habitacion from "./Habitacion.vue";
import FormRegistro from "@/Pages/Admin/Registros/FormRegistro.vue";
import Transferencia from "@/Pages/Admin/Registros/Transferencia.vue";
import Servicios from "@/Pages/Admin/Registros/Servicios.vue";
import Pagos from "./Pagos.vue";
import Configuracion from "./Configuracion.vue";
import Informacion from "./Informacion.vue";
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

const oHabitacion = ref(null);
const oRegistro = ref(null);

const muestra_formulario_registro = ref(false);
const accion_formulario_registro = ref(0);
const abrirFormRegistro = (habitacion, registro) => {
    oHabitacion.value = habitacion;
    muestra_formulario_registro.value = true;
    accion_formulario_registro.value = 0;
    oRegistro.value = null;
    if (registro) {
        oRegistro.value = registro;
        accion_formulario_registro.value = 1;
    }
};

const muestra_formulario_transferencia = ref(false);
const accion_formulario_transferencia = ref(0);
const abrirFormTransferencia = (habitacion, registro) => {
    oHabitacion.value = habitacion;
    muestra_formulario_transferencia.value = true;
    accion_formulario_transferencia.value = 0;
    if (registro) {
        oRegistro.value = registro ?? null;
        accion_formulario_transferencia.value = 1;
    }
};

const muestra_formulario_servicios = ref(false);
const accion_formulario_servicios = ref(0);
const abrirFormServicios = (habitacion, registro) => {
    oHabitacion.value = habitacion;
    muestra_formulario_servicios.value = true;
    accion_formulario_servicios.value = 0;
    if (registro) {
        oRegistro.value = registro ?? null;
        accion_formulario_servicios.value = 1;
    }
};

const muestra_formulario_pagos = ref(false);
const accion_formulario_pagos = ref(0);
const abrirFormPagos = (habitacion, registro) => {
    oHabitacion.value = habitacion;
    muestra_formulario_pagos.value = true;
    accion_formulario_pagos.value = 0;
    if (registro) {
        oRegistro.value = registro ?? null;
        accion_formulario_pagos.value = 1;
    }
};

const muestra_formulario_informacion = ref(false);
const accion_formulario_informacion = ref(0);
const abrirInformacion = (habitacion, registro) => {
    oHabitacion.value = habitacion;
    muestra_formulario_informacion.value = true;
    accion_formulario_informacion.value = 0;
    if (registro) {
        oRegistro.value = registro ?? null;
        accion_formulario_informacion.value = 1;
    }
};

const muestra_formulario_configuracion = ref(false);
const accion_formulario_configuracion = ref(0);
const abrirConfiguracion = (habitacion, registro) => {
    oHabitacion.value = habitacion;
    muestra_formulario_configuracion.value = true;
    accion_formulario_configuracion.value = 0;
    if (registro) {
        oRegistro.value = registro ?? null;
        accion_formulario_configuracion.value = 1;
    }
};

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

const listHabitacions = ref([]);
const listHabitacionsFiltro = ref([]);
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

const cargarHabitacionsFiltro = async () => {
    loadingHabitacions.value = true;
    try {
        const response = await axios.get(route("habitacions.listado"));
        listHabitacionsFiltro.value = response.data.habitacions;
    } catch (error) {
        listHabitacionsFiltro.value = [];
    } finally {
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

const oCaja = ref(null);
const verificaCaja = () => {
    loadingHabitacions.value = true;
    axios.get(route("cajas.verificaCajaAbierta")).then((response) => {
        oCaja.value = response.data.caja;
        loadingHabitacions.value = false;
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

const cargarListas = () => {
    cargarTipoHabitacions();
    cargarHabitacions();
    cargarHabitacionsFiltro();
    cargarListEstadosHabitacions();
    verificaCaja();
};
</script>
<template>
    <Head title="Recepción"></Head>
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
                                        <el-select
                                            class="w-100"
                                            v-model="
                                                paramHabitacions.numero_habitacion
                                            "
                                            placeholder=""
                                            filterable
                                            clearable
                                            @change="precarCargarHabitacions"
                                        >
                                            <el-option
                                                v-for="item in listHabitacionsFiltro"
                                                :key="item.id"
                                                :value="item.numero_habitacion"
                                                :label="item.numero_habitacion"
                                            ></el-option>
                                        </el-select>
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
                                            :count="12"
                                        >
                                            <template #template>
                                                <div
                                                    class="card col-lg-2 colm-d3"
                                                >
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
                                                            style="height: 90px"
                                                            class="w-100"
                                                        />
                                                        <el-skeleton-item
                                                            variant="h1"
                                                            class="w-100"
                                                        />
                                                    </div>
                                                </div>
                                            </template>
                                            <template #default>
                                                <div
                                                    class="row contenedorHabitaciones"
                                                    v-if="
                                                        listHabitacions.length >
                                                        0
                                                    "
                                                >
                                                    <div
                                                        class="col-md-3 col-lg-2 d-flex justify-content-center"
                                                        v-for="item in listHabitacions"
                                                    >
                                                        <Habitacion
                                                            @form-registro="
                                                                abrirFormRegistro
                                                            "
                                                            @form-transferencia="
                                                                abrirFormTransferencia
                                                            "
                                                            @form-servicios="
                                                                abrirFormServicios
                                                            "
                                                            @form-pagos="
                                                                abrirFormPagos
                                                            "
                                                            @form-informacion="
                                                                abrirInformacion
                                                            "
                                                            @form-configuracion="
                                                                abrirConfiguracion
                                                            "
                                                            :habitacion="item"
                                                            @actualizado="
                                                                cargarListas
                                                            "
                                                        ></Habitacion>
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
            :registro="oRegistro"
            :muestra_formulario="muestra_formulario_registro"
            :accion_formulario="accion_formulario_registro"
            @envio-formulario="
                cargarHabitacions();
                muestra_formulario_registro = false;
                accion_formulario_registro = 0;
                oHabitacion = null;
            "
            @cerrar-formulario="
                muestra_formulario_registro = false;
                oRegistro = null;
                oHabitacion = null;
            "
        ></FormRegistro>

        <Transferencia
            :o-habitacion="oHabitacion"
            :muestra_formulario="muestra_formulario_transferencia"
            :accion_formulario="accion_formulario_transferencia"
            :registro="oRegistro"
            @envio-formulario="
                cargarHabitacions();
                muestra_formulario_transferencia = false;
                accion_formulario_transferencia = 0;
                oHabitacion = null;
            "
            @cerrar-formulario="muestra_formulario_transferencia = false"
        ></Transferencia>

        <Servicios
            :o-habitacion="oHabitacion"
            :muestra_formulario="muestra_formulario_servicios"
            :accion_formulario="accion_formulario_servicios"
            :registro="oRegistro"
            @envio-formulario="
                cargarHabitacions();
                muestra_formulario_servicios = false;
                accion_formulario_servicios = 0;
                oHabitacion = null;
            "
            @cerrar-formulario="muestra_formulario_servicios = false"
        ></Servicios>

        <Pagos
            :o-habitacion="oHabitacion"
            :muestra_formulario="muestra_formulario_pagos"
            :accion_formulario="accion_formulario_pagos"
            :registro="oRegistro"
            @envio-formulario="
                cargarHabitacions();
                muestra_formulario_pagos = false;
                accion_formulario_pagos = 0;
                oHabitacion = null;
            "
            @cerrar-formulario="muestra_formulario_pagos = false"
        >
        </Pagos>

        <Configuracion
            :o-habitacion="oHabitacion"
            :muestra_formulario="muestra_formulario_configuracion"
            :accion_formulario="accion_formulario_configuracion"
            :registro="oRegistro"
            @envio-formulario="
                cargarHabitacions();
                muestra_formulario_configuracion = false;
                accion_formulario_configuracion = 0;
                oHabitacion = null;
            "
            @cerrar-formulario="muestra_formulario_configuracion = false"
        >
        </Configuracion>

        <Informacion
            :o-habitacion="oHabitacion"
            :muestra_formulario="muestra_formulario_informacion"
            :accion_formulario="accion_formulario_informacion"
            :registro="oRegistro"
            @envio-formulario="
                cargarHabitacions();
                muestra_formulario_informacion = false;
                accion_formulario_informacion = 0;
                oHabitacion = null;
            "
            @cerrar-formulario="muestra_formulario_informacion = false"
        >
        </Informacion>
    </Content>
</template>

<style></style>

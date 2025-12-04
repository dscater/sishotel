<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, onMounted, nextTick } from "vue";
import { useMonedaOficial } from "@/composables/monedaOficial/useMonedaOficial";
import Formulario from "../Clientes/Formulario.vue";
const { monedaOficial } = useMonedaOficial();

const props = defineProps({
    oHabitacion: {
        type: Object,
        default: null,
    },
    registro: {
        type: Object,
        default: null,
    },
    muestra_formulario: {
        type: Boolean,
        default: false,
    },
    accion_formulario: {
        type: Number,
        default: 0,
    },
});

const accion_formulario_cliente = ref(0);
const muestra_formulario = ref(false);

const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const habitacion = ref(props.oHabitacion);
const oRegistro = ref(null);
const enviando = ref(false);

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

const form = useForm({
    id: 0,
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
    cd_tc: null,
    total_tc: null,
    adelanto_tc: null,
    saldo_tc: null,
    garantia_tc: null,
    moneda_id_tc: null,
    tipo: "NORMAL",
    _method: "POST",
});

watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            cargarListas();
            caclularFechaSalida();
            form.habitacion_id = habitacion.value.id;
            form.moneda_id_tc = monedaOficial?.value.id;
            form.cd = habitacion.value.precio;
            if (form.id == 0) {
                form.fecha_entrada = getFechaAtual();
                form.hora_entrada = getHoraActual();
            } else {
                asignarDatosForm();
            }
            actualizaMontos();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
        } else {
            document
                .getElementsByTagName("body")[0]
                .classList.remove("modal-open");
        }
    }
);
watch(
    () => props.oHabitacion,
    (newValue) => {
        habitacion.value = newValue;
        form.habitacion_id = habitacion.value?.id;
    }
);
watch(
    () => props.registro,
    (newValue) => {
        oRegistro.value = newValue;
        asignarDatosForm();
    }
);

const asignarDatosForm = () => {
    if (oRegistro.value) {
        form.id = oRegistro.value.id;
        form.habitacion_id = oRegistro.value.habitacion_id;
        form.cliente_id = oRegistro.value.cliente_id;
        form.desayuno = oRegistro.value.desayuno;
        form.fecha_entrada = oRegistro.value.fecha_entrada;
        form.hora_entrada = oRegistro.value.hora_entrada;
        form.dias_estadia = oRegistro.value.dias_estadia;
        form.fecha_salida = oRegistro.value.fecha_salida;
        form.hora_salida = oRegistro.value.hora_salida;
        form.cd = oRegistro.value.cd;
        form.total = oRegistro.value.total;
        form.adelanto = oRegistro.value.adelanto;
        form.saldo = oRegistro.value.saldo;
        form.garantia = oRegistro.value.garantia;
        form.cd_tc = oRegistro.value.cd_tc;
        form.total_tc = oRegistro.value.total_tc;
        form.adelanto_tc = oRegistro.value.adelanto_tc;
        form.saldo_tc = oRegistro.value.saldo_tc;
        form.garantia_tc = oRegistro.value.garantia_tc;
        form.moneda_id_tc = oRegistro.value.moneda_id_tc;
        form.tipo = oRegistro.value.tipo;
        form["_method"] = "PUT";
        agregarClienteASelect(oRegistro.value.cliente);
    }
};

const limpiarDatosForm = () => {
    form.id = 0;
    form.habitacion_id = null;
    form.cliente_id = null;
    form.desayuno = 0;
    form.fecha_entrada = getFechaAtual();
    form.hora_entrada = getHoraActual();
    form.dias_estadia = 1;
    form.fecha_salida = null;
    form.hora_salida = "12:00";
    form.cd = 0;
    form.total = 0;
    form.adelanto = 0;
    form.saldo = 0;
    form.garantia = 0;
    form.cd_tc = null;
    form.total_tc = null;
    form.adelanto_tc = null;
    form.saldo_tc = null;
    form.garantia_tc = null;
    form.moneda_id_tc = null;
    form.tipo = "NORMAL";
    form["_method"] = "PUT";
};

watch(
    () => props.accion_formulario,
    (newValue) => {
        accion_form.value = newValue;
    }
);

watch(muestra_form, (newVal) => {
    if (!newVal) {
        limpiarDatosForm();
        emits("cerrar-formulario");
    }
});

const { flash } = usePage().props;
const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-plus"></i> Nuevo Registro`
        : `<i class="fa fa-edit"></i> Editar Registro`;
});

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    if (accion_form.value == 0) {
        return `<i class="fa fa-save"></i> Guardar`;
    }
    return `<i class="fa fa-edit"></i> Actualizar`;
});

const enviarFormulario = () => {
    enviando.value = true;
    let url =
        form["_method"] == "POST"
            ? route("registros.store")
            : route("registros.update", form.id);

    form.post(url, {
        preserveScroll: true,
        forceFormData: true,
        onSuccess: (response) => {
            console.log("correcto");
            const success =
                response.props.flash.success ?? "Proceso realizado con éxito";
            Swal.fire({
                icon: "success",
                title: "Correcto",
                html: `<strong>${success}</strong>`,
                confirmButtonText: `Aceptar`,
                customClass: {
                    confirmButton: "btn-success",
                },
            });
            emits("envio-formulario");
        },
        onError: (err, code) => {
            console.log(code ?? "");
            console.log(form.errors);
            if (form.errors) {
                const error =
                    "Existen errores en el formulario, por favor verifique";

                let listaErrores = "<ul style='text-align:left;'>";

                Object.values(form.errors).forEach((err) => {
                    listaErrores += `<li>${err}</li>`;
                });

                listaErrores += "</ul>";

                Swal.fire({
                    icon: "info",
                    title: "Error",
                    html: `<strong>${error}</strong><br/>${listaErrores}`,
                    confirmButtonText: `Aceptar`,
                    customClass: {
                        confirmButton: "btn-primary",
                    },
                });
            } else {
                const error =
                    "Ocurrió un error inesperado contactese con el Administrador";
                Swal.fire({
                    icon: "info",
                    title: "Error",
                    html: `<strong>${error}</strong>`,
                    confirmButtonText: `Aceptar`,
                    customClass: {
                        confirmButton: "btn-error",
                    },
                });
            }
            console.log("error: " + err.error);
        },
        onFinish: () => {
            enviando.value = false;
        },
    });
};

const emits = defineEmits(["cerrar-formulario", "envio-formulario"]);

const cerrarFormulario = () => {
    muestra_form.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

const listClientes = ref([]);
const loadingClientes = ref(false);
const remoteMethod = async (query) => {
    if (query !== "") {
        loadingClientes.value = true;
        try {
            const response = await axios.get(
                route("clientes.listadoSelectElementUi") +
                    `?search=${encodeURIComponent(query)}`
            );
            const data = response.data.clientes;
            // Suponiendo que data es un array de clientes [{id, nombre}]
            listClientes.value = data.map((cliente) => ({
                value: cliente.id,
                label: `${cliente.full_name} - ${cliente.ci}`,
            }));
        } catch (error) {
            listClientes.value = [];
        }
        loadingClientes.value = false;
    } else {
        listClientes.value = [];
    }
};

const actualizaFechaIngreso = () => {
    form.fecha_entrada = getFechaAtual();
    form.hora_entrada = getHoraActual();
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

const actualizaPrecioTipo = () => {
    form.cd = habitacion.value.precio;
    if (form.tipo == "TEMPORAL") {
        form.cd = habitacion.value.precio_temp;
    }
    // console.log(form.cd);

    // USAR UNA FUNCION PARA TIPO DE CAMBIO
    // DETECTANDO SI HAY O NO UN TIPO DE CAMBIO

    actualizaMontos();
};

const actualizaMontos = () => {
    form.moneda_id_tc = monedaOficial?.value.id;
    form.total = form.dias_estadia * form.cd;
    form.saldo = form.total - form.adelanto;
    // USAR UNA FUNCION PARA TIPO DE CAMBIO
    // DETECTANDO SI HAY O NO UN TIPO DE CAMBIO
};

const listMonedas = ref([]);
const cargarMonedas = () => {
    axios.get(route("monedas.listado")).then((response) => {
        listMonedas.value = response.data.monedas;
    });
};

const cargarListas = () => {
    cargarMonedas();
};

const agregarCliente = () => {
    muestra_formulario.value = true;
    accion_formulario_cliente.value = 0;
};

const updateClientes = (item) => {
    muestra_formulario.value = false;
    accion_formulario_cliente.value = 0;
    agregarClienteASelect(item);
};

const agregarClienteASelect = async (cliente) => {
    if (!cliente) return;

    const nuevo = {
        value: cliente.id,
        label: `${cliente.nombre} ${cliente.paterno} ${cliente.materno} - ${cliente.ci}`,
    };

    // Si no existe, agregarlo
    const existe = listClientes.value.some((c) => c.value === nuevo.value);
    if (!existe) {
        listClientes.value.push(nuevo);
    }

    form.cliente_id = null;
    nextTick(() => {
        setTimeout(() => {
            form.cliente_id = nuevo.value;
        }, 200);
    });
};

const cierreFormCliente = () => {
    muestra_formulario.value = false;
};

const modificarCD = () => {
    actualizaMontos();
};

onMounted(() => {});
</script>

<template>
    <div>
        <MiModal
            :open_modal="muestra_form"
            @close="cerrarFormulario"
            :size="'modal-xl w-100 modal_registro'"
            :header-class="form.id == 0 ? 'bg-navy' : 'bg-danger'"
            :footer-class="'justify-content-end'"
        >
            <template #header>
                <h4 class="modal-title" v-html="tituloDialog"></h4>
                <button
                    type="button"
                    class="close"
                    @click.prevent="cerrarFormulario()"
                >
                    <span aria-hidden="true">×</span>
                </button>
            </template>

            <template #body>
                <form @submit.prevent="enviarFormulario()">
                    <div class="row">
                        <div class="col-md-7 mb-2">
                            <label>Cliente</label>
                            <div class="input-group">
                                <el-select-v2
                                    v-model="form.cliente_id"
                                    style="width: calc(100% - 40px)"
                                    filterable
                                    remote
                                    :remote-method="remoteMethod"
                                    clearable
                                    :options="listClientes"
                                    :loading="loadingClientes"
                                    placeholder="Nombre o C.I./Pasaporte..."
                                    size="large"
                                    no-data-text="Sin resultados"
                                    loading-text="Buscando..."
                                    :class="{
                                        'is-invalid': form.errors?.cliente_id,
                                    }"
                                    class="rounded-0"
                                />
                                <div class="input-group-append">
                                    <button
                                        class="btn btn-primary"
                                        @click.prevent="agregarCliente"
                                    >
                                        <i class="fa fa-plus"></i>
                                    </button>
                                </div>
                            </div>
                            <ul
                                v-if="form.errors?.cliente_id"
                                class="parsley-errors-list filled"
                            >
                                <li class="parsley-required">
                                    {{ form.errors?.cliente_id }}
                                </li>
                            </ul>
                        </div>
                        <div class="col-md-5 mb-2">
                            <label>Tipo de Registro</label>
                            <select
                                class="form-control"
                                v-model="form.tipo"
                                @change="actualizaPrecioTipo()"
                            >
                                <option value="NORMAL">NORMAL</option>
                                <option value="TEMPORAL">TEMPORAL</option>
                                <option value="RESERVA">RESERVA</option>
                            </select>
                        </div>

                        <div class="col-md-7">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-12">
                                            <h4 class="h5 text-center mb-0">
                                                Ingreso
                                                <small
                                                    v-if="form.id == 0"
                                                    class="text-primary cursor-pointer"
                                                >
                                                    <i
                                                        class="fa fa-sync text-sm"
                                                        @click="
                                                            actualizaFechaIngreso
                                                        "
                                                    ></i>
                                                </small>
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
                                                @change="
                                                    caclularFechaSalida();
                                                    actualizaMontos();
                                                "
                                            >
                                                <template #suffix>
                                                    <span>Día(s)</span>
                                                </template></el-input-number
                                            >
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-12">
                                            <h5 class="h5 text-center mb-0">
                                                Salida
                                                <small class="text-xs"
                                                    >(Automatico)</small
                                                >
                                            </h5>
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
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-12 text-center">
                                            <label class="h5"
                                                >Habitación asignada</label
                                            >
                                            <template v-if="habitacion">
                                                <div
                                                    class="d-block badge bg1 text-md"
                                                >
                                                    <div class="row">
                                                        <div
                                                            class="col-3 text-wrap"
                                                        >
                                                            {{
                                                                habitacion.numero_habitacion
                                                            }}
                                                            <br />
                                                            <i
                                                                class="fa fa-info mt-1 text-icon"
                                                            ></i>
                                                        </div>
                                                        <div
                                                            class="col-3 text-wrap"
                                                        >
                                                            {{
                                                                habitacion
                                                                    .tipo_habitacion
                                                                    ?.nombre
                                                            }}
                                                            <br />
                                                            <i
                                                                class="fa fa-users mt-1 text-icon"
                                                            ></i>
                                                        </div>
                                                        <div
                                                            class="col-3 text-wrap"
                                                        >
                                                            {{
                                                                habitacion.capacidad
                                                            }}
                                                            <br />
                                                            <i
                                                                class="fa fa-users mt-1 text-icon"
                                                            ></i>
                                                        </div>
                                                        <div
                                                            class="col-3 text-wrap"
                                                        >
                                                            {{
                                                                habitacion.piso
                                                            }}
                                                            <br />
                                                            <i
                                                                class="fa fa-building mt-1 text-icon"
                                                            ></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </template>
                                            <template v-else>
                                                <span
                                                    class="d-block badge badge-danger text-md"
                                                    >SIN ASIGNAR</span
                                                >
                                            </template>
                                        </div>
                                        <div class="col-12 text-center">
                                            <label>Con Desayuno</label>
                                            <el-radio-group
                                                v-model="form.desayuno"
                                                fill="#5cc72f"
                                                text-color="#fff"
                                                class="d-block"
                                            >
                                                <el-radio-button :value="0"
                                                    ><span class=""
                                                        >No</span
                                                    ></el-radio-button
                                                >
                                                <el-radio-button :value="1"
                                                    ><span class=""
                                                        >Si</span
                                                    ></el-radio-button
                                                >
                                            </el-radio-group>
                                        </div>
                                        <div class="col-12 text-center">
                                            <label>Moneda</label>
                                            <select
                                                class="form-control"
                                                v-model="form.moneda_id_tc"
                                            >
                                                <option
                                                    v-for="item in listMonedas"
                                                    :value="item.id"
                                                >
                                                    {{ item.nombre }} -
                                                    {{ item.simbolo }}
                                                </option>
                                            </select>
                                        </div>
                                        <div
                                            class="col-12 text-center"
                                            v-if="
                                                form.moneda_id_tc !=
                                                monedaOficial?.id
                                            "
                                        >
                                            <label>Tipo de Cambio:</label>
                                            <div class="input-group">
                                                <select class="form-control">
                                                    <option value="">
                                                        Moneda por Defecto
                                                    </option>
                                                </select>
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
                                        </div>
                                        <div class="col-12 text-center">
                                            <label
                                                >Costo/Día
                                                {{
                                                    monedaOficial?.simbolo
                                                }}</label
                                            >
                                            <input
                                                type="number"
                                                class="form-control text-center"
                                                v-model="form.cd"
                                                @change="modificarCD"
                                            />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-7">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-12">
                                            <h4 class="text-center h5">Pago</h4>
                                        </div>
                                    </div>
                                    <!-- SIN TIPO DE CAMBIO -->
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label
                                                >Total
                                                {{
                                                    monedaOficial?.simbolo
                                                }}:</label
                                            >
                                            <input
                                                type="number"
                                                class="form-control"
                                                readonly
                                                v-model="form.total"
                                            />
                                        </div>
                                        <div class="col-md-6">
                                            <label
                                                >Cancelado
                                                {{
                                                    monedaOficial?.simbolo
                                                }}:</label
                                            >
                                            <input
                                                type="number"
                                                class="form-control"
                                                @keyup="actualizaMontos"
                                                v-model="form.adelanto"
                                                :disabled="form.id != 0"
                                            />
                                        </div>
                                        <div class="col-md-6">
                                            <label
                                                >Saldo
                                                {{
                                                    monedaOficial?.simbolo
                                                }}:</label
                                            >
                                            <input
                                                type="number"
                                                class="form-control"
                                                readonly
                                                v-model="form.saldo"
                                            />
                                        </div>
                                        <div class="col-md-6">
                                            <label
                                                >Garantía
                                                {{
                                                    monedaOficial?.simbolo
                                                }}:</label
                                            >
                                            <input
                                                type="number"
                                                class="form-control"
                                                v-model="form.garantia"
                                            />
                                        </div>
                                    </div>
                                    <!-- CON TIPO DE CAMBIO -->
                                    <!-- SOLO MOSTRAR LOS DATOS SEGÚN MONEDA SELECCIONADA -->
                                    <!-- <div class="row">
                                    <div class="col-md-6">
                                        <label
                                            >Total {{ monedaOficial?.simbolo }}:</label
                                        >
                                        <input
                                            type="number"
                                            class="form-control"
                                            readonly
                                        />
                                    </div>
                                    <div class="col-md-6">
                                        <label
                                            >Cancelado
                                            {{ monedaOficial?.simbolo }}:</label
                                        >
                                        <input type="number" class="form-control" />
                                    </div>
                                </div> -->
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <button
                                        type="button"
                                        class="btn btn-primary w-100"
                                        @click.prevent="enviarFormulario"
                                        :disabled="
                                            enviando ||
                                            !form.cliente_id ||
                                            !form.habitacion_id
                                        "
                                        v-html="textBtn"
                                    ></button>
                                    <button
                                        type="button"
                                        class="btn btn-default w-100 my-1"
                                        @click.prevent="cerrarFormulario()"
                                    >
                                        <i class="fa fa-times"></i> Cancelar
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </template>
        </MiModal>
        <Formulario
            :muestra_formulario="muestra_formulario"
            :accion_formulario="accion_formulario_cliente"
            :disabled-body="false"
            :respuesta="'json'"
            @envio-formulario="updateClientes"
            @cerrar-formulario="cierreFormCliente"
        ></Formulario>
    </div>
</template>

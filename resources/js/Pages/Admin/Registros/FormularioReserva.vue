<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { useRegistros } from "@/composables/registros/useRegistros";
import Formulario from "../Clientes/Formulario.vue";
import { watch, ref, computed, onMounted, nextTick } from "vue";
import { useMonedaOficial } from "@/composables/monedaOficial/useMonedaOficial";
import { useTipoCambio } from "@/composables/useTipoCambio";
const { monedaOficial } = useMonedaOficial();
const { convertirMonto } = useTipoCambio();
const props = defineProps({
    muestra_formulario: {
        type: Boolean,
        default: false,
    },
    accion_formulario: {
        type: Number,
        default: 0,
    },
});

const { oRegistro, limpiarRegistro } = useRegistros();
const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
let form = useForm(oRegistro.value);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            form = useForm(oRegistro.value);
            cargarListas();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oRegistro.value);

            if (form.id == 0) {
                caclularFechaSalida();
                form.moneda_id_tc = monedaOficial?.value.id;
            } else {
                verificarHabitaciones();
                agregarClienteASelect(oRegistro.value.cliente);
            }
            actualizaMontos();
        } else {
            document
                .getElementsByTagName("body")[0]
                .classList.remove("modal-open");
        }
    }
);
watch(
    () => props.accion_formulario,
    (newValue) => {
        accion_form.value = newValue;
    }
);

const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-plus"></i> Nueva Reserva`
        : `<i class="fa fa-edit"></i> Editar Reserva`;
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
            const codigoReserva = response.props.flash.codigoReserva ?? "S/C";
            const mensaje = `Código de Reserva <strong class="text-md">${codigoReserva}</strong>`;
            Swal.fire({
                icon: "success",
                title: "¡Registro Finalizado!",
                html: `${mensaje}`,
                confirmButtonText: `Aceptar`,
                customClass: {
                    confirmButton: "btn-success",
                },
            });
            limpiarRegistro();
            emits("envio-formulario");
        },
        onError: (err, code) => {
            console.log(code ?? "");
            console.log(form.errors);
            if (form.errors) {
                const error =
                    "Existen errores en el formulario, por favor verifique";
                Swal.fire({
                    icon: "info",
                    title: "Error",
                    html: `<strong>${error}</strong>`,
                    confirmButtonText: `Aceptar`,
                    customClass: {
                        confirmButton: "btn-success",
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

watch(muestra_form, (newVal) => {
    if (!newVal) {
        emits("cerrar-formulario");
    }
});

const cerrarFormulario = () => {
    muestra_form.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

const oHabitacion = ref(null);
const getHabitacion = () => {
    form.cd = 0;
    oHabitacion.value = null;
    if (!form.habitacion_id) {
        actualizaMontos();
        return;
    }
    axios
        .get(route("habitacions.show", form.habitacion_id))
        .then((response) => {
            oHabitacion.value = response.data;
            form.cd = oHabitacion.value.precio;
            actualizaMontos();
        });
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

const listHabitacions = ref([]);
const verificarHabitaciones = () => {
    axios
        .get(route("habitacions.verificaHabitacionesReserva"), {
            params: {
                fecha_ini: form.fecha_entrada,
                fecha_fin: form.fecha_salida,
                habitacion_id: form.id != 0 ? form.habitacion_id : 0,
            },
        })
        .then((response) => {
            listHabitacions.value = response.data.habitacions;
        });
};

const cargarListas = () => {
    cargarMonedas();
};

const accion_formulario_cliente = ref(0);
const muestra_formulario_cliente = ref(false);
const agregarCliente = () => {
    muestra_formulario_cliente.value = true;
    accion_formulario_cliente.value = 0;
};

const updateClientes = (item) => {
    muestra_formulario_cliente.value = false;
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
};
const cierreFormCliente = () => {
    muestra_formulario_cliente.value = false;
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

const actualizaMontos = () => {
    // form.moneda_id_tc = monedaOficial?.value.id;
    form.total = form.dias_estadia * form.cd;
    form.saldo = form.total - form.adelanto;
    // USAR UNA FUNCION PARA TIPO DE CAMBIO
    // DETECTANDO SI HAY O NO UN TIPO DE CAMBIO
    if (form.tc == 1) {
        form.cd_tc = convertirMonto(form.cd, 1, form.valor_tc);
        form.total_tc = convertirMonto(form.total, 1, form.valor_tc);
        form.saldo_tc = convertirMonto(form.saldo, 1, form.valor_tc);
    }
};

// calcular el monto en la moneda principal
const actualizaMontosCambio = () => {
    form.saldo_tc = form.total_tc - form.adelanto_tc;
    form.saldo = convertirMonto(form.saldo_tc, form.valor_tc, 1);
    form.adelanto = convertirMonto(form.adelanto_tc, form.valor_tc, 1);
    if (form.saldo_tc == 0) {
        form.adelanto = form.total;
    }
};

const calcularGarantiaCambio = () => {
    form.garantia = convertirMonto(form.garantia_tc, form.valor_tc, 1);
};

const listMonedas = ref([]);
const cargarMonedas = () => {
    axios.get(route("monedas.listado")).then((response) => {
        listMonedas.value = response.data.monedas;
    });
};

const oTipoCambio = ref(null);
const cargarTipoCambios = () => {
    oTipoCambio.value = null;
    form.tc = 0;
    axios
        .get(route("tipo_cambios.listadoByMonedaId"), {
            params: {
                moneda_id: form.moneda_id_tc ?? 0,
            },
        })
        .then((response) => {
            oTipoCambio.value = response.data.tipo_cambios;
            if (oTipoCambio.value) {
                form.adelanto_tc = 0;
                form.saldo_tc = 0;
                form.garantia_tc = 0;
                form.tc = 1;
                form.tipo_cambio_id = oTipoCambio.value.id;
                form.valor_tc = oTipoCambio.value.valor;
                // obtener el el monto diario en dolares
                form.cd_tc = convertirMonto(form.cd, 1, form.valor_tc);
                form.adelanto_tc = convertirMonto(
                    form.adelanto,
                    1,
                    form.valor_tc
                );
                form.garantia_tc = convertirMonto(
                    form.garantia,
                    1,
                    form.valor_tc
                );
            }
            actualizaMontos();
        });
};

const simboloMonedaCambio = computed(() => {
    if (form.moneda_id_tc) {
        const moneda = listMonedas.value.filter(
            (elem) => elem.id === form.moneda_id_tc
        )[0];
        return `${moneda?.simbolo}`;
    }
    return ``;
});

const modificarCD = () => {
    actualizaMontos();
};

const fechaMinima = () => {
    const hoy = new Date().toISOString().split("T")[0];
    const nuevaFecha = form.fecha_entrada;
    if (nuevaFecha < hoy) {
        form.fecha_entrada = hoy;
        form.errors.fecha_entrada = "La fecha no puede ser menor a hoy";
        toast.error("La fecha no puede ser menor a hoy");
    } else {
        delete form.errors.fecha_entrada;
    }
};

onMounted(() => {});
</script>

<template>
    <div>
        <MiModal
            :open_modal="muestra_form"
            @close="cerrarFormulario"
            :size="'modal-xl'"
            :header-class="'bg-dark'"
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
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-4 mt-2">
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
                                                @keyup="
                                                    fechaMinima();
                                                    caclularFechaSalida();
                                                    listHabitacions = [];
                                                "
                                                @change="
                                                    fechaMinima();
                                                    caclularFechaSalida();
                                                    listHabitacions = [];
                                                "
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
                                        <div class="col-md-4 mt-2">
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
                                                readonly
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
                                        <div class="col-md-4 mt-2">
                                            <label>Días de estadía</label>
                                            <el-input-number
                                                class="w-100"
                                                v-model="form.dias_estadia"
                                                :min="1"
                                                @change="
                                                    caclularFechaSalida();
                                                    actualizaMontos();
                                                    listHabitacions = [];
                                                "
                                            >
                                                <template #suffix>
                                                    <span>Día(s)</span>
                                                </template></el-input-number
                                            >
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div
                                            class="col-lg-4 offset-lg-2 col-md-5 mt-2 offset-md-1"
                                        >
                                            <label>
                                                Fecha de Salida
                                                <small
                                                    class="text-muted text-xs"
                                                    >(Automatico)</small
                                                ></label
                                            >
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
                                        <div class="col-lg-4 col-md-5 mt-2">
                                            <label>
                                                Hora de Salida
                                                <small
                                                    class="text-muted text-xs"
                                                    >(Automatico)</small
                                                >
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
                                    <div class="row">
                                        <div class="col-md-4 offset-md-4">
                                            <button
                                                type="button"
                                                class="btn bg7 border btn-sm w-100"
                                                @click.prevent="
                                                    verificarHabitaciones
                                                "
                                            >
                                                <i class="fa fa-search"></i>
                                                Verificar habitaciones
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body body_info">
                                    <div class="row">
                                        <div class="col-md-6 mb-2">
                                            <label>Cliente</label>
                                            <div class="input-group">
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
                                                        @click.prevent="
                                                            agregarCliente
                                                        "
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
                                        <div class="col-md-6 mt-2">
                                            <label
                                                >Seleccionar habitación</label
                                            >
                                            <small
                                                class="ml-2 font-weight-bold text-muted"
                                                >Disponibles:
                                                <span class="text-sm">
                                                    {{ listHabitacions.length }}
                                                </span></small
                                            >
                                            <el-select
                                                class="w-100"
                                                readonly
                                                v-model="form.habitacion_id"
                                                :no-data-text="'Sin registros'"
                                                :no-match-text="'Sin registros'"
                                                placeholder="Seleccionar habitacion"
                                                @change="getHabitacion"
                                                filterable
                                            >
                                                <el-option
                                                    v-for="item in listHabitacions"
                                                    :key="item.id"
                                                    :value="item.id"
                                                    :label="`${item.numero_habitacion} | ${item?.tipo_habitacion.nombre}`"
                                                >
                                                </el-option>
                                            </el-select>
                                            <ul
                                                v-if="
                                                    form.errors?.habitacion_id
                                                "
                                                class="parsley-errors-list filled"
                                            >
                                                <li class="parsley-required">
                                                    {{
                                                        form.errors
                                                            ?.habitacion_id
                                                    }}
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body pt-1">
                                    <div class="row">
                                        <div
                                            class="col-md-4 offset-md-2 text-center"
                                        >
                                            <label>Moneda</label>
                                            <select
                                                class="form-control text-center"
                                                v-model="form.moneda_id_tc"
                                                @change="cargarTipoCambios"
                                                :disabled="form.id != 0"
                                            >
                                                <option
                                                    v-for="item in listMonedas"
                                                    :value="item.id"
                                                >
                                                    {{ item.nombre }} -
                                                    {{ item.simbolo }}
                                                </option>
                                            </select>
                                            <div v-if="form.tc == 1">
                                                <label>Tipo de Cambio:</label>
                                                <input
                                                    type="number"
                                                    step="0.01"
                                                    class="form-control text-center"
                                                    v-model="form.valor_tc"
                                                    @keyup="recalcularMontoTC"
                                                    readonly
                                                />
                                            </div>
                                        </div>
                                        <div class="col-md-4 text-center">
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
                                                @keyup="modificarCD"
                                                :readonly="
                                                    form.id != 0 ||
                                                    !form.habitacion_id
                                                "
                                            />
                                            <div v-if="form.tc == 1">
                                                <label
                                                    >Costo/Día
                                                    {{ simboloMonedaCambio }}
                                                </label>
                                                <input
                                                    type="number"
                                                    class="form-control text-center"
                                                    v-model="form.cd_tc"
                                                    @change="modificarCD"
                                                    readonly
                                                />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 text-center">
                            <label>Con Desayuno</label>
                            <el-radio-group
                                v-model="form.desayuno"
                                fill="#5cc72f"
                                text-color="#fff"
                                class="d-block"
                            >
                                <el-radio-button :value="0"
                                    ><span class="">No</span></el-radio-button
                                >
                                <el-radio-button :value="1"
                                    ><span class="">Si</span></el-radio-button
                                >
                            </el-radio-group>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-12">
                                            <h5 class="text-center">PAGO</h5>
                                        </div>

                                        <!-- CON TIPO DE CAMBIO -->
                                        <!-- SOLO MOSTRAR LOS DATOS SEGÚN MONEDA SELECCIONADA -->
                                        <div class="col-12">
                                            <div
                                                class="row border-bottom bg4 pb-2"
                                                v-if="
                                                    form.moneda_id_tc !=
                                                    monedaOficial?.id
                                                "
                                            >
                                                <div class="col-md-6">
                                                    <label
                                                        >Total
                                                        {{
                                                            simboloMonedaCambio
                                                        }}:</label
                                                    >
                                                    <input
                                                        type="number"
                                                        class="form-control"
                                                        readonly
                                                        v-model="form.total_tc"
                                                    />
                                                </div>
                                                <div class="col-md-6">
                                                    <label
                                                        >Cancelado
                                                        {{
                                                            simboloMonedaCambio
                                                        }}:</label
                                                    >
                                                    <input
                                                        type="number"
                                                        class="form-control"
                                                        @keyup="
                                                            actualizaMontosCambio
                                                        "
                                                        v-model="
                                                            form.adelanto_tc
                                                        "
                                                        :disabled="form.id != 0"
                                                    />
                                                </div>
                                                <div class="col-md-6">
                                                    <label
                                                        >Saldo
                                                        {{
                                                            simboloMonedaCambio
                                                        }}:</label
                                                    >
                                                    <input
                                                        type="number"
                                                        class="form-control"
                                                        readonly
                                                        v-model="form.saldo_tc"
                                                    />
                                                </div>
                                                <div class="col-md-6">
                                                    <label
                                                        >Garantía
                                                        {{
                                                            simboloMonedaCambio
                                                        }}:</label
                                                    >
                                                    <input
                                                        type="number"
                                                        class="form-control"
                                                        v-model="
                                                            form.garantia_tc
                                                        "
                                                        @keyup="
                                                            calcularGarantiaCambio
                                                        "
                                                    />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-12">
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
                                                <div
                                                    class="col-12"
                                                    v-if="form.garantia > 0"
                                                >
                                                    <label
                                                        >Descripción de
                                                        Garantía:</label
                                                    >
                                                    <el-input
                                                        type="textarea"
                                                        rows="1"
                                                        v-model="
                                                            form.desc_garantia
                                                        "
                                                        autosize
                                                    ></el-input>
                                                </div>
                                            </div>
                                        </div>

                                        <div
                                            class="col-12 text-center mt-2"
                                            v-if="form.id == 0"
                                        >
                                            <label>Forma de Pago</label>
                                            <br />
                                            <el-radio-group
                                                v-model="form.efectivo_banco"
                                            >
                                                <el-radio-button
                                                    :value="'EFECTIVO'"
                                                    ><span
                                                        ><i
                                                            class="fa fa-money-bill text-md"
                                                        ></i>
                                                        Efectivo</span
                                                    ></el-radio-button
                                                >
                                                <el-radio-button
                                                    :value="'BANCO'"
                                                    ><span
                                                        ><i
                                                            class="fa fa-credit-card text-md"
                                                        ></i>
                                                        Banco</span
                                                    ></el-radio-button
                                                >
                                            </el-radio-group>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </template>
            <template #footer>
                <button
                    type="button"
                    class="btn btn-default"
                    @click.prevent="cerrarFormulario()"
                >
                    Cerrar
                </button>
                <button
                    type="button"
                    class="btn btn-primary"
                    :disabled="enviando"
                    @click.prevent="enviarFormulario"
                    v-html="textBtn"
                ></button>
            </template>
        </MiModal>

        <Formulario
            :muestra_formulario="muestra_formulario_cliente"
            :accion_formulario="accion_formulario_cliente"
            :disabled-body="false"
            :respuesta="'json'"
            @envio-formulario="updateClientes"
            @cerrar-formulario="cierreFormCliente"
        ></Formulario>
    </div>
</template>
<style scoped>
.body_info {
    border: dashed 2px var(--principal);
}
</style>

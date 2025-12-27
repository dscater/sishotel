<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { useCajas } from "@/composables/cajas/useCajas";
import { watch, ref, computed, onMounted, nextTick } from "vue";
import { useMonedaOficial } from "@/composables/monedaOficial/useMonedaOficial";
import axios from "axios";
import { useTipoCambio } from "@/composables/useTipoCambio";
const { convertirMonto } = useTipoCambio();

// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
const { monedaOficial } = useMonedaOficial();

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

const { oCaja, limpiarCaja } = useCajas();
const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
let form = useForm(oCaja.value);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            cargarListas();
            form = useForm(oCaja.value);

            if (form.id == 0) {
                form.moneda_id_tc = monedaOficial.value.id;
            }
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
    () => props.accion_formulario,
    (newValue) => {
        accion_form.value = newValue;
    }
);

const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-plus"></i> Nuevo Movimiento de Caja`
        : `<i class="fa fa-edit"></i> Editar Movimiento de Caja`;
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
            ? route("cajas.store")
            : route("cajas.update", form.id);

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
            limpiarCaja();
            emits("envio-formulario");
        },
        onError: (err, code) => {
            console.log(code ?? "");
            console.log(form.errors);
            if (form.errors) {
                if (form.errors.error) {
                    const error = form.errors.error;
                    Swal.fire({
                        icon: "info",
                        title: "Error",
                        html: `<strong>${error}</strong>`,
                        confirmButtonText: `Aceptar`,
                        customClass: {
                            confirmButton: "btn-error",
                        },
                    });
                } else {
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
                }
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

const listMonedas = ref([]);

const cargarMonedas = () => {
    axios.get(route("monedas.listado")).then((response) => {
        listMonedas.value = response.data.monedas;
    });
};

const cargarListas = () => {
    cargarMonedas();
};

const oTipoCambio = ref(null);
const tipoCambios = () => {
    form.tc = 0;
    form.valor_tc = null;
    oTipoCambio.value = null;
    actualizaMontos();
    if (form.moneda_id_tc != monedaOficial.value.id) {
        axios
            .get(route("tipo_cambios.listadoByMonedaId"), {
                params: {
                    moneda_id: form.moneda_id_tc,
                },
            })
            .then((response) => {
                oTipoCambio.value = response.data.tipo_cambios;
                if (oTipoCambio.value) {
                    form.tc = 1;
                    form.tipo_cambio_id = oTipoCambio.value.id;
                    form.valor_tc = oTipoCambio.value.valor;
                    actualizaMontos();
                } else {
                    toast.error(
                        "La moneda seleccionada no cuena con un tipo de cambio definido"
                    );
                }
            });
    }
};

const actualizaMontos = () => {
    if (form.moneda_id_tc != monedaOficial.value.id) {
        form.monto = convertirMonto(form.monto_tc, form.valor_tc, 1);
    } else {
        form.monto = form.monto_tc;
    }
    // console.log(form.monto);
};

onMounted(() => {
    cargarListas();
});
</script>

<template>
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
                <p class="text-muted text-xs mb-0">
                    Todos los campos con
                    <span class="text-danger">(*)</span> son obligatorios.
                </p>
                <div class="row">
                    <div class="col-md-4 mt-2">
                        <label class="required">Ingresar Monto</label>
                        <input
                            type="number"
                            step="0.01"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.monto_tc,
                            }"
                            v-model="form.monto_tc"
                            @keyup="actualizaMontos"
                        />
                        <ul
                            v-if="form.errors?.monto_tc"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.monto_tc }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Moneda</label>
                        <select
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.moneda_id_tc,
                            }"
                            v-model="form.moneda_id_tc"
                            @change="tipoCambios()"
                        >
                            <option
                                v-for="item in listMonedas"
                                :value="item.id"
                            >
                                {{ item.simbolo }}
                            </option>
                        </select>
                        <ul
                            v-if="form.errors?.moneda_id_tc"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.moneda_id_tc }}
                            </li>
                        </ul>
                    </div>

                    <div
                        class="col-md-4 mt-2"
                        v-if="
                            monedaOficial &&
                            form.moneda_id_tc != monedaOficial.id
                        "
                    >
                        <label class="required">Tipo de Cambio</label>
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.valor_tc,
                            }"
                            v-model="form.valor_tc"
                            readonly
                        />

                        <ul
                            v-if="form.errors?.valor_tc"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.valor_tc }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required"
                            >Descripción del movimiento</label
                        >
                        <input
                            type="text"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.descripcion,
                            }"
                            v-model="form.descripcion"
                        />
                        <ul
                            v-if="form.errors?.descripcion"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.descripcion }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Tipo de movimiento</label>
                        <select
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.tipo,
                            }"
                            v-model="form.tipo"
                        >
                            <option value="">- Seleccione -</option>
                            <option value="INGRESO">INGRESO</option>
                            <option value="EGRESO">EGRESO</option>
                        </select>
                        <ul
                            v-if="form.errors?.tipo"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.tipo }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Fecha</label>
                        <input
                            type="date"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.fecha_movimiento,
                            }"
                            v-model="form.fecha_movimiento"
                        />
                        <ul
                            v-if="form.errors?.fecha_movimiento"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.fecha_movimiento }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Hora</label>
                        <input
                            type="time"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.hora_movimiento,
                            }"
                            v-model="form.hora_movimiento"
                        />
                        <ul
                            v-if="form.errors?.hora_movimiento"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.hora_movimiento }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>Tipo</label>
                        <br />
                        <el-radio-group v-model="form.efectivo_banco">
                            <el-radio-button :value="'EFECTIVO'"
                                ><span
                                    ><i class="fa fa-money-bill text-md"></i>
                                    Efectivo</span
                                ></el-radio-button
                            >
                            <el-radio-button :value="'BANCO'"
                                ><span
                                    ><i class="fa fa-credit-card text-md"></i>
                                    Banco</span
                                ></el-radio-button
                            >
                        </el-radio-group>
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
</template>

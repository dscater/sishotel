<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, onMounted, nextTick } from "vue";
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
const props = defineProps({
    indexRegistro: {
        type: Number,
        default: -1,
    },
    registro_servicio: {
        type: Object,
    },
    muestra_formulario: {
        type: Boolean,
        default: false,
    },
    disabledBody: {
        type: Boolean,
        default: true,
    },
});

const oRegistroServicio = ref(props.registro_servicio);
const muestra_form = ref(props.muestra_formulario);
const index_registro = ref(props.indexRegistro);
const enviando = ref(false);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
        } else {
            if (props.disabledBody) {
                document
                    .getElementsByTagName("body")[0]
                    .classList.remove("modal-open");
            }
        }
    }
);

watch(
    () => props.indexRegistro,
    (newValue) => {
        index_registro.value = newValue;
    }
);

const saldo_aux = ref(0);
watch(
    () => props.registro_servicio,
    (newValue) => {
        oRegistroServicio.value = newValue;
        saldo_aux.value = newValue?.saldo ?? 0;
    }
);

const tituloDialog = computed(() => {
    return `<i class="fa fa-plus"></i> Agregar Pago`;
});

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    if (oRegistroServicio.value == 0) {
        return `<i class="fa fa-save"></i> Guardar`;
    }
    return `<i class="fa fa-edit"></i> Agregar Pago`;
});

const oMonto = ref(0);
const efectivo_banco = ref("EFECTIVO");
const enviarFormulario = async () => {
    enviando.value = true;
    let url = route("servicio_pagos.pagoPorPartes", oRegistroServicio.value.id);
    try {
        const response = await axios.post(
            url,
            {
                monto: oMonto.value,
                efectivo_banco: efectivo_banco.value,
            },
            {
                headers: {
                    Accept: "application/json",
                },
            }
        );
        toast.success("Operación completada correctamente!");
        emits("envio-formulario", response.data, index_registro.value);
    } catch (error) {
        console.log("Error JSON:", error.response?.data);

        // limpiar errores anteriores
        oRegistroServicio.errors = {};
        // si el backend envía errores de validación
        if (error.response?.status === 422) {
            const errores = error.response.data.errors;

            // cargar los errores en oRegistroServicio.errors como los usa Inertia
            Object.keys(errores).forEach((campo) => {
                oRegistroServicio.errors[campo] = errores[campo][0]; // solo el primer mensaje
            });
        }
        Swal.fire({
            icon: "info",
            title: "Error",
            html: `<strong>Ocurrió un error en la petición</strong>`,
            confirmButtonText: `Aceptar`,
            customClass: {
                confirmButton: "btn-error",
            },
        });
    } finally {
        enviando.value = false;
    }
};

const emits = defineEmits(["cerrar-formulario", "envio-formulario"]);

watch(muestra_form, (newVal) => {
    if (!newVal) {
        emits("cerrar-formulario");
    }
});

const cerrarFormulario = () => {
    muestra_form.value = false;
    oRegistroServicio.value.saldo = saldo_aux.value;
    oMonto.value = 0;
    if (props.disabledBody) {
        document.getElementsByTagName("body")[0].classList.remove("modal-open");
    }
};
const cargarListas = () => {};

const verificarMonto = () => {
    if (oMonto.value > saldo_aux.value) {
        oMonto.value = saldo_aux.value;
        toast.info("El monto ingresado no puede ser mayor al saldo pendiente.");
    }
    if (oMonto.value < 0) {
        toast.info("El monto ingresado no puede ser negativo.");
    }

    if (oMonto.value >= 0 && oMonto.value <= saldo_aux.value) {
        // monto válido
        oRegistroServicio.value.saldo =
            parseFloat(saldo_aux.value) - parseFloat(oMonto.value);
    }
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
        :disabled-body="disabledBody"
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
            <form @submit.prevent="enviarFormulario()" v-if="oRegistroServicio">
                <div class="row">
                    <div class="col-md-6 offset-md-3">
                        <div class="card">
                            <div class="card-body">
                                <div class="row mb-1">
                                    <div
                                        class="h6 col-5 text-right font-weight-bold"
                                    >
                                        Nro. Registro:
                                    </div>
                                    <div class="h6 col-7">
                                        {{ oRegistroServicio.id }}
                                    </div>
                                </div>
                                <div class="row mb-1">
                                    <div
                                        class="col-5 text-right font-weight-bold"
                                    >
                                        Total:
                                    </div>
                                    <div class="col-7">
                                        {{ oRegistroServicio.total }}
                                    </div>
                                </div>
                                <div class="row mb-1">
                                    <div
                                        class="col-5 text-right font-weight-bold"
                                    >
                                        Cancelado:
                                    </div>
                                    <div class="col-7">
                                        {{ oRegistroServicio.cancelado }}
                                    </div>
                                </div>
                                <div class="row mb-1">
                                    <div
                                        class="col-5 text-right font-weight-bold"
                                    >
                                        Saldo:
                                    </div>
                                    <div class="col-7">
                                        <span
                                            class="badge text-sm"
                                            :class="{
                                                'bg4 text-success':
                                                    oRegistroServicio.saldo ==
                                                    0,
                                                'bg8 text-danger':
                                                    oRegistroServicio.saldo > 0,
                                            }"
                                            >{{ oRegistroServicio.saldo }}</span
                                        >
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <label>Ingresar Monto:</label>
                                <input
                                    type="number"
                                    step="0.01"
                                    class="form-control"
                                    v-model="oMonto"
                                    @keyup="verificarMonto"
                                />
                            </div>
                            <div class="col-12 mt-2">
                                <label>Forma de Pago</label>
                                <br />
                                <el-radio-group v-model="efectivo_banco">
                                    <el-radio-button :value="'EFECTIVO'"
                                        ><span
                                            ><i
                                                class="fa fa-money-bill text-md"
                                            ></i>
                                            Efectivo</span
                                        ></el-radio-button
                                    >
                                    <el-radio-button :value="'BANCO'"
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

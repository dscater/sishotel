<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, onMounted, nextTick } from "vue";
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";

import { useMonedaOficial } from "@/composables/monedaOficial/useMonedaOficial";
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

const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const habitacion = ref(props.oHabitacion);
const oRegistro = ref(null);
const enviando = ref(false);

const form = useForm({
    habitacion_id: "",
    estado: "",
    _method: "PUT",
});

watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            cargarListas();
            asignarDatosForm();
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
        form.registro_id = oRegistro.value.id;
        form.habitacion_destino_id = "";
    }
};

const limpiarDatosForm = () => {
    form.habitacion_id = "";
    form.estado = "";
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

const tituloDialog = computed(() => {
    return `<i class="fa fa-cog"></i> Configuración`;
});

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    return `<i class="fa fa-save"></i> Guardar cambios`;
});

const enviarFormulario = () => {
    enviando.value = true;
    let url = route("habitacions.actualizar_estado", habitacion.value.id);
    axios
        .patch(route("habitacions.actualizar_estado", habitacion.value.id), {
            estado: habitacion.value.estado,
        })
        .then((response) => {
            toast.success("Operación completada correctamente!");
            emits("envio-formulario");
        })
        .catch((error) => {
            console.log(error);
            Swal.fire({
                icon: "error",
                title: "Error",
                html: `<strong>Ocurrió un error inesperado contactese con el Administrador</strong>`,
                confirmButtonText: `Aceptar`,
                customClass: {
                    confirmButton: "btn-error",
                },
            });
        })
        .finally(() => {
            enviando.value = false;
        });
};

const emits = defineEmits(["cerrar-formulario", "envio-formulario"]);

const cerrarFormulario = () => {
    muestra_form.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

const cargarListas = () => {};

onMounted(() => {});
</script>

<template>
    <div>
        <MiModal
            :open_modal="muestra_form"
            @close="cerrarFormulario"
            :size="'modal-xl w-100 modal_registro'"
            :header-class="'bg-orange'"
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
                        <div class="col-md-6 offset-md-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-12 text-center">
                                            <label class="h5">Habitación</label>
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
                                                            class="col-3 text-wrap text-sm"
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
                                                    >NO SE DETECTÓ LA
                                                    HABITACIÓN</span
                                                >
                                            </template>
                                        </div>
                                        <div
                                            class="col-12 text-center"
                                            v-if="habitacion"
                                        >
                                            <el-radio-group
                                                class=""
                                                v-model="habitacion.estado"
                                            >
                                                <el-radio :value="0"
                                                    >DISPONIBLE</el-radio
                                                >
                                                <el-radio :value="3"
                                                    >EN LIMPIEZA</el-radio
                                                >
                                                <el-radio :value="2"
                                                    >EN MANTENIMIENTO</el-radio
                                                >
                                            </el-radio-group>
                                        </div>
                                        <div class="col-12 text-center mt-2">
                                            <button
                                                class="btn bg-principal"
                                                :disabled="enviando"
                                                v-html="textBtn"
                                                @click="enviarFormulario"
                                            ></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </template>
        </MiModal>
    </div>
</template>

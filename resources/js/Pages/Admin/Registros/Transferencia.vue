<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, onMounted, nextTick } from "vue";
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
const oNuevaHabitacion = ref(null);
const oRegistro = ref(null);
const enviando = ref(false);

const form = useForm({
    registro_id: "",
    habitacion_destino_id: "",
    motivo: "",
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
    form.registro_id = "";
    form.motivo = "";
    form.habitacion_destino_id = "";
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
    return accion_form.value == 0
        ? `<i class="fa fa-plus"></i> `
        : `<i class="fa fa-sync"></i> Transferencia`;
});

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    if (accion_form.value == 0) {
        return `<i class="fa fa-save"></i> Guardar`;
    }
    return `<i class="fa fa-sync"></i> Actualizar`;
});

const enviarFormulario = () => {
    enviando.value = true;
    let url = route("registros.transferencia", form.registro_id);

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

const listHabitacions = ref([]);
const cargarHabitacions = () => {
    axios
        .get(route("habitacions.listado"), {
            params: {
                disponibles: true,
                habitacion_id: habitacion.value.id,
            },
        })
        .then((response) => {
            listHabitacions.value = response.data.habitacions;
        });
};
const seleccionaNuevaHabitacion = (value) => {
    oNuevaHabitacion.value = listHabitacions.value.filter(
        (item) => item.id === value
    )[0];
};

const cargarListas = () => {
    cargarHabitacions();
};

onMounted(() => {});
</script>

<template>
    <div>
        <MiModal
            :open_modal="muestra_form"
            @close="cerrarFormulario"
            :size="'modal-xl w-100 modal_registro'"
            :header-class="'bg-warning'"
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
                                        <div class="col-12 text-center mt-2">
                                            <label>Motivo del cambio</label>
                                            <el-input
                                                type="textarea"
                                                class="w-100"
                                                v-model="form.motivo"
                                                autosize
                                            >
                                            </el-input>
                                            <ul
                                                v-if="form.errors?.motivo"
                                                class="parsley-errors-list filled"
                                            >
                                                <li class="parsley-required">
                                                    {{ form.errors?.motivo }}
                                                </li>
                                            </ul>
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
                                            <h4 class="text-center h5">
                                                Habitaciones
                                            </h4>
                                        </div>
                                    </div>
                                    <!-- SIN TIPO DE CAMBIO -->
                                    <div class="row">
                                        <div class="col-12">
                                            <label>Seleccionar</label>
                                            <el-select
                                                class="w-100"
                                                readonly
                                                v-model="
                                                    form.habitacion_destino_id
                                                "
                                                :no-data-text="'Sin registros'"
                                                :no-match-text="'Sin registros'"
                                                placeholder="Seleccionar habitacion"
                                                filterable
                                                @change="
                                                    seleccionaNuevaHabitacion
                                                "
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
                                                    form.errors
                                                        ?.habitacion_destino_id
                                                "
                                                class="parsley-errors-list filled"
                                            >
                                                <li class="parsley-required">
                                                    {{
                                                        form.errors
                                                            ?.habitacion_destino_id
                                                    }}
                                                </li>
                                            </ul>
                                        </div>

                                        <template v-if="oNuevaHabitacion">
                                            <div class="col-12 mt-2">
                                                <div
                                                    class="d-block badge bg6 text-md"
                                                >
                                                    <div class="row">
                                                        <div
                                                            class="col-3 text-wrap"
                                                        >
                                                            {{
                                                                oNuevaHabitacion.numero_habitacion
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
                                                                oNuevaHabitacion
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
                                                                oNuevaHabitacion.capacidad
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
                                                                oNuevaHabitacion.piso
                                                            }}
                                                            <br />
                                                            <i
                                                                class="fa fa-building mt-1 text-icon"
                                                            ></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </template>
                                    </div>
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
                                            !form.habitacion_destino_id ||
                                            !form.registro_id
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
    </div>
</template>

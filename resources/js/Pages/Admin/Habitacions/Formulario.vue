<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { useHabitacions } from "@/composables/habitacions/useHabitacions";
import { watch, ref, computed, onMounted, nextTick } from "vue";
import MiDropZone from "@/Components/MiDropZone.vue";
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

const { oHabitacion, limpiarHabitacion } = useHabitacions();
const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
let form = useForm(oHabitacion.value);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            form = useForm(oHabitacion.value);
            cargarListas();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oHabitacion.value);
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
        ? `<i class="fa fa-plus"></i> Nueva Habitación`
        : `<i class="fa fa-edit"></i> Editar Habitación`;
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
            ? route("habitacions.store")
            : route("habitacions.update", form.id);

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
            limpiarHabitacion();
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

const detectaArchivos = (files) => {
    form.habitacion_fotos = files;
};

const detectaEliminados = (eliminados) => {
    form.eliminados_fotos = eliminados;
};

const listTipoHabitacions = ref([]);
const listEstados = ref([]);

const cargarEstados = async () => {
    try {
        const response = await axios.get(
            route("estado_habitacions.getEstadosHabitacion")
        );
        listEstados.value = Object.entries(response.data).map(
            ([key, value]) => ({
                value: Number(key),
                label: value,
            })
        );
    } catch (error) {
        listEstados.value = [];
    }
};

const cargarTipoHabitacions = async () => {
    try {
        const response = await axios.get(route("tipo_habitacions.listado"));
        listTipoHabitacions.value = response.data.tipo_habitacions;
    } catch (error) {
        listTipoHabitacions.value = [];
    }
};

const cargarListas = () => {
    cargarEstados();
    cargarTipoHabitacions();
};

const getTipoHabitacionDetails = () => {
    if (form.tipo_habitacion_id && form.tipo_habitacion_id != "") {
        axios
            .get(route("tipo_habitacions.show", form.tipo_habitacion_id))
            .then((response) => {
                form.capacidad = response.data.capacidad ?? 1;
            });
    }
};

onMounted(() => {});
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
                <div class="row">
                    <div class="col-md-4 mt-2">
                        <label>Código de habitación</label>
                        <input
                            type="text"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.numero_habitacion,
                            }"
                            v-model="form.numero_habitacion"
                        />
                        <ul
                            v-if="form.errors?.numero_habitacion"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.numero_habitacion }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>Tipo de habitación</label>
                        <select
                            class="form-control"
                            :class="{
                                'parsley-error':
                                    form.errors?.tipo_habitacion_id,
                            }"
                            v-model="form.tipo_habitacion_id"
                            @change="getTipoHabitacionDetails()"
                        >
                            <option value="">- Seleccione -</option>
                            <option
                                v-for="item in listTipoHabitacions"
                                :value="item.id"
                            >
                                {{ item.nombre }}
                            </option>
                        </select>

                        <ul
                            v-if="form.errors?.tipo_habitacion_id"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.tipo_habitacion_id }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>Piso</label>
                        <input
                            type="text"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.piso,
                            }"
                            v-model="form.piso"
                        />

                        <ul
                            v-if="form.errors?.piso"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.piso }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>Precio</label>
                        <el-input-number
                            class="w-100"
                            v-model="form.precio"
                            controls-position="right"
                            size="large"
                            :min="0"
                            :precision="2"
                            :step="0.1"
                        />

                        <ul
                            v-if="form.errors?.precio"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.precio }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label
                            >Precio Temporal
                            <small class="text-muted">(Opcional)</small></label
                        >
                        <el-input-number
                            class="w-100"
                            v-model="form.precio_temp"
                            controls-position="right"
                            size="large"
                            :min="0"
                            :precision="2"
                            :step="0.1"
                        />
                        <ul
                            v-if="form.errors?.precio_temp"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.precio_temp }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>Capacidad</label>
                        <el-input-number
                            class="w-100"
                            v-model="form.capacidad"
                            controls-position="right"
                            size="large"
                            :min="1"
                            :precision="0"
                            :step="1"
                        />
                        <ul
                            v-if="form.errors?.capacidad"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.capacidad }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>Estado</label>

                        <select
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.estado,
                            }"
                            v-model="form.estado"
                        >
                            <option value="">- Seleccione -</option>
                            <option
                                v-for="item in listEstados"
                                :value="item.value"
                            >
                                {{ item.label }}
                            </option>
                        </select>
                        <ul
                            v-if="form.errors?.estado"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.estado }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-12 mt-3">
                        <label class=""
                            >Cargar fotografías
                            <small class="text-muted">(Opcional)</small></label
                        >
                        <MiDropZone
                            :files="form.habitacion_fotos"
                            @UpdateFiles="detectaArchivos"
                            @addEliminados="detectaEliminados"
                        ></MiDropZone>
                        <ul
                            v-if="form.errors?.habitacion_fotos"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.habitacion_fotos }}
                            </li>
                        </ul>
                    </div>
                </div>
                <button class="oculto"></button>
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

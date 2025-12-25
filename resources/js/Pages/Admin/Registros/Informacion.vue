<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, onMounted, nextTick } from "vue";
import { useMonedaOficial } from "@/composables/monedaOficial/useMonedaOficial";
import SliderImagenes from "@/Components/SliderImagenes.vue";
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
    }
);

watch(
    () => props.accion_formulario,
    (newValue) => {
        accion_form.value = newValue;
    }
);

watch(muestra_form, (newVal) => {
    if (!newVal) {
        emits("cerrar-formulario");
    }
});

const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-plus"></i> `
        : `<i class="fa fa-info-circle"></i> Información`;
});

const emits = defineEmits(["cerrar-formulario"]);

const cerrarFormulario = () => {
    muestra_form.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

const listImagenes = ref([]);
const cargarImagenes = () => {
    console.log(habitacion.value.id);
    console.log(route("habitacions.imagenes", habitacion.value.id));
    axios
        .get(route("habitacions.imagenes", habitacion.value?.id))
        .then((response) => {
            console.log(response.data);
            listImagenes.value = response.data;
        });
};
const cargarListas = () => {
    cargarImagenes();
};

onMounted(() => {});
</script>

<template>
    <div>
        <MiModal
            :open_modal="muestra_form"
            @close="cerrarFormulario"
            :size="'modal-xl w-100'"
            :header-class="'bg-info'"
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
                <div class="row">
                    <div class="col-md-8 offset-md-2">
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
                                                        {{ habitacion.piso }}
                                                        <br />
                                                        <i
                                                            class="fa fa-building mt-1 text-icon"
                                                        ></i>
                                                    </div>
                                                    <div
                                                        class="col-12 mt-2"
                                                        v-if="
                                                            listImagenes &&
                                                            listImagenes.length >
                                                                0
                                                        "
                                                    >
                                                        <SliderImagenes
                                                            :imagenes="
                                                                listImagenes
                                                            "
                                                        ></SliderImagenes>
                                                    </div>
                                                    <div class="col-12" v-else>
                                                        <h5
                                                            class="text-muted text-white mt-3"
                                                        >
                                                            No hay imagenes para
                                                            mostrar
                                                        </h5>
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
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </template>
            <template #footer>
                <div class="row">
                    <div class="col-12 text-right">
                        <button
                            class="btn btn-default"
                            @click.prevent="cerrarFormulario"
                        >
                            Cerrar
                        </button>
                    </div>
                </div>
            </template>
        </MiModal>
    </div>
</template>

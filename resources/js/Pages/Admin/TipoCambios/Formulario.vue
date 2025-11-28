<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { useTipoCambios } from "@/composables/tipo_cambios/useTipoCambios";
import { watch, ref, computed, onMounted, nextTick } from "vue";
import { useMonedaOficial } from "@/composables/monedaOficial/useMonedaOficial";
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
    respuesta: {
        type: String,
        default: "",
    },
    disabledBody: {
        type: Boolean,
        default: true,
    },
});

const { oTipoCambio, limpiarTipoCambio } = useTipoCambios();
const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
let form = useForm(oTipoCambio.value);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            cargarListas();
            form = useForm(oTipoCambio.value);
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oTipoCambio.value);
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
    () => props.accion_formulario,
    (newValue) => {
        accion_form.value = newValue;
    }
);

const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-plus"></i> Nuevo Tipo de Cambio`
        : `<i class="fa fa-edit"></i> Editar Tipo de Cambio`;
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
            ? route("tipo_cambios.store")
            : route("tipo_cambios.update", form.id);

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
            limpiarTipoCambio();
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
    if (props.disabledBody) {
        document.getElementsByTagName("body")[0].classList.remove("modal-open");
    }
};

const listMonedas = ref([]);
const cargarMonedas = () => {
    axios
        .get(route("monedas.listado"), {
            params: {
                sinOficial: true,
            },
        })
        .then((response) => {
            listMonedas.value = response.data.monedas;
        });
};

const cargarListas = () => {
    cargarMonedas();
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
                <p class="text-muted text-xs mb-0">
                    Todos los campos con
                    <span class="text-danger">(*)</span> son obligatorios.
                </p>
                <div class="row">
                    <div class="col-md-6 mt-2">
                        <label class="required">Seleccionar Moneda</label>
                        <select
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.moneda_id,
                            }"
                            v-model="form.moneda_id"
                        >
                            <option value="">- Seleccione -</option>
                            <option
                                v-for="item in listMonedas"
                                :value="item.id"
                            >
                                {{ item.nombre }}
                            </option>
                        </select>
                        <ul
                            v-if="form.errors?.moneda_id"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.moneda_id }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-6 mt-2">
                        <label>Valor</label>
                        <el-input-number
                            class="w-100"
                            type="number"
                            :class="{
                                'parsley-error': form.errors?.valor,
                            }"
                            v-model="form.valor"
                            size="large"
                            controls-position="right"
                            :min="0"
                            :precision="2"
                            :step="0.1"
                        />
                        <small class="text-muted"
                            >Indicar el valor equivalente de unidad</small
                        ><br />
                        <small class="text-muted"
                            >Ejemplo: 1 Dólar = 6.98
                            {{ monedaOficial?.simbolo }}</small
                        >
                        <ul
                            v-if="form.errors?.valor"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.valor }}
                            </li>
                        </ul>
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

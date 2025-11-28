<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { useClientes } from "@/composables/clientes/useClientes";
import { watch, ref, computed, onMounted, nextTick } from "vue";
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

const { oCliente, limpiarCliente } = useClientes();
const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const tRespuesta = ref(props.respuesta);
const enviando = ref(false);
let form = useForm(oCliente.value);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            if (props.respuesta != "") {
                oCliente.value.respuesta = props.respuesta;
            }
            form = useForm(oCliente.value);
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oCliente.value);
        } else {
            if (props.disabledBody) {
                console.log("QUITA modal open");
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
watch(
    () => props.respuesta,
    (newValue) => {
        tRespuesta.value = newValue;
        form.respuesta = tRespuesta.value;
    }
);

const listExpedido = [
    { value: "LP", label: "La Paz" },
    { value: "CB", label: "Cochabamba" },
    { value: "SC", label: "Santa Cruz" },
    { value: "CH", label: "Chuquisaca" },
    { value: "OR", label: "Oruro" },
    { value: "PT", label: "Potosi" },
    { value: "TJ", label: "Tarija" },
    { value: "PD", label: "Pando" },
    { value: "BN", label: "Beni" },
];

const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-plus"></i> Nuevo Cliente`
        : `<i class="fa fa-edit"></i> Editar Cliente`;
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

const enviarFormulario = async () => {
    enviando.value = true;
    let url =
        form["_method"] == "POST"
            ? route("clientes.store")
            : route("clientes.update", form.id);

    if (form.respuesta == "json") {
        try {
            const response = await axios.post(url, form.data(), {
                headers: {
                    Accept: "application/json",
                },
            });

            console.log("JSON recibido:", response.data);

            Swal.fire({
                icon: "success",
                title: "Correcto",
                html: `<strong>Guardado correctamente</strong>`,
                confirmButtonText: `Aceptar`,
                customClass: {
                    confirmButton: "btn-success",
                },
            });

            limpiarCliente();
            emits("envio-formulario", response.data);
        } catch (error) {
            console.log("Error JSON:", error.response?.data);

            // limpiar errores anteriores
            form.errors = {};
            // si el backend envía errores de validación
            if (error.response?.status === 422) {
                const errores = error.response.data.errors;

                // cargar los errores en form.errors como los usa Inertia
                Object.keys(errores).forEach((campo) => {
                    form.errors[campo] = errores[campo][0]; // solo el primer mensaje
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
    } else {
        form.post(url, {
            preserveScroll: true,
            forceFormData: true,
            onSuccess: (response) => {
                console.log("correcto");
                const success =
                    response.props.flash.success ??
                    "Proceso realizado con éxito";
                Swal.fire({
                    icon: "success",
                    title: "Correcto",
                    html: `<strong>${success}</strong>`,
                    confirmButtonText: `Aceptar`,
                    customClass: {
                        confirmButton: "btn-success",
                    },
                });
                limpiarCliente();
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
    if (props.disabledBody) {
        document.getElementsByTagName("body")[0].classList.remove("modal-open");
    }
};

const calculaEdad = () => {
    const fechaNacimiento = form.fecha_nac;

    if (fechaNacimiento) {
        const nacimiento = new Date(fechaNacimiento);
        const hoy = new Date();

        let edad = hoy.getFullYear() - nacimiento.getFullYear();

        // Ajuste si aún no cumplió años este año
        const mesNacimiento = nacimiento.getMonth();
        const diaNacimiento = nacimiento.getDate();

        const mesHoy = hoy.getMonth();
        const diaHoy = hoy.getDate();

        if (
            mesHoy < mesNacimiento ||
            (mesHoy === mesNacimiento && diaHoy < diaNacimiento)
        ) {
            edad--;
        }
        form.edad = edad;
    } else {
        form.edad = null;
    }
};

const cargarListas = () => {};

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
            <form @submit.prevent="enviarFormulario()">
                <p class="text-muted text-xs mb-0">
                    Todos los campos con
                    <span class="text-danger">(*)</span> son obligatorios.
                </p>
                <div class="row">
                    <div class="col-md-4 mt-2">
                        <label class="required">Nombre(s)</label>
                        <input
                            type="text"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.nombre,
                            }"
                            v-model="form.nombre"
                        />
                        <ul
                            v-if="form.errors?.nombre"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.nombre }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Ap. Paterno</label>
                        <input
                            type="text"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.paterno,
                            }"
                            v-model="form.paterno"
                        />

                        <ul
                            v-if="form.errors?.paterno"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.paterno }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>Ap. Materno</label>
                        <input
                            type="text"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.materno,
                            }"
                            v-model="form.materno"
                        />

                        <ul
                            v-if="form.errors?.materno"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.materno }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Nro. C.I./Pasaporte</label>
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.ci,
                            }"
                            v-model="form.ci"
                        />

                        <ul
                            v-if="form.errors?.ci"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.ci }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>Expedido</label>
                        <select
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.ci_exp,
                            }"
                            v-model="form.ci_exp"
                        >
                            <option value="">- Seleccione -</option>
                            <option
                                v-for="item in listExpedido"
                                :value="item.value"
                            >
                                {{ item.label }}
                            </option>
                        </select>
                        <ul
                            v-if="form.errors?.ci_exp"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.ci_exp }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>Dirección</label>
                        <input
                            type="text"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.dir,
                            }"
                            v-model="form.dir"
                        />

                        <ul
                            v-if="form.errors?.dir"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.dir }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>Correo electrónico</label>
                        <input
                            type="email"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.correo,
                            }"
                            v-model="form.correo"
                        />

                        <ul
                            v-if="form.errors?.correo"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.correo }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Teléfono/Celular</label>
                        <input
                            type="text"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.fono,
                            }"
                            v-model="form.fono"
                        />

                        <ul
                            v-if="form.errors?.fono"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.fono }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>Fecha de nacimiento</label>
                        <input
                            type="date"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.fecha_nac,
                            }"
                            v-model="form.fecha_nac"
                            @change="calculaEdad"
                        />

                        <ul
                            v-if="form.errors?.fecha_nac"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.fecha_nac }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label
                            >Edad
                            <small class="text-muted">(Automatico)</small>
                        </label>
                        <input
                            type="number"
                            step="1"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.edad,
                            }"
                            v-model="form.edad"
                            readonly
                        />
                        <ul
                            v-if="form.errors?.edad"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.edad }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>Nacionalidad</label>
                        <input
                            type="text"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.nacionalidad,
                            }"
                            v-model="form.nacionalidad"
                        />

                        <ul
                            v-if="form.errors?.nacionalidad"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.nacionalidad }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label>País</label>
                        <input
                            type="text"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.pais,
                            }"
                            v-model="form.pais"
                        />

                        <ul
                            v-if="form.errors?.pais"
                            class="parsley-errors-list filled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.pais }}
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

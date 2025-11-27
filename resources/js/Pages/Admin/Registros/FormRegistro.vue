<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { useUsuarios } from "@/composables/usuarios/useUsuarios";
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
});

const { oUsuario, limpiarUsuario } = useUsuarios();
const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
let form = useForm(oUsuario.value);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            form = useForm(oUsuario.value);
            cargarListas();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oUsuario.value);
            options.value = [
                {
                    value: oUsuario.value.persona_id,
                    label: oUsuario.value.persona
                        ? `${oUsuario.value.persona.full_name} - ${oUsuario.value.persona.ci}`
                        : "Cargando...",
                },
            ];
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

const { flash } = usePage().props;

const listTipos = ref([]);
const foto = ref(null);

function cargaArchivo(e, key) {
    form[key] = null;
    form[key] = e.target.files[0];
}

const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-plus"></i> Nuevo Usuario`
        : `<i class="fa fa-edit"></i> Editar Usuario`;
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
            ? route("usuarios.store")
            : route("usuarios.update", form.id);

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
            limpiarUsuario();
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

watch(muestra_form, (newVal) => {
    if (!newVal) {
        emits("cerrar-formulario");
    }
});

const cerrarFormulario = () => {
    muestra_form.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

const cargarTiposUsuario = async () => {
    try {
        const response = await axios.get(route("tipo_usuarios.getTipos"));
        listTipos.value = response.data;
    } catch (error) {
        listTipos.value = [];
    }
};
const cargarListas = () => {
    cargarTiposUsuario();
};

const options = ref([]);
const loading = ref(false);
const remoteMethod = async (query) => {
    if (query !== "") {
        loading.value = true;
        try {
            const response = await axios.get(
                route("personas.listado") +
                    `?search=${encodeURIComponent(query)}`
            );
            const data = response.data.personas;
            // Suponiendo que data es un array de personas [{id, nombre}]
            options.value = data.map((persona) => ({
                value: persona.id,
                label: `${persona.full_name} - ${persona.ci}`,
            }));
        } catch (error) {
            options.value = [];
        }
        loading.value = false;
    } else {
        options.value = [];
    }
};
onMounted(() => {});
</script>

<template>
    <MiModal
        :open_modal="muestra_form"
        @close="cerrarFormulario"
        :size="'modal-xl'"
        :header-class="'bg-navy'"
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
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12">
                                <h4 class="h5 text-center">
                                    Información del Registro
                                </h4>
                            </div>
                            <div class="col-12">
                                <label>Buscar cliente</label>
                                <div class="input-group mb-3">
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
                                            'is-invalid':
                                                form.errors?.cliente_id,
                                        }"
                                        class="rounded-0"
                                    />
                                    <div class="input-group-append">
                                        <button class="btn btn-primary">
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

                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <form>
                                            <div class="row">
                                                <div class="col-12">
                                                    <h4 class="h5 text-center">
                                                        Ingreso
                                                        <small
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
                                                    <label>
                                                        Fecha de Ingreso
                                                    </label>
                                                    <input
                                                        type="date"
                                                        class="form-control"
                                                        :class="{
                                                            'parsley-error':
                                                                form.errors
                                                                    ?.fecha_entrada,
                                                        }"
                                                        v-model="
                                                            form.fecha_entrada
                                                        "
                                                        @keyup="
                                                            caclularFechaSalida
                                                        "
                                                    />
                                                    <ul
                                                        v-if="
                                                            form.errors
                                                                ?.fecha_entrada
                                                        "
                                                        class="parsley-errors-list filled"
                                                    >
                                                        <li
                                                            class="parsley-required"
                                                        >
                                                            {{
                                                                form.errors
                                                                    ?.fecha_entrada
                                                            }}
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="col-md-4 mb-1">
                                                    <label>
                                                        Hora de Ingreso
                                                    </label>
                                                    <input
                                                        type="time"
                                                        class="form-control"
                                                        :class="{
                                                            'parsley-error':
                                                                form.errors
                                                                    ?.hora_entrada,
                                                        }"
                                                        v-model="
                                                            form.hora_entrada
                                                        "
                                                    />
                                                    <ul
                                                        v-if="
                                                            form.errors
                                                                ?.hora_entrada
                                                        "
                                                        class="parsley-errors-list filled"
                                                    >
                                                        <li
                                                            class="parsley-required"
                                                        >
                                                            {{
                                                                form.errors
                                                                    ?.hora_entrada
                                                            }}
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="col-md-4 mb-1">
                                                    <label
                                                        >Días de estadía</label
                                                    >
                                                    <el-input-number
                                                        class="w-100"
                                                        v-model="
                                                            form.dias_estadia
                                                        "
                                                        :min="1"
                                                        @change="
                                                            caclularFechaSalida
                                                        "
                                                    >
                                                        <template #suffix>
                                                            <span>Día(s)</span>
                                                        </template></el-input-number
                                                    >
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-12">
                                                    <hr class="mt-2 mb-2" />
                                                </div>
                                                <div class="col-12">
                                                    <h4
                                                        class="h5 text-center mb-0"
                                                    >
                                                        Salida
                                                    </h4>
                                                    <small
                                                        class="text-center w-100 d-block"
                                                        >(Automatico)</small
                                                    >
                                                </div>
                                                <div
                                                    class="col-md-4 mb-1 offset-md-2"
                                                >
                                                    <label>
                                                        Fecha de Salida
                                                    </label>
                                                    <input
                                                        type="date"
                                                        class="form-control"
                                                        :class="{
                                                            'parsley-error':
                                                                form.errors
                                                                    ?.fecha_salida,
                                                        }"
                                                        v-model="
                                                            form.fecha_salida
                                                        "
                                                        readonly
                                                    />
                                                    <ul
                                                        v-if="
                                                            form.errors
                                                                ?.fecha_salida
                                                        "
                                                        class="parsley-errors-list filled"
                                                    >
                                                        <li
                                                            class="parsley-required"
                                                        >
                                                            {{
                                                                form.errors
                                                                    ?.fecha_salida
                                                            }}
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="col-md-4 mb-1">
                                                    <label>
                                                        Hora de Salida
                                                    </label>
                                                    <input
                                                        type="time"
                                                        class="form-control"
                                                        :class="{
                                                            'parsley-error':
                                                                form.errors
                                                                    ?.hora_salida,
                                                        }"
                                                        v-model="
                                                            form.hora_salida
                                                        "
                                                        readonly
                                                    />
                                                    <ul
                                                        v-if="
                                                            form.errors
                                                                ?.hora_salida
                                                        "
                                                        class="parsley-errors-list filled"
                                                    >
                                                        <li
                                                            class="parsley-required"
                                                        >
                                                            {{
                                                                form.errors
                                                                    ?.hora_salida
                                                            }}
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <!-- 
                                    to do: VER COMO SE MANEJARA CON DIFERENTES MONEDAS -->
                            <div class="col-12 bg-info">
                                <div class="row py-1">
                                    <div class="col-6 text-right">
                                        <b>Habitación Asignada:</b>
                                    </div>
                                    <div class="col-6">
                                        <template
                                            v-if="form.habitacion_id"
                                        ></template>
                                        <template v-else>
                                            <span
                                                class="badge badge-danger text-md"
                                                >SIN ASIGNAR</span
                                            >
                                        </template>
                                    </div>
                                </div>
                                <div class="row py-1">
                                    <div class="col-6 text-right">
                                        <b>Desayuno:</b>
                                    </div>
                                    <div class="col-6">
                                        <el-radio-group
                                            v-model="form.desayuno"
                                            fill="#5cc72f"
                                            text-color="#fff"
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
                                </div>
                            </div>
                            <div class="col-12 py-1 bg-info">
                                <div class="row">
                                    <div class="col-6 text-right">
                                        <b
                                            >Costo/Día
                                            {{ monedaOficial?.simbolo }}:</b
                                        >
                                    </div>
                                    <div class="col-6">
                                        <input
                                            type="number"
                                            class="form-control"
                                        />
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 py-1 bg-info">
                                <div class="row">
                                    <div class="col-6 text-right">
                                        <b
                                            >Total
                                            {{ monedaOficial?.simbolo }}:</b
                                        >
                                    </div>
                                    <div class="col-6">
                                        <input
                                            type="number"
                                            class="form-control"
                                        />
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 py-1 bg-info">
                                <div class="row">
                                    <div class="col-6 text-right">
                                        <b>Pagar en otra moneda:</b>
                                    </div>
                                    <div class="col-6">
                                        <el-radio-group
                                            v-model="form.tc"
                                            fill="#5cc72f"
                                            text-color="#fff"
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
                                </div>
                            </div>
                            <template v-if="form.tc == 1">
                                <div class="col-12 py-1 bg-success">
                                    <div class="row">
                                        <div class="col-6 text-right">
                                            <b>Moneda:</b>
                                        </div>
                                        <div class="col-6">
                                            <select class="form-control">
                                                <option value="">
                                                    Moneda por Defecto
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 py-1 bg-success">
                                    <div class="row">
                                        <div class="col-6 text-right">
                                            <b>Tipo de Cambio:</b>
                                        </div>
                                        <div class="col-6">
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
                                    </div>
                                </div>
                                <div class="col-12 py-1 bg-success">
                                    <div class="row">
                                        <div class="col-6 text-right">
                                            <b>Costo/Día:</b>
                                        </div>
                                        <div class="col-6">
                                            <input
                                                type="number"
                                                class="form-control"
                                            />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 py-1 bg-success">
                                    <div class="row">
                                        <div class="col-6 text-right">
                                            <b>Costo/Día:</b>
                                        </div>
                                        <div class="col-6">
                                            <input
                                                type="number"
                                                class="form-control"
                                            />
                                        </div>
                                    </div>
                                </div>
                            </template>
                            <div class="col-12 py-1 bg2">
                                <div class="row">
                                    <div class="col-6 text-right">
                                        <b>Cancelado:</b>
                                    </div>
                                    <div class="col-6">
                                        <input
                                            type="number"
                                            class="form-control"
                                        />
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 py-1 bg2">
                                <div class="row">
                                    <div class="col-6 text-right">
                                        <b>Saldo:</b><br />
                                        <small>(Automatico)</small>
                                    </div>
                                    <div class="col-6">
                                        <input
                                            type="number"
                                            class="form-control"
                                            readonly
                                        />
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 py-1 bg2">
                                <div class="row">
                                    <div class="col-6 text-right">
                                        <b>Saldo:</b><br />
                                        <small>(Automatico)</small>
                                    </div>
                                    <div class="col-6">
                                        <input
                                            type="number"
                                            class="form-control"
                                            readonly
                                        />
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 mt-2">
                                <div class="row">
                                    <div class="col-6 offset-6">
                                        <button
                                            class="btn btn-primary w-100"
                                            :disabled="
                                                !form.cliente_id ||
                                                !form.habitacion_id
                                            "
                                        >
                                            Finalizar Registro
                                        </button>
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
</template>

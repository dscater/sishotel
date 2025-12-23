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
    registro: null,
    registro_servicios: [],
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

const asignarDatosForm = async () => {
    form.registro_servicios = [];
    if (oRegistro.value) {
        form.registro_id = oRegistro.value.id;
        // Cargar servicios asociados al registro
        await axios
            .get(route("registro_servicios.listadoByRegistroId"), {
                params: {
                    registro_id: oRegistro.value.id,
                },
            })
            .then((response) => {
                form.registro = response.data.registro;
                form.registro_servicios =
                    response.data.registro_servicios ?? [];
            });
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
        : `<i class="fa fa-cart-plus"></i> Pagos`;
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

const cargarListas = () => {};

const toggleDetalles = (index, sw) => {
    form.registro_servicios[index].muestra_detalles = !sw;
};

onMounted(() => {});
</script>

<template>
    <div>
        <MiModal
            :open_modal="muestra_form"
            @close="cerrarFormulario"
            :size="'modal-xl w-100 modal_registro'"
            :header-class="'bg-blue'"
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
                        <div class="col-12 text-center">
                            <label class="h5">Habitación</label>
                            <template v-if="habitacion">
                                <div class="d-block badge bg1 text-md">
                                    <div class="row">
                                        <div class="col-4 text-wrap">
                                            {{ habitacion.numero_habitacion }}
                                            <br />
                                            <i
                                                class="fa fa-info mt-1 text-icon"
                                            ></i>
                                        </div>
                                        <div class="col-4 text-wrap text-sm">
                                            {{
                                                habitacion.tipo_habitacion
                                                    ?.nombre
                                            }}
                                            <br />
                                            <i
                                                class="fa fa-users mt-1 text-icon"
                                            ></i>
                                        </div>
                                        <div class="col-4 text-wrap">
                                            {{ habitacion.piso }}
                                            <br />
                                            <i
                                                class="fa fa-building mt-1 text-icon"
                                            ></i>
                                        </div>
                                    </div>
                                </div>
                            </template>
                            <template v-else>
                                <span class="d-block badge badge-danger text-md"
                                    >SIN ASIGNAR</span
                                >
                            </template>
                        </div>
                        <div class="col-12">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>N° Registro</th>
                                        <th>Descripción</th>
                                        <th>P/U Bs</th>
                                        <th>Cantidad</th>
                                        <th>Total Bs</th>
                                        <th>Cancelado Bs</th>
                                        <th>Saldo Bs</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <template
                                        v-for="(
                                            item, index
                                        ) in form.registro_servicios"
                                    >
                                        <tr>
                                            <td>{{ item.id }}</td>
                                            <td>
                                                {{ item.tipo }}
                                                <button
                                                    type="button"
                                                    class="btn btn-sm bg4 text-xs py-1 px-2"
                                                    v-if="
                                                        item.tipo ==
                                                        'PRODUCTO/SERVICIO'
                                                    "
                                                    @click="
                                                        toggleDetalles(
                                                            index,
                                                            item.muestra_detalles
                                                        )
                                                    "
                                                >
                                                    +
                                                </button>
                                            </td>
                                            <td
                                                :class="{
                                                    'bg-gray':
                                                        item.tipo !=
                                                        'HOSPEDAJE',
                                                }"
                                            >
                                                {{
                                                    item.tipo == "HOSPEDAJE"
                                                        ? item.registro.cd
                                                        : ""
                                                }}
                                            </td>
                                            <td
                                                :class="{
                                                    'bg-gray':
                                                        item.tipo !=
                                                        'HOSPEDAJE',
                                                }"
                                            >
                                                {{
                                                    item.tipo == "HOSPEDAJE"
                                                        ? item.registro
                                                              .dias_estadia
                                                        : ""
                                                }}
                                            </td>
                                            <td>{{ item.total }}</td>
                                            <td>{{ item.cancelado }}</td>
                                            <td>{{ item.saldo }}</td>
                                        </tr>
                                        <template
                                            v-if="
                                                item.tipo == 'PRODUCTO/SERVICIO'
                                            "
                                        >
                                            <tr
                                                v-show="
                                                    item.muestra_detalles ==
                                                    true
                                                "
                                                v-for="item_detalle in item.servicio_detalles"
                                            >
                                                <td class="border-0"></td>
                                                <td>
                                                    {{
                                                        item_detalle.producto
                                                            .nombre
                                                    }}
                                                </td>
                                                <td>
                                                    {{
                                                        item_detalle.precio_unitario
                                                    }}
                                                </td>
                                                <td>
                                                    {{ item_detalle.cantidad }}
                                                </td>
                                                <td>
                                                    {{ item_detalle.total }}
                                                </td>
                                                <td class="border-0"></td>
                                                <td class="border-0"></td>
                                            </tr>
                                        </template>
                                    </template>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </form>
            </template>
        </MiModal>
    </div>
</template>
<style scoped>
table td {
    vertical-align: middle;
}
</style>

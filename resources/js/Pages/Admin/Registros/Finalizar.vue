<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount, watch, onBeforeUnmount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useMonedaOficial } from "@/composables/monedaOficial/useMonedaOficial";
import Pagos from "@/Components/Pagos.vue";
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
const { monedaOficial } = useMonedaOficial();
const { props: props_page } = usePage();
const appStore = useAppStore();
const props = defineProps({
    registro: {
        type: Object,
        required: true,
    },
});

onBeforeMount(() => {
    document.getElementsByTagName("body")[0].classList.add("sidebar-mini");
    document.getElementsByTagName("body")[0].classList.add("sidebar-collapse");
});

onBeforeUnmount(() => {
    document.getElementsByTagName("body")[0].classList.remove("sidebar-mini");
    document
        .getElementsByTagName("body")[0]
        .classList.remove("sidebar-collapse");
});

const montoCancelado = ref(props.registro.adelanto);
const montoSaldo = ref(props.registro.saldo);

watch(
    () => props.registro,
    (newValue) => {
        montoCancelado.value = newValue.cancelado;
        montoSaldo.value = newValue.saldo;
        console.log("asignando montos");
    }
);

const registro_servicios = ref([]);
const getRegistroServicios = async () => {
    // Cargar servicios asociados al registro
    await axios
        .get(route("registro_servicios.listadoByRegistroId"), {
            params: {
                registro_id: props.registro.id,
            },
        })
        .then((response) => {
            registro_servicios.value = response.data.registro_servicios ?? [];
        });
};

const finalizarRegistro = () => {
    Swal.fire({
        title: "¿Finalizar el registro?",
        html: `Se finalizara el registro Nro. ${props.registro.id}<br/> Habitación: ${props.registro.habitacion.numero_habitacion}`,
        showCancelButton: true,
        confirmButtonText: "Si, finalizar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
        customClass: {
            confirmButton: "bg-principal",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            axios
                .post(route("registros.finalizar_registro", props.registro.id))
                .then((response) => {
                    window.open(response.data.url, "_blank");
                    toast.success("Registro finalizado");
                    router.get(route("registros.index"));
                })
                .catch((err) => {
                    console.log(err);
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
                });
        }
    });
};

const actualizaTotalesRegistro = (totalTotal, totalCancelado, totalSaldo) => {
    montoCancelado.value = totalCancelado;
    montoSaldo.value = totalSaldo;
};

const actualizaGarantia = () => {
    axios
        .put(route("registros.actualizaGarantia", props.registro.id), {
            dev_garantia: props.registro.dev_garantia,
        })
        .then((response) => {
            toast.success("Actualización éxitosa");
        });
};

onMounted(async () => {
    getRegistroServicios();
    appStore.stopLoading();
});
</script>
<template>
    <Head title="Recepción"></Head>

    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Recepción > Finalizar</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Recepción > Finalizar
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <div class="row">
            <div class="col-md-3">
                <Link
                    class="btn btn-default w-100"
                    :href="route('registros.index')"
                >
                    <i class="fa fa-arrow-left"></i> Volver
                </Link>
            </div>
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-6">
                                <h6>Nro. Registro: {{ registro.id }}</h6>
                            </div>
                            <div class="col-6">
                                <h6>
                                    Habitación:
                                    {{ registro.habitacion.numero_habitacion }}
                                </h6>
                            </div>
                            <div class="col-6 offset-6">
                                <h6>
                                    Tipo de habitación:
                                    {{
                                        registro.habitacion.tipo_habitacion
                                            .nombre
                                    }}
                                </h6>
                            </div>
                            <div class="col-12">
                                <table class="table table-bordered">
                                    <tbody>
                                        <tr>
                                            <td
                                                class="text-center p-0 font-weight-bold"
                                            >
                                                Nombre y Apellido
                                            </td>
                                            <td
                                                class="text-center p-0 font-weight-bold"
                                            >
                                                C.I. o Pasaporte
                                            </td>
                                            <td
                                                class="text-center p-0 font-weight-bold"
                                            >
                                                Fecha de Nacimiento
                                            </td>
                                            <td
                                                class="text-center p-0 font-weight-bold"
                                            >
                                                Edad
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-center p-0">
                                                {{ registro.cliente.nombre }}
                                                {{ registro.cliente.paterno }}
                                                {{ registro.cliente.materno }}
                                            </td>
                                            <td class="text-center p-0">
                                                {{ registro.cliente.ci }}
                                            </td>
                                            <td class="text-center p-0">
                                                {{
                                                    registro.cliente
                                                        .fecha_nac ?? "-"
                                                }}
                                            </td>
                                            <td class="text-center p-0">
                                                {{
                                                    registro.cliente.edad ?? "-"
                                                }}
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <h6 class="text-center">
                                    Detalle del Hospedaje
                                </h6>
                                <table class="table table-bordered">
                                    <tbody>
                                        <tr>
                                            <td
                                                class="p-0 text-center font-weight-bold"
                                            >
                                                Fecha de Ingreso
                                            </td>
                                            <td
                                                class="p-0 text-center font-weight-bold"
                                            >
                                                Fecha de Salida
                                            </td>
                                            <td
                                                class="p-0 text-center font-weight-bold"
                                            >
                                                Precio por día
                                            </td>
                                            <td
                                                class="p-0 text-center font-weight-bold"
                                            >
                                                Número Días
                                            </td>
                                            <td
                                                class="p-0 text-center font-weight-bold"
                                            >
                                                Total
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="p-0 text-center">
                                                {{
                                                    registro.fecha_hora_entrada
                                                }}
                                            </td>
                                            <td class="p-0 text-center">
                                                {{ registro.fecha_hora_salida }}
                                            </td>
                                            <td class="p-0 text-center">
                                                {{ registro.cd }}
                                                {{ monedaOficial?.simbolo }}
                                            </td>
                                            <td class="p-0 text-center">
                                                {{ registro.dias_estadia }}
                                            </td>
                                            <td class="p-0 text-center">
                                                {{ registro.total }}
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                <Pagos
                                    :registro_servicios="registro_servicios"
                                    @nuevo-pago="actualizaTotalesRegistro"
                                />

                                <div class="row">
                                    <div class="col-12">
                                        <strong>Garantía: </strong>
                                        {{ registro.garantia }}
                                        {{ monedaOficial?.simbolo }}
                                        <el-checkbox
                                            v-if="registro.garantia > 0"
                                            class="ml-3"
                                            label="Devuelto"
                                            :true-value="1"
                                            :false-value="0"
                                            v-model="registro.dev_garantia"
                                            @change="actualizaGarantia"
                                        />
                                        <p>{{ registro.desc_garantia }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 offset-md-8 mb-3">
                <button
                    class="btn bg-principal w-100"
                    @click="finalizarRegistro"
                    :disabled="parseFloat(montoSaldo) > 0"
                >
                    <i class="fa fa-flag"></i> Finalizar Registro
                </button>
            </div>
        </div>
    </Content>
</template>

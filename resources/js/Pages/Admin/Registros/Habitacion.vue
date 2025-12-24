<script setup>
import { computed, onMounted, onUnmounted, ref, watch } from "vue";
import { usePage, router, Link } from "@inertiajs/vue3";
import axios from "axios";
const props = defineProps({
    habitacion: {
        type: Object,
        default: null,
    },
});

const oHabitacion = ref(props.habitacion);
watch(
    () => props.habitacion,
    (newVal) => {
        oHabitacion.value = newVal;
        verificaRegistro();
    }
);

const muestraFormulario = () => {
    emits("form-registro", oHabitacion.value, oRegistro.value);
};

const muestraTransferencia = () => {
    emits("form-transferencia", oHabitacion.value, oRegistro.value);
};

const muestraServicios = () => {
    emits("form-servicios", oHabitacion.value, oRegistro.value);
};

const muestraPagos = () => {
    emits("form-pagos", oHabitacion.value, oRegistro.value);
};

const oRegistro = ref(null);
const verificaRegistro = () => {
    oRegistro.value = null;
    if (oHabitacion.value.estado == 1 || oHabitacion.value.estado == 4) {
        axios
            .get(route("registros.verificaHabitacion"), {
                params: {
                    habitacion_id: oHabitacion.value.id,
                },
            })
            .then((response) => {
                oRegistro.value = response.data;
            });
    }
};

const esSalidaHoy = computed(() => {
    if (!oRegistro.value || !oRegistro.value.fecha_salida_t) return false;

    const [d, m, y] = oRegistro.value.fecha_salida_t.split("/");

    // Crear fecha REAL local (sin UTC)
    const fechaRegistro = new Date(y, m - 1, d);

    const hoy = new Date();

    // Normalizar
    fechaRegistro.setHours(0, 0, 0, 0);
    hoy.setHours(0, 0, 0, 0);

    return fechaRegistro.getTime() === hoy.getTime();
});
const emits = defineEmits([
    "form-registro",
    "form-transferencia",
    "form-servicios",
    "form-pagos",
]);

const menu = ref(false);

const toggleMenu = () => {
    menu.value = !menu.value;
};

const finalizar = () => {
    if (oRegistro.value) {
        router.get(route("registros.finalizar", oRegistro.value.id));
    }
};

onUnmounted(() => {});

onMounted(() => {
    verificaRegistro();
});
</script>
<template>
    <div class="card habitacion cursor-pointer">
        <div class="card-header p-0">
            <div class="contenedorBotones">
                <div
                    class="boton"
                    v-if="oHabitacion?.estado == 1 || oHabitacion?.estado == 4"
                >
                    <button
                        class="btn bg-blue w-100 rounded-0"
                        title="Registrar Pagos"
                        @click="muestraPagos"
                    >
                        <i class="fa fa-cash-register"></i>
                    </button>
                </div>
                <div
                    class="boton"
                    v-if="oHabitacion?.estado == 1 || oHabitacion?.estado == 4"
                    title="Agregar sevicios"
                >
                    <button
                        class="btn btn-primary w-100 rounded-0"
                        @click="muestraServicios"
                    >
                        <i class="fa fa-cart-plus"></i>
                    </button>
                </div>
                <div
                    class="miDropdownMenu"
                    :class="[menu == true ? 'show' : '']"
                >
                    <button
                        type="button"
                        class="btn bg-white rounded-0"
                        @click.prevente="toggleMenu"
                        title="Opciones"
                    >
                        <i class="fa fa-list"></i>
                    </button>
                    <div class="menu">
                        <button
                            class="menu-item"
                            type="button"
                            @click.prevent="muestraTransferencia()"
                            v-if="oHabitacion?.estado == 1"
                        >
                            <i class="fa fa-sync text-warning"></i>
                            Transferencia
                        </button>
                        <button class="menu-item" type="button">
                            <i class="fa fa-info-circle text-info"></i>
                            Información
                        </button>
                        <button class="menu-item" type="button">
                            <i class="fa fa-cog text-orange"></i>
                            Configurar
                        </button>
                        <button
                            class="menu-item bg-danger"
                            type="button"
                            v-if="
                                oHabitacion?.estado == 1 ||
                                oHabitacion?.estado == 4
                            "
                            @click="finalizar"
                        >
                            <i class="fa fa-power-off"></i> Finalizar
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div
            class="card-body text-center contenedorHabitacion"
            @click="muestraFormulario()"
        >
            <div class="info_habitacion">
                <h5 class="font-weight-bold">
                    {{ oHabitacion?.numero_habitacion }}
                </h5>
                <div class="row mb-1">
                    <div class="col-12 text-muted">
                        {{ oHabitacion?.tipo_habitacion?.nombre }}
                    </div>
                </div>
                <div class="info_badges">
                    <span class="badge bg-blue">
                        {{ oHabitacion?.piso }}
                        <br />
                        <i class="fa fa-building mt-1"></i>
                    </span>
                    <span class="badge badge-success">
                        {{ oHabitacion?.capacidad }}
                        <br />
                        <i class="fa fa-users mt-1"></i>
                    </span>
                </div>
            </div>

            <div
                class="info_registro"
                v-if="oRegistro"
                :class="{ saliente: esSalidaHoy }"
            >
                <div class="info_reg">
                    {{ oRegistro.fecha_salida_t }}
                    {{ oRegistro.hora_salida }}
                    <br />
                    <i class="fa fa-calendar-alt"></i>
                </div>
                <div class="info_reg">
                    {{ oRegistro.cliente.nombre }}
                    {{ oRegistro.cliente.paterno }}
                    {{ oRegistro.cliente.materno }}
                    {{ oRegistro.cliente.ci }} {{ oRegistro.cliente.ci_exp }}
                    <br />
                    <i class="fa fa-user"></i>
                </div>
            </div>
        </div>
        <div
            class="card-footer"
            @click="muestraFormulario()"
            :class="[
                {
                    'bg-success': oHabitacion?.estado == 0,
                    'bg-danger': oHabitacion?.estado == 1,
                    'bg-primary': oHabitacion?.estado == 2,
                    'bg-orange': oHabitacion?.estado == 3,
                    'bg-info': oHabitacion?.estado == 4,
                },
            ]"
        >
            <h5 class="p-0 m-0 text-center font-weight-bold text-xs">
                {{ oHabitacion?.estado_t }}
            </h5>
        </div>
    </div>
</template>

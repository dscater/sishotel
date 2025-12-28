<script setup>
import { computed, onMounted, ref } from "vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { useAppStore } from "@/stores/aplicacion/appStore";
import Content from "@/Components/Content.vue";
const appStore = useAppStore();

const { auth } = usePage().props;
const user = ref(auth.user);

const cargarListas = () => {};

const obtenerFechaActual = () => {
    const fecha = new Date();
    const anio = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, "0"); // Mes empieza desde 0
    const dia = String(fecha.getDate()).padStart(2, "0"); // Día del mes
    return `${anio}-${mes}-${dia}`;
};

onMounted(() => {
    cargarListas();
    appStore.stopLoading();
});

const form = ref({
    fecha_ini: obtenerFechaActual(),
    fecha_fin: obtenerFechaActual(),
});

const generando = ref(false);
const txtBtn = computed(() => {
    if (generando.value) {
        return "Generando Reporte...";
    }
    return "Generar Reporte";
});

const generarReporte = () => {
    generando.value = true;
    const url = route("reportes.r_clientes", form.value);
    window.open(url, "_blank");
    setTimeout(() => {
        generando.value = false;
    }, 500);
};
</script>
<template>
    <Head title="Reporte Lista de Clientes"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Reportes > Lista de Clientes</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Reportes > Lista de Clientes
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card">
                    <div class="card-body">
                        <form @submit.prevent="generarReporte">
                            <div class="row">
                                <div class="col-12 mb-2">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label>Fecha Inicio</label>
                                            <input
                                                type="date"
                                                class="form-control"
                                                :class="{
                                                    'parsley-error':
                                                        form.errors?.fecha_ini,
                                                }"
                                                v-model="form.fecha_ini"
                                            />
                                            <ul
                                                v-if="form.errors?.fecha_ini"
                                                class="parsley-errors-list filled"
                                            >
                                                <li class="parsley-required">
                                                    {{ form.errors?.fecha_ini }}
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-md-6">
                                            <label>Fecha Fin</label>
                                            <input
                                                type="date"
                                                class="form-control"
                                                :class="{
                                                    'parsley-error':
                                                        form.errors?.fecha_fin,
                                                }"
                                                v-model="form.fecha_fin"
                                            />
                                            <ul
                                                v-if="form.errors?.fecha_fin"
                                                class="parsley-errors-list filled"
                                            >
                                                <li class="parsley-required">
                                                    {{ form.errors?.fecha_fin }}
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 text-center mt-3">
                                    <button
                                        class="btn btn-primary"
                                        block
                                        @click="generarReporte"
                                        :disabled="generando"
                                        v-text="txtBtn"
                                    ></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>

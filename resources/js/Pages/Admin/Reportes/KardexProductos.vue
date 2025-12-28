<script setup>
import { computed, onMounted, ref } from "vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { useAppStore } from "@/stores/aplicacion/appStore";
import Content from "@/Components/Content.vue";
const appStore = useAppStore();

const { auth } = usePage().props;
const user = ref(auth.user);

const cargarListas = () => {
    cargarProductos();
};

const listProductos = ref([]);
const cargarProductos = async () => {
    axios.get(route("productos.listado")).then((response) => {
        listProductos.value = response.data.productos;
        listProductos.value.unshift({
            id: "todos",
            nombre: "TODOS",
        });
    });
};
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
    producto_id: "todos",
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
    const url = route("reportes.r_kardex_productos", form.value);
    window.open(url, "_blank");
    setTimeout(() => {
        generando.value = false;
    }, 500);
};
</script>
<template>
    <Head title="Reporte Kardex de Productos"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Reportes > Kardex de Productos</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Reportes > Kardex de Productos
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
                                <div class="col-md-12 mb-2">
                                    <label>Seleccionar producto*</label>
                                    <el-select
                                        :hide-details="
                                            form.errors?.producto_id
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.producto_id
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.producto_id
                                                ? form.errors?.producto_id
                                                : ''
                                        "
                                        v-model="form.producto_id"
                                        class="w-100"
                                        filterable
                                    >
                                        <el-option
                                            v-for="item in listProductos"
                                            :key="item.id"
                                            :value="item.id"
                                            :label="item.nombre"
                                        >
                                        </el-option>
                                    </el-select>
                                </div>
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

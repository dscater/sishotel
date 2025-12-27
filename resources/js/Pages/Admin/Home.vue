<script setup>
import App from "@/Layouts/App.vue";
defineOptions({
    layout: App,
});
import Content from "@/Components/Content.vue";
import { usePage, Head, Link, router } from "@inertiajs/vue3";
import { onMounted, onBeforeMount, ref, computed } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import axios from "axios";
import { useAxios } from "@/composables/axios/useAxios";
const { axiosDelete } = useAxios();
const { auth } = usePage().props;
const user = ref(auth.user);
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";

const props_page = defineProps({
    array_infos: {
        type: Array,
    },
});

const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

const { props } = usePage();
const generando = ref(false);
const obtenerFechaActual = () => {
    const fecha = new Date();
    const anio = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, "0"); // Mes empieza desde 0
    const dia = String(fecha.getDate()).padStart(2, "0"); // Día del mes
    return `${anio}-${mes}-${dia}`;
};

const listSalidasHoy = ref([]);
const getListSalidasHoy = () => {
    axios.get(route("registros.listadoSalientesHoy")).then((response) => {
        listSalidasHoy.value = response.data.registros;
    });
};

const listReservasHoy = ref([]);
const getListaReservasHoy = () => {
    axios.get(route("registros.listadoReservasHoy")).then((response) => {
        listReservasHoy.value = response.data.registros;
    });
};

const cargarListas = () => {
    getListSalidasHoy();
    getListaReservasHoy();
};

const eliminarRegistro = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.cod_reserva}</strong>`,
        showCancelButton: true,
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
        customClass: {
            confirmButton: "btn-danger",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await axiosDelete(
                route("registros.destroy", item.id)
            );
            if (respuesta && respuesta.sw) {
                cargarListas();
            }
        }
    });
};

const atenderReserva = (item) => {
    Swal.fire({
        icon: "info",
        title: `Se registrara la reserva ${item.cod_reserva}`,
        html: `<p><strong>Cliente: </strong>${item.cliente.nombre} ${item.cliente.paterno} ${item.cliente.materno}</p>
        <p><strong>Habitación: </strong>${item.habitacion.numero_habitacion} - ${item.habitacion.tipo_habitacion.nombre}</p>
        <p><strong>Fecha de Ingreso: </strong>${item.fecha_hora_entrada}</p>
        <p><strong>Fecha de Salida: </strong>${item.fecha_hora_salida}</p>`,
        showCancelButton: true,
        confirmButtonText: "Registrar",
        cancelButtonText: "Cancelar",
        denyButtonText: `Cancelar`,
        customClass: {
            confirmButton: "bg-principal",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            axios
                .post(route("registros.atenderReserva", item.id), {
                    _method: "put",
                })
                .then((repsonse) => {
                    toast.success("Registro realizado con éxito");
                    cargarListas();
                });
        }
    });
};

const finalizar = (item) => {
    router.get(route("registros.finalizar", item.id));
};

onMounted(() => {
    cargarListas();
    appStore.stopLoading();
});
</script>
<template>
    <Head title="Inicio"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Inicio</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">Inicio</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>

        <div class="row">
            <div class="col-lg-3 col-6" v-for="item in array_infos">
                <!-- small box -->
                <div class="small-box" :class="[item.color]">
                    <div class="inner">
                        <h3 class="text-white">{{ item.cantidad }}</h3>

                        <p>{{ item.label }}</p>
                    </div>
                    <div class="icon">
                        <i class="fa" :class="[item.icon]"></i>
                    </div>
                    <Link :href="route(item.url)" class="small-box-footer"
                        >Ver más <i class="fa fa-arrow-alt-circle-right"></i
                    ></Link>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5>Salidas Hoy ({{ listSalidasHoy.length }})</h5>
                    </div>
                    <div class="card-body overflow-auto">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Fechas</th>
                                    <th>Habitación</th>
                                    <th>Cliente</th>
                                    <th>C.I./Pasaporte</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="item in listSalidasHoy">
                                    <td>
                                        Del
                                        <b>{{ item.fecha_hora_entrada }}</b> al
                                        <br />
                                        <b>{{ item.fecha_hora_salida }}</b>
                                    </td>
                                    <td>
                                        {{ item.habitacion.numero_habitacion }}
                                    </td>
                                    <td>
                                        {{ item.cliente.nombre }}
                                        {{ item.cliente.paterno }}
                                        {{ item.cliente.materno }}
                                    </td>
                                    <td>{{ item.cliente.ci }}</td>
                                    <td>
                                        <el-tooltip
                                            class="box-item"
                                            effect="dark"
                                            content="Finalizar"
                                            placement="left-start"
                                            v-if="
                                                user.permisos == '*' ||
                                                user.permisos.includes(
                                                    'registros.edit'
                                                )
                                            "
                                        >
                                            <button
                                                class="btn btn-danger"
                                                @click="finalizar(item)"
                                            >
                                                <i
                                                    class="fa fa-power-off text-md"
                                                ></i></button
                                        ></el-tooltip>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5>
                            Reservas para Hoy ({{ listReservasHoy.length }})
                        </h5>
                    </div>
                    <div class="card-body overflow-auto">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Habitación</th>
                                    <th>Cliente</th>
                                    <th>C.I./Pasaporte</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="item in listReservasHoy">
                                    <td>
                                        {{ item.habitacion.numero_habitacion }}
                                    </td>
                                    <td>
                                        {{ item.cliente.nombre }}
                                        {{ item.cliente.paterno }}
                                        {{ item.cliente.materno }}
                                    </td>
                                    <td>{{ item.cliente.ci }}</td>
                                    <td>
                                        <el-tooltip
                                            class="box-item"
                                            effect="dark"
                                            content="Atender Reserva"
                                            placement="left-start"
                                            v-if="
                                                user.permisos == '*' ||
                                                user.permisos.includes(
                                                    'registros.edit'
                                                )
                                            "
                                        >
                                            <button
                                                class="btn btn-primary"
                                                @click="atenderReserva(item)"
                                            >
                                                <i
                                                    class="fa fa-clipboard-check text-md"
                                                ></i></button
                                        ></el-tooltip>
                                        <el-tooltip
                                            class="box-item"
                                            effect="dark"
                                            content="Eliminar"
                                            placement="left-start"
                                            v-if="
                                                user.permisos == '*' ||
                                                user.permisos.includes(
                                                    'registros.destroy'
                                                )
                                            "
                                        >
                                            <button
                                                class="btn btn-danger"
                                                @click="eliminarRegistro(item)"
                                            >
                                                <i
                                                    class="fa fa-trash-alt"
                                                ></i></button
                                        ></el-tooltip>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
<style scoped>
.item_btn {
    margin: 10px;
}

.contenido_item i {
    color: black;
}

.contenido_item {
    transition: all 0.8s;
    color: black;
    padding: 10px;
    cursor: pointer;
    background-color: rgb(248, 229, 229);
    border: solid 2px rgb(243, 211, 211);
    border-radius: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-weight: bold;
    font-size: 1.3em;
    flex-direction: column;
}
</style>

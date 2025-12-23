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
    total: 0,
    cancelado: 0,
    saldo: 0,
    moneda_id: "",
    total_tc: "",
    cancelado_tc: "",
    saldo_tc: 0,
    moneda_id_tc: 0,
    tipo_cambio_id: "",
    tipo: "PRODUCTO/SERVICIO",
    efectivo_banco: "EFECTIVO",
    servicio_detalles: [],
});
const cambio = ref(0);

const tipo_producto_id = ref("");

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

const asignarDatosForm = () => {
    if (oRegistro.value) {
        form.registro_id = oRegistro.value.id;
    }
};

const limpiarDatosForm = () => {
    form.registro_id = "";
    form.total = 0;
    form.cancelado = 0;
    form.saldo = 0;
    form.servicio_detalles = [];
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
        : `<i class="fa fa-shopping-cart"></i> Productos/Servicios`;
});

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    if (accion_form.value == 0) {
        return `<i class="fa fa-save"></i> Guardar`;
    }
    return `<i class="fa fa-save"></i> Guardar`;
});

const enviarFormulario = () => {
    enviando.value = true;
    let url = route("registro_servicios.store");

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

const listTipoProductos = ref([]);
const cargarTipoProductos = () => {
    axios
        .get(route("tipo_productos.listado"), {
            params: {},
        })
        .then((response) => {
            listTipoProductos.value = response.data.tipo_productos;
        });
};

const listProductos = ref([]);
const cargarProductosByTipo = () => {
    axios
        .get(route("productos.listadoByTipo"), {
            params: {
                tipo_producto_id: tipo_producto_id.value,
            },
        })
        .then((response) => {
            listProductos.value = response.data.productos;
        });
};

const cargarListas = () => {
    cargarTipoProductos();
};

const detectarTipoProducto = (value) => {
    if (tipo_producto_id.value == value) {
        listProductos.value = [];
        tipo_producto_id.value = "";
        return;
    }
    tipo_producto_id.value = value;
    if (tipo_producto_id.value) cargarProductosByTipo();
};

const agregarDetalle = (producto) => {
    const existe = form.servicio_detalles.filter(
        (elem) => elem.producto_id == producto.id
    )[0];
    if (existe) {
        // EXISTE INCREMENTAR EN 1 LA CANTIDAD
        const index = form.servicio_detalles.findIndex(
            (elem) => elem.producto_id == producto.id
        );
        form.servicio_detalles[index].cantidad++;
        const total =
            form.servicio_detalles[index].cantidad *
            form.servicio_detalles[index].precio_unitario;
        form.servicio_detalles[index].total = total;

        calcularTotal();
        return;
    }

    const total = producto.precio * 1;
    form.servicio_detalles.push({
        producto_id: producto.id,
        producto: producto,
        tipo: "INTERNO",
        descripcion_externo: "",
        cantidad: 1,
        precio_unitario: producto.precio,
        total: total,
    });
    calcularTotal();
};

const eliminarDetalle = (index) => {
    form.servicio_detalles.splice(index, 1);
    calcularTotal();
};

const calcularNuevaCantidad = (e, index) => {
    const value = e.target.value;
    if (!value || value == "") return;
    form.servicio_detalles[index].cantidad = parseFloat(value);
    const total =
        form.servicio_detalles[index].cantidad *
        parseFloat(form.servicio_detalles[index].precio_unitario);
    form.servicio_detalles[index].total = total;
    calcularTotal();
};

const calcularTotal = () => {
    let total = 0;

    form.servicio_detalles.forEach((elem) => {
        total += parseFloat(elem.total);
    });
    form.total = total;

    calcularSaldoCambio();
};

const calcularSaldoCambio = () => {
    cambio.value = 0;
    if (parseFloat(form.cancelado) > parseFloat(form.total)) {
        cambio.value = parseFloat(form.cancelado) - parseFloat(form.total);
    }

    const saldo = parseFloat(form.total) - parseFloat(form.cancelado);
    if (saldo < 0) {
        form.saldo = 0;
        return;
    }
    form.saldo = saldo;
};

onMounted(() => {});
</script>

<template>
    <div>
        <MiModal
            :open_modal="muestra_form"
            @close="cerrarFormulario"
            :size="'modal-xl w-100 modal_registro'"
            :header-class="'bg-principal'"
            :footer-class="'justify-content-end'"
            :bodyClass="'py-0'"
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
                        <div class="col-md-6 bg2 col-lg-7 pt-2">
                            <div class="row">
                                <div class="col-12">
                                    <div class="menu_servicios">
                                        <div
                                            class="item_menu"
                                            :class="{
                                                active:
                                                    item.id == tipo_producto_id,
                                            }"
                                            v-for="item in listTipoProductos"
                                            @click="
                                                detectarTipoProducto(item.id)
                                            "
                                        >
                                            {{ item.nombre }}
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div
                                        class="cont_productos_servicio"
                                        v-if="listProductos.length > 0"
                                    >
                                        <div
                                            class="producto"
                                            v-for="item in listProductos"
                                        >
                                            <div class="contenedor_info">
                                                <div class="img">
                                                    <img
                                                        :src="item.url_imagen"
                                                        alt="Producto"
                                                    />
                                                </div>
                                                <div class="nombre">
                                                    {{ item.nombre }}
                                                </div>
                                                <div class="precio">
                                                    {{ item.precio }}
                                                </div>
                                                <div
                                                    class="stock"
                                                    v-if="
                                                        item.tipo_producto
                                                            .tipo == 'PRODUCTO'
                                                    "
                                                >
                                                    {{ item.stock }}
                                                </div>
                                            </div>
                                            <button
                                                class="btn bg-principal btn-sm w-100 rounded-0 text-sm"
                                                @click.prevent="
                                                    agregarDetalle(item)
                                                "
                                            >
                                                +
                                            </button>
                                        </div>
                                    </div>
                                    <div v-else>
                                        <h5 class="text-muted text-center mt-3">
                                            NO SE ENCONTRÓ NINGÚN REGISTRO
                                        </h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-5 bg3 pt-2 pb-3">
                            <label class="h5 text-center w-100"
                                >Habitación</label
                            >
                            <template v-if="habitacion">
                                <div
                                    class="d-block badge bg1 text-md rounded-0"
                                >
                                    <div class="row mb-0">
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
                            <div class="row">
                                <div class="col-12 overflow-auto">
                                    <table
                                        class="table table-bordered tabla_servicios"
                                    >
                                        <thead>
                                            <tr>
                                                <th width="1%">N°</th>
                                                <th>Producto/Servicio</th>
                                                <th>Tipo</th>
                                                <th>P/U Bs</th>
                                                <th width="100px">Cantidad</th>
                                                <th>Subtotal Bs</th>
                                                <th width="1%"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <template
                                                v-if="
                                                    form.servicio_detalles
                                                        .length > 0
                                                "
                                            >
                                                <tr
                                                    v-for="(
                                                        item, index
                                                    ) in form.servicio_detalles"
                                                >
                                                    <td class="text-center">
                                                        {{ index + 1 }}
                                                    </td>
                                                    <td>
                                                        {{
                                                            item.producto.nombre
                                                        }}
                                                    </td>
                                                    <td>
                                                        <button
                                                            type="button"
                                                            :class="{
                                                                bg5:
                                                                    item.tipo ==
                                                                    'INTERNO',
                                                                bg6:
                                                                    item.tipo ==
                                                                    'EXTERNO',
                                                            }"
                                                        >
                                                            {{ item.tipo }}
                                                        </button>
                                                    </td>
                                                    <td class="text-right pr-1">
                                                        {{
                                                            item.precio_unitario
                                                        }}
                                                    </td>
                                                    <td class="p-0">
                                                        <input
                                                            type="number"
                                                            class="form-control text-center"
                                                            v-model="
                                                                item.cantidad
                                                            "
                                                            @change="
                                                                calcularNuevaCantidad(
                                                                    $event,
                                                                    index
                                                                )
                                                            "
                                                        />
                                                    </td>
                                                    <td class="text-right pr-1">
                                                        {{ item.total }}
                                                    </td>
                                                    <td>
                                                        <button
                                                            class="btn btn-sm bg-danger"
                                                            @click.prevent="
                                                                eliminarDetalle(
                                                                    index
                                                                )
                                                            "
                                                        >
                                                            X
                                                        </button>
                                                    </td>
                                                </tr>
                                            </template>
                                            <template v-else>
                                                <tr>
                                                    <td
                                                        colspan="5"
                                                        class="text-center text-muted"
                                                    >
                                                        NO SE AGREGARON
                                                        PRODUCTOS
                                                    </td>
                                                </tr>
                                            </template>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <small class="font-weight-bold"
                                        >Total</small
                                    >
                                    <input
                                        type="number"
                                        class="form-control"
                                        v-model="form.total"
                                        readonly
                                    />
                                </div>
                                <div class="col-12">
                                    <small class="font-weight-bold"
                                        >Cancelado</small
                                    >
                                    <input
                                        type="number"
                                        class="form-control"
                                        v-model="form.cancelado"
                                        @keyup="calcularSaldoCambio"
                                    />
                                </div>
                                <div
                                    class="col-12 mt-2"
                                    v-if="form.cancelado > 0"
                                >
                                    <label>Forma de Pago</label>
                                    <br />
                                    <el-radio-group
                                        v-model="form.efectivo_banco"
                                    >
                                        <el-radio-button :value="'EFECTIVO'"
                                            ><span
                                                ><i
                                                    class="fa fa-money-bill text-md"
                                                ></i>
                                                Efectivo</span
                                            ></el-radio-button
                                        >
                                        <el-radio-button :value="'BANCO'"
                                            ><span
                                                ><i
                                                    class="fa fa-credit-card text-md"
                                                ></i>
                                                Banco</span
                                            ></el-radio-button
                                        >
                                    </el-radio-group>
                                </div>
                                <div class="col-12">
                                    <small class="font-weight-bold"
                                        >Saldo</small
                                    >
                                    <input
                                        type="number"
                                        class="form-control bgg8"
                                        v-model="form.saldo"
                                        readonly
                                    />
                                </div>
                                <div class="col-12" v-if="cambio > 0">
                                    <small class="font-weight-bold"
                                        >Cambio</small
                                    >
                                    <input
                                        type="number"
                                        class="form-control bg7"
                                        v-model="cambio"
                                        readonly
                                    />
                                </div>
                                <div class="col-12 mt-2">
                                    <button
                                        class="btn bg-principal w-100"
                                        @click="enviarFormulario"
                                        v-html="textBtn"
                                    ></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </template>
            <template #footer>
                <div class="row">
                    <div class="col-12">
                        <button
                            class="btn btn-default"
                            @click="cerrarFormulario"
                        >
                            Cancelar
                        </button>
                    </div>
                </div>
            </template>
        </MiModal>
    </div>
</template>
<style scoped>
.menu_servicios {
    display: flex;
    overflow: auto;
}

.menu_servicios .item_menu {
    cursor: pointer;
    padding: 10px;
    text-align: center;
    border: solid 1px white;
    font-weight: 500;
}

.menu_servicios .item_menu:hover {
    background-color: var(--bgGrayLight);
    color: black;
}

.menu_servicios .item_menu.active {
    background-color: var(--bg5);
    color: white;
}

/* PRODUCTOS */
.cont_productos_servicio {
    width: 100%;
    margin-top: 10px;
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
    border: solid 1px var(--bgGrayDark);
    padding: 10px;
}
.producto {
    display: flex;
    flex-direction: column;
    border: solid 1px var(--bgGrayDark);
    width: 100px;
    justify-content: center;
    align-items: center;
    position: relative;
}

.producto .contenedor_info {
    position: relative;
}

.producto .img {
    height: 100px;
    width: 100%;
    display: flex;
    justify-content: center;
}

.producto .img img {
    max-width: 100%;
    object-fit: cover;
}
.producto .nombre {
    position: absolute;
    top: 0;
    left: 0;
    height: 100%;
    width: 100%;
    background-color: rgba(0, 0, 0, 0.4);
    color: white;
    font-weight: 600;
    padding: 5px;
}

.producto .precio {
    position: absolute;
    bottom: 0;
    right: 0;
    background-color: var(--principal_t);
    color: white;
    font-weight: 700;
    padding: 4px;
    border-radius: 10px 0px 0px 0px;
}

.producto .stock {
    position: absolute;
    bottom: 0;
    left: 0;
    background-color: var(--bg1);
    color: white;
    font-weight: 700;
    padding: 5px;
    border-radius: 0px 10px 0px 0px;
}

.producto .accion button {
    max-height: 100%;
    border: none;
    border-radius: 0;
}

.tabla_servicios td {
    padding: 0;
}

.tabla_servicios input {
    border-radius: 0;
}
</style>

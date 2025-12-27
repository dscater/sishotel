<script setup>
import Swal from "sweetalert2";
import { computed, ref, watch } from "vue";
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
import PagoPartes from "./PagoPartes.vue";

const props = defineProps({
    registro_servicios: {
        type: Array,
        required: true,
    },
});

const oRegistroServicios = ref(props.registro_servicios);

watch(
    () => props.registro_servicios,
    (newValue) => {
        oRegistroServicios.value = newValue;
        emits(
            "nuevo-pago",
            totalTotal.value,
            totalCancelado.value,
            totalSaldo.value
        );
    }
);

const toggleDetalles = (index, muestra_detalles) => {
    oRegistroServicios.value[index].muestra_detalles = !muestra_detalles;
};

const totalTotal = computed(() => {
    let total = 0;
    oRegistroServicios.value.forEach((item) => {
        total += Number(item.total);
    });
    return total.toFixed(2);
});
const totalCancelado = computed(() => {
    let total = 0;
    oRegistroServicios.value.forEach((item) => {
        total += Number(item.cancelado);
    });
    return total.toFixed(2);
});
const totalSaldo = computed(() => {
    let total = 0;
    oRegistroServicios.value.forEach((item) => {
        total += Number(item.saldo);
    });
    return total.toFixed(2);
});

const emits = defineEmits(["nuevo-pago"]);

const pagarTotalEfectivo = (index) => {
    const item = oRegistroServicios.value[index];
    Swal.fire({
        title: "¿Está seguro de realizar el pago total en EFECTIVO?",
        html: `<i class="fa fa-money-bill" style="font-size:2rem;"></i>`,
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Sí, pagar",
        cancelButtonText: "Cancelar",
        customClass: {
            confirmButton: "bg-principal",
            cancelButton: "bg9 text-gray",
        },
    }).then((result) => {
        if (result.isConfirmed) {
            axios
                .post(route("servicio_pagos.pagoTotal", item.id), {
                    efectivo_banco: "EFECTIVO",
                })
                .then((response) => {
                    oRegistroServicios.value[index].cancelado =
                        response.data.cancelado;
                    oRegistroServicios.value[index].saldo = response.data.saldo;
                    toast.success("Operación completada correctamente!");
                    emits(
                        "nuevo-pago",
                        totalTotal.value,
                        totalCancelado.value,
                        totalSaldo.value
                    );
                })
                .catch((error) => {
                    console.log(error);
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        html: `<strong>Ocurrió un error inesperado contactese con el Administrador</strong>`,
                        confirmButtonText: `Aceptar`,
                        customClass: {
                            confirmButton: "btn-error",
                        },
                    });
                });
        }
    });
};

const pagarTotalBanco = (index) => {
    const item = oRegistroServicios.value[index];
    Swal.fire({
        title: "¿Está seguro de realizar el pago total en BANCO?",
        html: `<i class="fa fa-credit-card" style="font-size:2rem;"></i>`,
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Sí, pagar",
        cancelButtonText: "Cancelar",
        customClass: {
            confirmButton: "bg-principal",
            cancelButton: "bg9 text-gray",
        },
    }).then((result) => {
        if (result.isConfirmed) {
            axios
                .post(route("servicio_pagos.pagoTotal", item.id), {
                    efectivo_banco: "BANCO",
                })
                .then((response) => {
                    oRegistroServicios.value[index].cancelado =
                        response.data.cancelado;
                    oRegistroServicios.value[index].saldo = response.data.saldo;
                    toast.success("Operación completada correctamente!");
                    emits(
                        "nuevo-pago",
                        totalTotal.value,
                        totalCancelado.value,
                        totalSaldo.value
                    );
                })
                .catch((error) => {
                    console.log(error);
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        html: `<strong>Ocurrió un error inesperado contactese con el Administrador</strong>`,
                        confirmButtonText: `Aceptar`,
                        customClass: {
                            confirmButton: "btn-error",
                        },
                    });
                });
        }
    });
};

const muestra_form_pago_partes = ref(false);
const itemRegistroServicio = ref(null);
const indexRegistro = ref(-1);
const pagoPorPartes = (index) => {
    const item = oRegistroServicios.value[index];
    // INGRESAR MONTO POR SWAL
    itemRegistroServicio.value = item;
    muestra_form_pago_partes.value = true;
    indexRegistro.value = index;
};

const actualizarMontoFila = (data, index) => {
    oRegistroServicios.value[index].cancelado = data.cancelado;
    oRegistroServicios.value[index].saldo = data.saldo;
    muestra_form_pago_partes.value = false;
    itemRegistroServicio.value = null;
    indexRegistro.value = -1;
    emits(
        "nuevo-pago",
        totalTotal.value,
        totalCancelado.value,
        totalSaldo.value
    );
};
</script>
<template>
    <div>
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th width="1%">N° Registro</th>
                    <th>Fecha</th>
                    <th>Descripción</th>
                    <th>P/U Bs</th>
                    <th>Cantidad</th>
                    <th>Total Bs</th>
                    <th>Cancelado Bs</th>
                    <th>Saldo Bs</th>
                    <th width="1%">Acción</th>
                </tr>
            </thead>
            <tbody>
                <template v-for="(item, index) in oRegistroServicios">
                    <tr>
                        <td>{{ item.id }}</td>
                        <td>{{ item.fecha_t }}</td>
                        <td>
                            {{ item.tipo }}
                            <button
                                type="button"
                                class="btn btn-sm bg4 text-xs py-1 px-2"
                                v-if="item.tipo == 'PRODUCTO/SERVICIO'"
                                @click="
                                    toggleDetalles(index, item.muestra_detalles)
                                "
                            >
                                <span v-if="!item.muestra_detalles">+</span>
                                <span v-if="item.muestra_detalles">-</span>
                            </button>
                        </td>
                        <td
                            :class="{
                                'bg-gray': item.tipo != 'HOSPEDAJE',
                            }"
                        >
                            {{
                                item.tipo == "HOSPEDAJE" ? item.registro.cd : ""
                            }}
                        </td>
                        <td
                            :class="{
                                bg7: item.tipo != 'HOSPEDAJE',
                            }"
                        >
                            {{ item.cantidad }}
                        </td>
                        <td class="text-right">
                            {{ item.total }}
                        </td>
                        <td class="text-right">
                            {{ item.cancelado }}
                            <span
                                v-if="item.tc == 1"
                                class="d-block text-muted text-xs"
                            >
                                ({{ item.cancelado_tc }}
                                {{ item.moneda_tc.simbolo }})
                            </span>
                        </td>
                        <td
                            class="text-right"
                            :class="{
                                bg4: item.saldo == 0,
                                bg8: item.saldo > 0,
                            }"
                        >
                            {{ item.saldo }}
                        </td>
                        <td>
                            <div
                                class="dropdown dropleft"
                                v-if="item.saldo > 0"
                            >
                                <button
                                    class="btn dropdown-toggle btn-sm text-xs bg-principal"
                                    type="button"
                                    data-toggle="dropdown"
                                    aria-expanded="false"
                                >
                                    Acción
                                </button>
                                <div class="dropdown-menu">
                                    <a
                                        class="dropdown-item text-sm"
                                        href="#"
                                        @click.prevent="
                                            pagarTotalEfectivo(index)
                                        "
                                        ><i class="fa fa-money-bill"></i> Total
                                        Efectivo</a
                                    >
                                    <a
                                        class="dropdown-item text-sm"
                                        href="#"
                                        @click.prevent="pagarTotalBanco(index)"
                                        ><i class="fa fa-credit-card"></i> Total
                                        Banco</a
                                    >
                                    <a
                                        class="dropdown-item text-sm"
                                        href="#"
                                        @click.prevent="pagoPorPartes(index)"
                                        ><i class="fa fa-list"></i> Por
                                        partes</a
                                    >
                                    <a
                                        v-if="item.tipo != 'HOSPEDAJE'"
                                        class="dropdown-item text-sm"
                                        target="_blank"
                                        :href="
                                            route(
                                                'registro_servicios.comanda',
                                                item.id
                                            )
                                        "
                                        ><i class="fa fa-file-pdf"></i> Imprimir
                                        Comanda</a
                                    >
                                </div>
                            </div>
                        </td>
                    </tr>
                    <template v-if="item.tipo == 'PRODUCTO/SERVICIO'">
                        <tr
                            v-show="item.muestra_detalles == true"
                            v-for="item_detalle in item.servicio_detalles"
                            class="bg7 no-hover"
                        >
                            <td class="border-0"></td>
                            <td class="border-0"></td>
                            <td>
                                {{ item_detalle.producto.nombre }}
                            </td>
                            <td>
                                {{ item_detalle.precio_unitario }}
                            </td>
                            <td>
                                {{ item_detalle.cantidad }}
                            </td>
                            <td class="text-right">
                                {{ item_detalle.total }}
                            </td>
                            <td class="border-0"></td>
                            <td class="border-0"></td>
                            <td class="border-0"></td>
                        </tr>
                    </template>
                </template>
            </tbody>
            <tfoot>
                <tr class="bg1">
                    <td class="text-right h6" colspan="5">TOTAL</td>
                    <td class="text-right h6">
                        {{ totalTotal }}
                    </td>
                    <td class="text-right h6">
                        {{ totalCancelado }}
                    </td>
                    <td
                        class="text-right h6 text-lg"
                        :class="{
                            'bg4 text-success': parseFloat(totalSaldo) == 0,
                            'bg8 text-danger': parseFloat(totalSaldo) > 0,
                        }"
                    >
                        {{ totalSaldo }}
                    </td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
        <PagoPartes
            :index-registro="indexRegistro"
            :registro_servicio="itemRegistroServicio"
            :muestra_formulario="muestra_form_pago_partes"
            :disabled-body="false"
            @cerrar-formulario="
                muestra_form_pago_partes = false;
                itemRegistroServicio = null;
            "
            @envio-formulario="actualizarMontoFila"
        ></PagoPartes>
    </div>
</template>

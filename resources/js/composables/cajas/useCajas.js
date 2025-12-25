import { onMounted, ref } from "vue";

const oCaja = ref({
    id: 0,
    monto: "",
    moneda_id: "",
    tc: "",
    monto_tc: "",
    moneda_id_tc: "",
    tipo_cambio_id: "",
    valor_tc: "",
    tipo: "",
    efectivo_banco: "",
    descripcion: "",
    fecha_movimiento: "",
    hora_movimiento: "",
    user_id: "",
    _method: "POST",
});

export const useCajas = () => {
    const setCaja = (item = null, ver = false) => {
        if (item) {
            oCaja.value.id = item.id;
            oCaja.value.monto = item.monto;
            oCaja.value.moneda_id = item.moneda_id;
            oCaja.value.tc = item.tc;
            oCaja.value.monto_tc = item.monto_tc;
            oCaja.value.moneda_id_tc = item.moneda_id_tc;
            oCaja.value.tipo_cambio_id = item.tipo_cambio_id;
            oCaja.value.valor_tc = item.valor_tc;
            oCaja.value.tipo = item.tipo;
            oCaja.value.efectivo_banco = item.efectivo_banco;
            oCaja.value.descripcion = item.descripcion;
            oCaja.value.fecha_movimiento = item.fecha_movimiento;
            oCaja.value.hora_movimiento = item.hora_movimiento;
            oCaja.value.user_id = item.user_id;
            oCaja.value._method = "PUT";
            return oCaja;
        }
        return false;
    };

    const limpiarCaja = () => {
        oCaja.value.id = 0;
        oCaja.value.monto = "";
        oCaja.value.moneda_id = "";
        oCaja.value.tc = "";
        oCaja.value.monto_tc = "";
        oCaja.value.moneda_id_tc = "";
        oCaja.value.tipo_cambio_id = "";
        oCaja.value.valor_tc = "";
        oCaja.value.tipo = "";
        oCaja.value.efectivo_banco = "EFECTIVO";
        oCaja.value.descripcion = "";
        oCaja.value.fecha_movimiento = getFechaAtual();
        oCaja.value.hora_movimiento = getHoraActual();
        oCaja.value.user_id = "";
        oCaja.value._method = "POST";
    };

    const getFechaAtual = () => {
        const today = new Date();
        const year = today.getFullYear();
        const month = String(today.getMonth() + 1).padStart(2, "0");
        const day = String(today.getDate()).padStart(2, "0");
        return `${year}-${month}-${day}`;
    };

    const getHoraActual = () => {
        const now = new Date();
        const hours = String(now.getHours()).padStart(2, "0");
        const minutes = String(now.getMinutes()).padStart(2, "0");
        return `${hours}:${minutes}`;
    };

    onMounted(() => {});

    return {
        oCaja,
        setCaja,
        limpiarCaja,
    };
};

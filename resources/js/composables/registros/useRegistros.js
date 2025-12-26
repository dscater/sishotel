import { onMounted, ref } from "vue";

const oRegistro = ref({
    id: 0,
    habitacion_id: null,
    cliente_id: null,
    desayuno: 0,
    fecha_entrada: "",
    hora_entrada: "",
    dias_estadia: 1,
    fecha_salida: null,
    hora_salida: "12:00",
    cd: 0,
    total: 0,
    adelanto: 0,
    saldo: 0,
    garantia: 0,
    desc_garantia: "",
    tc: 0,
    valor_tc: 0,
    cd_tc: null,
    total_tc: null,
    adelanto_tc: null,
    saldo_tc: null,
    garantia_tc: null,
    moneda_id_tc: null,
    tipo: "RESERVA",
    efectivo_banco: "EFECTIVO",
    _method: "POST",
});

export const useRegistros = () => {
    const setRegistro = (item = null, ver = false) => {
        if (item) {
            oRegistro.value.id = item.id;
            oRegistro.value.habitacion_id = item.habitacion_id;
            oRegistro.value.cliente = item.cliente;
            oRegistro.value.cliente_id = item.cliente_id;
            oRegistro.value.desayuno = item.desayuno;
            oRegistro.value.fecha_entrada = item.fecha_entrada;
            oRegistro.value.hora_entrada = item.hora_entrada;
            oRegistro.value.dias_estadia = item.dias_estadia;
            oRegistro.value.fecha_salida = item.fecha_salida;
            oRegistro.value.hora_salida = item.hora_salida;
            oRegistro.value.cd = item.cd;
            oRegistro.value.total = item.total;
            oRegistro.value.adelanto = item.adelanto;
            oRegistro.value.saldo = item.saldo;
            oRegistro.value.garantia = item.garantia;
            oRegistro.value.desc_garantia = item.desc_garantia;
            oRegistro.value.tc = item.tc;
            oRegistro.value.valor_tc = item.valor_tc;
            oRegistro.value.cd_tc = item.cd_tc;
            oRegistro.value.total_tc = item.total_tc;
            oRegistro.value.adelanto_tc = item.adelanto_tc;
            oRegistro.value.saldo_tc = item.saldo_tc;
            oRegistro.value.garantia_tc = item.garantia_tc;
            oRegistro.value.moneda_id_tc = item.moneda_id_tc;
            oRegistro.value.tipo = item.tipo;
            oRegistro.value.efectivo_banco = item.efectivo_banco;
            oRegistro.value._method = "PUT";
            return oRegistro;
        }
        return false;
    };

    const limpiarRegistro = () => {
        oRegistro.value.id = 0;
        oRegistro.value.habitacion_id = "";
        oRegistro.value.cliente_id = "";
        oRegistro.value.desayuno = 0;
        oRegistro.value.fecha_entrada = getFechaAtual();
        oRegistro.value.hora_entrada = getHoraActual();
        oRegistro.value.dias_estadia = 1;
        oRegistro.value.fecha_salida = null;
        oRegistro.value.hora_salida = "12:00";
        oRegistro.value.cd = 0;
        oRegistro.value.total = "";
        oRegistro.value.adelanto = 0;
        oRegistro.value.saldo = "";
        oRegistro.value.garantia = 0;
        oRegistro.value.desc_garantia = "";
        oRegistro.value.tc = 0;
        oRegistro.value.valor_tc = "";
        oRegistro.value.cd_tc = null;
        oRegistro.value.total_tc = null;
        oRegistro.value.adelanto_tc = null;
        oRegistro.value.saldo_tc = null;
        oRegistro.value.garantia_tc = null;
        oRegistro.value.moneda_id_tc = null;
        oRegistro.value.tipo = "RESERVA";
        oRegistro.value.efectivo_banco = "BANCO";
        oRegistro.value._method = "POST";
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
        oRegistro,
        setRegistro,
        limpiarRegistro,
    };
};

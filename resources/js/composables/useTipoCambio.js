import { onMounted } from "vue";

export const useTipoCambio = () => {
    const convertirMonto = (monto, tcOrigen, tcDestino) => {
        if (!monto) return 0;
        const origen = tcOrigen || 1;
        const destino = tcDestino || 1;

        const resultado = monto * (origen / destino);

        return Number(resultado.toFixed(2));
    };

    onMounted(() => {});

    return {
        convertirMonto,
    };
};

import { onMounted, ref } from "vue";

const oEgresoProducto = ref({
    id: 0,
    producto_id: "",
    cantidad: "",
    motivo: "",
    _method: "POST",
});

export const useEgresoProductos = () => {
    const setEgresoProducto = (item = null, ver = false) => {
        if (item) {
            oEgresoProducto.value.id = item.id;
            oEgresoProducto.value.producto_id = item.producto_id;
            oEgresoProducto.value.cantidad = item.cantidad;
            oEgresoProducto.value.motivo = item.motivo;
            oEgresoProducto.value._method = "PUT";
            return oEgresoProducto;
        }
        return false;
    };

    const limpiarEgresoProducto = () => {
        oEgresoProducto.value.id = 0;
        oEgresoProducto.value.producto_id = "";
        oEgresoProducto.value.cantidad = 1;
        oEgresoProducto.value.motivo = "";
        oEgresoProducto.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oEgresoProducto,
        setEgresoProducto,
        limpiarEgresoProducto,
    };
};

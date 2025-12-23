import { onMounted, ref } from "vue";

const oIngresoProducto = ref({
    id: 0,
    producto_id: "",
    cantidad: "",
    precio_compra: "",
    total: "",
    _method: "POST",
});

export const useIngresoProductos = () => {
    const setIngresoProducto = (item = null, ver = false) => {
        if (item) {
            oIngresoProducto.value.id = item.id;
            oIngresoProducto.value.producto_id = item.producto_id;
            oIngresoProducto.value.cantidad = item.cantidad;
            oIngresoProducto.value.precio_compra = item.precio_compra;
            oIngresoProducto.value.total = item.total;
            oIngresoProducto.value._method = "PUT";
            return oIngresoProducto;
        }
        return false;
    };

    const limpiarIngresoProducto = () => {
        oIngresoProducto.value.id = 0;
        oIngresoProducto.value.producto_id = "";
        oIngresoProducto.value.cantidad = 1;
        oIngresoProducto.value.precio_compra = 1;
        oIngresoProducto.value.total = 0;
        oIngresoProducto.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oIngresoProducto,
        setIngresoProducto,
        limpiarIngresoProducto,
    };
};

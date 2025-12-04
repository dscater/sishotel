import { onMounted, ref } from "vue";

const oTipoProducto = ref({
    id: 0,
    nombre: "",
    descripcion: "",
    _method: "POST",
});

export const useTipoProductos = () => {
    const setTipoProducto = (item = null, ver = false) => {
        if (item) {
            oTipoProducto.value.id = item.id;
            oTipoProducto.value.nombre = item.nombre;
            oTipoProducto.value.descripcion = item.descripcion;
            oTipoProducto.value._method = "PUT";
            return oTipoProducto;
        }
        return false;
    };

    const limpiarTipoProducto = () => {
        oTipoProducto.value.id = 0;
        oTipoProducto.value.nombre = "";
        oTipoProducto.value.descripcion = "";
        oTipoProducto.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oTipoProducto,
        setTipoProducto,
        limpiarTipoProducto,
    };
};

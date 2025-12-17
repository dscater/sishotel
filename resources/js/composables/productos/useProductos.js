import { onMounted, ref } from "vue";

const oProducto = ref({
    id: 0,
    nombre: "",
    descripcion: "",
    precio: "",
    tipo_producto_id: "",
    imagen: null,
    _method: "POST",
});

export const useProductos = () => {
    const setProducto = (item = null, ver = false) => {
        if (item) {
            oProducto.value.id = item.id;
            oProducto.value.nombre = item.nombre;
            oProducto.value.descripcion = item.descripcion;
            oProducto.value.precio = item.precio;
            oProducto.value.tipo_producto_id = item.tipo_producto_id;
            oProducto.value.imagen = null;
            oProducto.value._method = "PUT";
            return oProducto;
        }
        return false;
    };

    const limpiarProducto = () => {
        oProducto.value.id = 0;
        oProducto.value.nombre = "";
        oProducto.value.descripcion = "";
        oProducto.value.precio = 0;
        oProducto.value.tipo_producto_id = "";
        oProducto.value.imagen = null;
        oProducto.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oProducto,
        setProducto,
        limpiarProducto,
    };
};

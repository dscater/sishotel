import { onMounted, ref } from "vue";

const oCaja = ref({
    id: 0,
    nombre: "",
    paterno: "",
    materno: "",
    ci: "",
    ci_exp: "",
    dir: "",
    fono: "",
    fecha_nac: "",
    correo: "",
    edad: "",
    nacionalidad: "",
    pais: "",
    respuesta: "",
    _method: "POST",
});

export const useCajas = () => {
    const setCaja = (item = null, ver = false) => {
        if (item) {
            oCaja.value.id = item.id;
            oCaja.value.nombre = item.nombre;
            oCaja.value.paterno = item.paterno;
            oCaja.value.materno = item.materno;
            oCaja.value.ci = item.ci;
            oCaja.value.ci_exp = item.ci_exp;
            oCaja.value.dir = item.dir;
            oCaja.value.fono = item.fono;
            oCaja.value.fecha_nac = item.fecha_nac;
            oCaja.value.correo = item.correo;
            oCaja.value.edad = item.edad;
            oCaja.value.nacionalidad = item.nacionalidad;
            oCaja.value.pais = item.pais;
            oCaja.value._method = "PUT";
            return oCaja;
        }
        return false;
    };

    const limpiarCaja = () => {
        oCaja.value.id = 0;
        oCaja.value.nombre = "";
        oCaja.value.paterno = "";
        oCaja.value.materno = "";
        oCaja.value.ci = "";
        oCaja.value.ci_exp = "";
        oCaja.value.dir = "";
        oCaja.value.fono = "";
        oCaja.value.fecha_nac = "";
        oCaja.value.correo = "";
        oCaja.value.edad = "";
        oCaja.value.nacionalidad = "";
        oCaja.value.pais = "";
        oCaja.value.respuesta = "";
        oCaja.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oCaja,
        setCaja,
        limpiarCaja,
    };
};

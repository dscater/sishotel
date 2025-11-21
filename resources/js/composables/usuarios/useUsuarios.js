import { onMounted, ref } from "vue";

const oUsuario = ref({
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
    persona_id: "",
    usuario: "",
    password: "",
    acceso: "" + 0,
    tipo: "",
    foto: "",
    _method: "POST",
});

export const useUsuarios = () => {
    const setUsuario = (item = null, ver = false) => {
        if (item) {
            oUsuario.value.id = item.id;
            oUsuario.value.nombre = item.persona.nombre;
            oUsuario.value.paterno = item.persona.paterno;
            oUsuario.value.materno = item.persona.materno;
            oUsuario.value.ci = item.persona.ci;
            oUsuario.value.ci_exp = item.persona.ci_exp;
            oUsuario.value.dir = item.persona.dir;
            oUsuario.value.fono = item.persona.fono;
            oUsuario.value.fecha_nac = item.persona.fecha_nac;
            oUsuario.value.correo = item.persona.correo;
            oUsuario.value.persona_id = item.persona_id;
            oUsuario.value.usuario = item.usuario;
            oUsuario.value.password = item.password;
            oUsuario.value.acceso = "" + item.acceso;
            oUsuario.value.tipo = item.tipo;
            oUsuario.value.foto = "";
            oUsuario.value.persona = item.persona;
            oUsuario.value._method = "PUT";
            return oUsuario;
        }
        return false;
    };

    const limpiarUsuario = () => {
        oUsuario.value.id = 0;
        oUsuario.value.nombre = "";
        oUsuario.value.paterno = "";
        oUsuario.value.materno = "";
        oUsuario.value.ci = "";
        oUsuario.value.ci_exp = "";
        oUsuario.value.dir = "";
        oUsuario.value.fono = "";
        oUsuario.value.fecha_nac = "";
        oUsuario.value.correo = "";
        oUsuario.value.persona_id = "";
        oUsuario.value.usuario = "";
        oUsuario.value.password = "";
        oUsuario.value.acceso = "" + 0;
        oUsuario.value.tipo = "";
        oUsuario.value.foto = "";
        oUsuario._method = "POST";
    };

    onMounted(() => {});

    return {
        oUsuario,
        setUsuario,
        limpiarUsuario,
    };
};

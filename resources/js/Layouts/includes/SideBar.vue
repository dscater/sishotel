<script setup>
import { onMounted, onUnmounted, ref, nextTick, watch } from "vue";
import { Link, router, usePage } from "@inertiajs/vue3";
import ItemMenu from "@/Components/ItemMenu.vue";
import { useSideBar } from "@/composables/useSidebar.js";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useConfiguracionStore } from "@/stores/configuracion/configuracionStore";
import { verificaImagen } from "@/composables/useLoadings/verificaImagen";
import { useUser } from "@/composables/useUser";
const { getUser } = useUser();

const { props: props_page } = usePage();
const { closeSidebar, toggleSubMenuELem } = useSideBar();
const configuracionStore = useConfiguracionStore();
const appStore = useAppStore();
const usuario = ref(null);
const toggleSubMenu = (e) => {
    e.stopPropagation();
    const elem = e.currentTarget;
    if (
        elem.classList.contains("menu-is-opening") &&
        elem.classList.contains("menu-open")
    ) {
        elem.classList.remove("menu-is-opening");
        elem.classList.remove("menu-open");
        toggleSubMenuELem(elem, false);
    } else {
        elem.classList.add("menu-is-opening");
        elem.classList.add("menu-open");
        toggleSubMenuELem(elem, true);
    }
};

const route_current = ref("");
router.on("navigate", (event) => {
    route_current.value = route().current();
    closeSidebar();
});

const user_logeado = ref({
    permisos: [],
});
onMounted(() => {
    configuracionStore.initConfiguracion();
    usuario.value = appStore.getUsuario;
    // Selecciona el elemento del widget
    var sidebarSearchElement = $('[data-widget="sidebar-search"]');
    // Configura manualmente el texto de "no encontrado"
    sidebarSearchElement.data("notFoundText", "Sin resultados");

    if (props_page.auth) {
        user_logeado.value = props_page.auth?.user;
        // console.log(user_logeado.value.permisos);
    }
});

const loadingLogo = ref(true);

watch(
    () => configuracionStore.oConfiguracion.url_logo,
    async (newUrl) => {
        if (!newUrl) return;
        try {
            const resp = await verificaImagen(newUrl);
            loadingLogo.value = !resp;
        } catch (e) {
            loadingLogo.value = true;
        }
    },
    { immediate: true } // también dispara la primera vez si ya tiene valor
);

onUnmounted(() => {});
</script>
<template>
    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary bg2 elevation-4">
        <!-- Brand Logo -->
        <a :href="route('inicio')" class="brand-link bg1">
            <el-skeleton class="brand-image" animated :loading="loadingLogo">
                <template #template>
                    <el-skeleton-item
                        variant="circle"
                        class="brand-image img-circle elevation-3"
                        style="width: 40px"
                    />
                </template>
                <template #default>
                    <img
                        :src="configuracionStore.oConfiguracion.url_logo"
                        alt="Logo"
                        class="brand-image img-circle elevation-3"
                        loading="lazy"
                        v-if="!loadingLogo"
                    />
                </template>
            </el-skeleton>

            <span
                class="brand-text font-weight-light title_Chau_Philomene_One"
                >{{ configuracionStore.oConfiguracion.nombre_sistema }}</span
            >
        </a>

        <!-- Sidebar -->
        <div class="sidebar p-0">
            <!-- Sidebar user panel (optional) -->
            <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                <div class="image">
                    <img
                        :src="usuario?.url_foto"
                        class="img-circle elevation-2"
                        alt="User Image"
                        v-if="!loadingLogo"
                    />
                </div>
                <div class="info">
                    <Link :href="route('profile.edit')" class="d-block">{{
                        usuario?.full_name
                    }}</Link>
                </div>
            </div>

            <!-- Sidebar Menu -->
            <nav class="mt-2">
                <ul
                    class="nav nav-pills nav-sidebar flex-column"
                    data-widget="treeview"
                    role="menu"
                    data-accordion="false"
                >
                    <ItemMenu
                        :label="'Inicio'"
                        :ruta="'inicio'"
                        :icon="'fa fa-home'"
                    ></ItemMenu>
                    <li class="nav-header font-weight-bold bg3">OPERACIONES</li>
                    <ItemMenu
                        v-if="
                            user_logeado.permisos == '*' ||
                            user_logeado.permisos.includes('registros.index')
                        "
                        :label="'Recepción'"
                        :ruta="'registros.index'"
                        :icon="'fa fa-sign-in-alt'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            user_logeado.permisos == '*' ||
                            user_logeado.permisos.includes(
                                'registros.historial'
                            )
                        "
                        :label="'Historial de Registros'"
                        :ruta="'registros.historial'"
                        :icon="'fa fa-list'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            user_logeado.permisos == '*' ||
                            user_logeado.permisos.includes('registros.reservas')
                        "
                        :label="'Listado de Reservas'"
                        :ruta="'registros.reservas'"
                        :icon="'fa fa-list'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            user_logeado.permisos == '*' ||
                            user_logeado.permisos.includes('cajas.cierre_caja')
                        "
                        :label="'Cierre de caja'"
                        :ruta="'cajas.cierre_caja'"
                        :icon="'fa fa-cash-register'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            user_logeado.permisos == '*' ||
                            user_logeado.permisos.includes('clientes.inedx')
                        "
                        :label="'Clientes'"
                        :ruta="'clientes.index'"
                        :icon="'fa fa-user-friends'"
                    ></ItemMenu>
                    <li class="nav-header font-weight-bold bg3">
                        ADMINISTRACIÓN
                    </li>
                    <li class="nav-item">
                        <a
                            href="#"
                            class="nav-link sub-menu"
                            :class="[
                                route_current == 'productos.index' ||
                                route_current == 'ingreso_productos.index' ||
                                route_current == 'egreso_productos.index' ||
                                route_current == 'tipo_productos.index'
                                    ? 'active menu-is-opening menu-open'
                                    : '',
                            ]"
                            @click.stop="toggleSubMenu($event)"
                        >
                            <i class="nav-icon fas fa-box"></i>
                            <p>
                                Productos/Servicios
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <ItemMenu
                                v-if="
                                    user_logeado.permisos == '*' ||
                                    user_logeado.permisos.includes(
                                        'productos.index'
                                    )
                                "
                                :label="'Listado Productos/Servicios'"
                                :ruta="'productos.index'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
                                v-if="
                                    user_logeado.permisos == '*' ||
                                    user_logeado.permisos.includes(
                                        'ingreso_productos.index'
                                    )
                                "
                                :label="'Ingreso de Productos'"
                                :ruta="'ingreso_productos.index'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
                                v-if="
                                    user_logeado.permisos == '*' ||
                                    user_logeado.permisos.includes(
                                        'egreso_productos.index'
                                    )
                                "
                                :label="'Salida de Productos'"
                                :ruta="'egreso_productos.index'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
                                v-if="
                                    user_logeado.permisos == '*' ||
                                    user_logeado.permisos.includes(
                                        'tipo_productos.index'
                                    )
                                "
                                :label="'Tipos de Productos'"
                                :ruta="'tipo_productos.index'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                        </ul>
                    </li>
                    <li
                        class="nav-item"
                        v-if="
                            user_logeado.permisos == '*' ||
                            user_logeado.permisos.includes(
                                'habitacions.index'
                            ) ||
                            user_logeado.permisos.includes(
                                'tipo_habitacions.index'
                            )
                        "
                    >
                        <a
                            href="#"
                            class="nav-link sub-menu"
                            :class="[
                                route_current == 'habitacions.index' ||
                                route_current == 'tipo_habitacions.index'
                                    ? 'active menu-is-opening menu-open'
                                    : '',
                            ]"
                            @click.stop="toggleSubMenu($event)"
                        >
                            <i class="nav-icon fas fa-list"></i>
                            <p>
                                Habitaciones
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <ItemMenu
                                v-if="
                                    user_logeado.permisos == '*' ||
                                    user_logeado.permisos.includes(
                                        'habitacions.index'
                                    )
                                "
                                :label="'Habitaciones'"
                                :ruta="'habitacions.index'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
                                v-if="
                                    user_logeado.permisos == '*' ||
                                    user_logeado.permisos.includes(
                                        'tipo_habitacions.index'
                                    )
                                "
                                :label="'Tipo de Habitaciones'"
                                :ruta="'tipo_habitacions.index'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a
                            href="#"
                            class="nav-link sub-menu"
                            :class="[
                                route_current == 'monedas.index' ||
                                route_current == 'tipo_cambios.index'
                                    ? 'active menu-is-opening menu-open'
                                    : '',
                            ]"
                            @click.stop="toggleSubMenu($event)"
                        >
                            <i class="nav-icon fa fa-dollar-sign"></i>
                            <p>
                                Monedas
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <ItemMenu
                                v-if="
                                    user_logeado.permisos == '*' ||
                                    user_logeado.permisos.includes(
                                        'monedas.index'
                                    )
                                "
                                :label="'Monedas'"
                                :ruta="'monedas.index'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
                                v-if="
                                    user_logeado.permisos == '*' ||
                                    user_logeado.permisos.includes(
                                        'tipo_cambios.index'
                                    )
                                "
                                :label="'Tipo de Cambio'"
                                :ruta="'tipo_cambios.index'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                        </ul>
                    </li>
                    <ItemMenu
                        v-if="
                            user_logeado.permisos == '*' ||
                            user_logeado.permisos.includes('cajas.index')
                        "
                        :label="'Caja'"
                        :ruta="'cajas.index'"
                        :icon="'fa fa-cash-register'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            user_logeado.permisos == '*' ||
                            user_logeado.permisos.includes('usuarios.index')
                        "
                        :label="'Usuarios'"
                        :ruta="'usuarios.index'"
                        :icon="'fa fa-users'"
                    ></ItemMenu>
                    <li class="nav-header font-weight-bold bg3">REPORTES</li>
                    <li class="nav-item">
                        <a
                            href="#"
                            class="nav-link sub-menu"
                            :class="[
                                route_current == 'reportes.usuarios' ||
                                route_current == 'reportes.pagos'
                                    ? 'active menu-is-opening menu-open'
                                    : '',
                            ]"
                            @click.stop="toggleSubMenu($event)"
                        >
                            <i class="nav-icon fas fa-file-alt"></i>
                            <p>
                                Reportes
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <ItemMenu
                                v-if="
                                    user_logeado.permisos == '*' ||
                                    user_logeado.permisos.includes(
                                        'reportes.usuarios'
                                    )
                                "
                                :label="'Usuarios'"
                                :ruta="'reportes.usuarios'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
                                v-if="
                                    user_logeado.permisos == '*' ||
                                    user_logeado.permisos.includes(
                                        'reportes.kardex_productos'
                                    )
                                "
                                :label="'Kardex de Productos'"
                                :ruta="'reportes.kardex_productos'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
                                v-if="
                                    user_logeado.permisos == '*' ||
                                    user_logeado.permisos.includes(
                                        'reportes.productos'
                                    )
                                "
                                :label="'Productos'"
                                :ruta="'reportes.productos'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
                                v-if="
                                    user_logeado.permisos == '*' ||
                                    user_logeado.permisos.includes(
                                        'reportes.clientes'
                                    )
                                "
                                :label="'Clientes'"
                                :ruta="'reportes.clientes'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
                                v-if="
                                    user_logeado.permisos == '*' ||
                                    user_logeado.permisos.includes(
                                        'reportes.registros'
                                    )
                                "
                                :label="'Registros'"
                                :ruta="'reportes.registros'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                        </ul>
                    </li>
                    <li class="nav-header font-weight-bold bg3">OTROS</li>
                    <ItemMenu
                        v-if="
                            user_logeado.permisos == '*' ||
                            user_logeado.permisos.includes(
                                'configuracions.index'
                            )
                        "
                        :label="'Configuración Sistema'"
                        :ruta="'configuracions.index'"
                        :icon="'fa fa-cog'"
                    ></ItemMenu>
                    <ItemMenu
                        :label="'Perfil'"
                        :ruta="'profile.edit'"
                        :icon="'fa fa-id-card'"
                    ></ItemMenu>
                    <ItemMenu
                        :label="'Salir'"
                        :ruta="'logout'"
                        :method="'POST'"
                        :icon="'fa fa-power-off'"
                    ></ItemMenu>
                </ul>
            </nav>
            <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
    </aside>
</template>
<style scoped></style>

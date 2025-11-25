<script setup>
import { onMounted, onUnmounted, ref, nextTick, watch } from "vue";
import { router } from "@inertiajs/vue3";
import ItemMenu from "@/Components/ItemMenu.vue";
import { useSideBar } from "@/composables/useSidebar.js";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useConfiguracionStore } from "@/stores/configuracion/configuracionStore";
import { verificaImagen } from "@/composables/useLoadings/verificaImagen";

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

onMounted(() => {
    configuracionStore.initConfiguracion();
    usuario.value = appStore.getUsuario;
    // Selecciona el elemento del widget
    var sidebarSearchElement = $('[data-widget="sidebar-search"]');
    // Configura manualmente el texto de "no encontrado"
    sidebarSearchElement.data("notFoundText", "Sin resultados");
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
                    <a href="#" class="d-block">{{ usuario?.full_name }}</a>
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
                    <li class="nav-header font-weight-bold bg3">RECEPCIÓN</li>
                    <ItemMenu
                        :label="'Check-In'"
                        :ruta="'registros.checkin'"
                        :icon="'fa fa-sign-in-alt'"
                    ></ItemMenu>
                    <ItemMenu
                        :label="'Check-Out'"
                        :ruta="'clientes.index'"
                        :icon="'fa fa-sign-out-alt'"
                    ></ItemMenu>
                    <ItemMenu
                        :label="'Cierre de caja'"
                        :ruta="'clientes.index'"
                        :icon="'fa fa-cash-register'"
                    ></ItemMenu>
                    <li class="nav-header font-weight-bold bg3">RESERVAS</li>
                    <ItemMenu
                        :label="'Crear reserva'"
                        :ruta="'clientes.index'"
                        :icon="'fa fa-calendar-plus'"
                    ></ItemMenu>
                    <ItemMenu
                        :label="'Listado reservas'"
                        :ruta="'clientes.index'"
                        :icon="'fa fa-list'"
                    ></ItemMenu>
                    <li class="nav-header font-weight-bold bg3">
                        ADMINISTRACIÓN
                    </li>
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
                            <i class="nav-icon fas fa-box"></i>
                            <p>
                                Productos
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <ItemMenu
                                :label="'Listado Productos'"
                                :ruta="'reportes.usuarios'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
                                :label="'Ingreso de Productos'"
                                :ruta="'reportes.usuarios'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
                                :label="'Salida de Productos'"
                                :ruta="'reportes.usuarios'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                        </ul>
                    </li>
                    <li class="nav-item">
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
                                :label="'Habitaciones'"
                                :ruta="'habitacions.index'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
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
                                :label="'Monedas'"
                                :ruta="'monedas.index'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
                                :label="'Tipo de Cambio'"
                                :ruta="'tipo_cambios.index'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                        </ul>
                    </li>
                    <ItemMenu
                        :label="'Caja'"
                        :ruta="'clientes.index'"
                        :icon="'fa fa-cash-register'"
                    ></ItemMenu>
                    <ItemMenu
                        :label="'Clientes'"
                        :ruta="'clientes.index'"
                        :icon="'fa fa-user-friends'"
                    ></ItemMenu>
                    <ItemMenu
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
                                :label="'Usuarios'"
                                :ruta="'reportes.usuarios'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                        </ul>
                    </li>
                    <li class="nav-header font-weight-bold bg3">OTROS</li>
                    <ItemMenu
                        :label="'Configuración Sistema'"
                        :ruta="'configuracions.index'"
                        :icon="'fa fa-cog'"
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

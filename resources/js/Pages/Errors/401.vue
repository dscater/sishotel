<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { onMounted } from "vue";
const appStore = useAppStore();

const { props: props_page } = usePage();
onMounted(async () => {
    appStore.stopLoading();
});
</script>
<template>
    <Head title="Acceso no autorizado"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Acceso No Autorizado</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Acceso No Autorizado
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <div class="row">
            <div class="col-md-12">
                <!-- BEGIN card -->
                <div class="card card-inverse">
                    <!-- BEGIN card-body -->
                    <div class="card-body">
                        <h4>No tienes autorización para ver esta página</h4>
                    </div>
                    <!-- END card-body -->
                </div>
                <!-- END card -->
            </div>
        </div>
    </Content>
</template>

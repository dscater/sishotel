<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('servicio_detalles', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('registro_servicio_id');
            $table->unsignedBigInteger('registro_id');
            $table->unsignedBigInteger('producto_id')->nullable();
            $table->string("tipo"); // INTERNO, EXTERNO
            $table->string("descripcion_externo")->nullable();
            $table->integer('cantidad');
            $table->decimal('precio_unitario', 24, 2);
            $table->decimal('total', 24, 2);
            $table->timestamps();

            $table->foreign('registro_servicio_id')->references('id')->on('registro_servicios');
            $table->foreign('registro_id')->references('id')->on('registros');
            $table->foreign('producto_id')->references('id')->on('productos');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('servicio_detalles');
    }
};

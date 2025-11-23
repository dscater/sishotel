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
        Schema::create('registro_servicios', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('registro_id');
            $table->decimal('total', 24, 2);
            $table->decimal("cancelado", 24, 2)->default(0);
            $table->decimal("saldo", 24, 2);
            $table->unsignedBigInteger('moneda_id');
            $table->decimal('total_tc', 24, 2)->nullable()->nullable()->default(0);
            $table->decimal("cancelado_tc", 24, 2)->default(0);
            $table->decimal("saldo_tc", 24, 2);
            $table->unsignedBigInteger('moneda_id_tc')->nullable();
            $table->unsignedBigInteger('tipo_cambio_id')->nullable();
            $table->timestamps();

            $table->foreign('registro_id')->references('id')->on('registros');
            $table->foreign('moneda_id')->references('id')->on('monedas');
            $table->foreign('moneda_id_tc')->references('id')->on('monedas');
            $table->foreign('tipo_cambio_id')->references('id')->on('tipo_cambios');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('registro_servicios');
    }
};

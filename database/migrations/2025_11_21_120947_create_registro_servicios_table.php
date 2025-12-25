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
            $table->string("tipo"); // PRODUCTO/SERVICIO, HOSPEDAJE
            $table->double('cantidad', 8, 2);
            $table->decimal('total', 24, 2);
            $table->decimal("cancelado", 24, 2)->default(0);
            $table->decimal("saldo", 24, 2);
            $table->unsignedBigInteger('moneda_id');
            $table->integer("tc")->default(0);
            $table->decimal('total_tc', 24, 2)->default(0)->nullable();
            $table->decimal("cancelado_tc", 24, 2)->default(0)->nullable();
            $table->decimal("saldo_tc", 24, 2)->nullable();
            $table->unsignedBigInteger('moneda_id_tc')->nullable();
            $table->unsignedBigInteger('tipo_cambio_id')->nullable();
            $table->decimal('valor_tc')->nullable();
            $table->string("efectivo_banco");
            $table->date("fecha")->nullable();
            $table->time("hora")->nullable();
            $table->unsignedBigInteger("user_id");
            $table->timestamps();

            $table->foreign('registro_id')->references('id')->on('registros');
            $table->foreign('moneda_id')->references('id')->on('monedas');
            $table->foreign('moneda_id_tc')->references('id')->on('monedas');
            $table->foreign('tipo_cambio_id')->references('id')->on('tipo_cambios');
            $table->foreign('user_id')->references('id')->on('users');
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

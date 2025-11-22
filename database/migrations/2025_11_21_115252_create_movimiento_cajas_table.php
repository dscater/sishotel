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
        Schema::create('movimiento_cajas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('caja_id');
            $table->unsignedBigInteger('modelo_id')->nullable();
            $table->string('modelo')->nullable();
            $table->decimal('monto', 24, 2);
            $table->unsignedBigInteger('moneda_id');
            $table->decimal("monto_tc", 24, 2)->nullable()->default(0);
            $table->unsignedBigInteger('moneda_id_tc')->nullable();
            $table->string('tipo'); // INGRESO, EGRESO
            $table->string("efectivo_banco"); // EFECTIVO, BANCO
            $table->string('descripcion')->nullable();
            $table->date('fecha_movimiento');
            $table->time('hora_movimiento');
            $table->unsignedBigInteger('user_id');
            $table->timestamps();
            $table->foreign('caja_id')->references('id')->on('cajas');
            $table->foreign('user_id')->references('id')->on('users');
            $table->foreign('moneda_id')->references('id')->on('monedas');
            $table->foreign('moneda_id_tc')->references('id')->on('monedas');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('movimiento_cajas');
    }
};

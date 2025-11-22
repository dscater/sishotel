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
        Schema::create('cajas', function (Blueprint $table) {
            $table->id();
            $table->decimal('monto_inicial', 24, 2);
            $table->decimal('monto_final', 24, 2)->nullable();
            $table->decimal("monto_efectivo_inicial", 24, 2);
            $table->decimal("monto_efectivo_final", 24, 2)->nullable();
            $table->decimal("monto_banco_inicial", 24, 2);
            $table->decimal("monto_banco_final", 24, 2)->nullable();
            $table->date('fecha_apertura');
            $table->time('hora_apertura');
            $table->date('fecha_cierre')->nullable();
            $table->time('hora_cierre')->nullable();
            $table->integer('status')->default(1); // 1 ABIERTA, 0 CERRADA
            $table->unsignedBigInteger('user_id');
            $table->timestamps();
            $table->foreign('user_id')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cajas');
    }
};

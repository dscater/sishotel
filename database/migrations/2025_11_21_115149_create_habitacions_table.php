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
        Schema::create('habitacions', function (Blueprint $table) {
            $table->id();
            $table->string('numero_habitacion')->unique();
            $table->unsignedBigInteger('tipo_habitacion_id');
            $table->decimal('precio_actual', 24, 2);
            $table->decimal('precio_temp', 24, 2)->nullable();
            $table->integer("estado")->default(0); // 0: disponible, 1: ocupado, 2: mantenimiento
            $table->integer("status")->default(1);
            $table->timestamps();
            $table->foreign('tipo_habitacion_id')->references('id')->on('tipo_habitacions');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('habitacions');
    }
};

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
        Schema::create('transferencias', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("registro_id");
            $table->unsignedBigInteger("habitacion_id");
            $table->unsignedBigInteger("habitacion_destino_id");
            $table->text("motivo");
            $table->date("fecha");
            $table->timestamps();

            $table->foreign("registro_id")->on("registros")->references("id");
            $table->foreign("habitacion_id")->on("habitacions")->references("id");
            $table->foreign("habitacion_destino_id")->on("habitacions")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transferencias');
    }
};

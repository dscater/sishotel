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
        Schema::create('habitacion_fotos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("habitacion_id");
            $table->string("foto");
            $table->timestamps();

            $table->foreign("habitacion_id")->references("id")->on("habitacions")->onDelete("cascade");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('habitacion_fotos');
    }
};

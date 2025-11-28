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
        Schema::create('clientes', function (Blueprint $table) {
            $table->id();
            $table->string("nombre", 255);
            $table->string("paterno", 255);
            $table->string("materno", 255)->nullable();
            $table->string("ci", 255)->nullable();
            $table->string("ci_exp", 255)->nullable();
            $table->string("dir", 800)->nullable();
            $table->string("fono", 255)->nullable();
            $table->date("fecha_nac")->nullable();
            $table->string("correo", 255)->nullable();
            $table->integer("edad")->nullable();
            $table->string("nacionalidad")->nullable();
            $table->string("pais", 255)->nullable();
            $table->unsignedBigInteger("user_id");
            $table->integer("status")->default(1);
            $table->timestamps();

            $table->foreign("user_id")->on("users")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('clientes');
    }
};

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
        Schema::create('registros', function (Blueprint $table) {
            /**
             * dias estancia puede ser null para que el registro sea INDEFINIDO
             * en caso de que si se indique los días se Calcula Automaticamente la fecha de salida
             * en caso de que se pasen esos días se OBTENDRAN los DÍAS EXTRA y se registrara como SERVICIO (días extra)
             */
            $table->id();
            $table->unsignedBigInteger('habitacion_id');
            $table->unsignedBigInteger('cliente_id');
            $table->integer('desayuno')->default(0); //0:NO, 1:SI
            $table->date('fecha_entrada');
            $table->time("hora_entrada");
            $table->integer("dias_estadia")->nullable()->default(0);
            $table->date('fecha_salida')->nullable();
            $table->time("hora_salida")->nullable();
            $table->time("hora_salida_reg")->nullable();
            $table->decimal('cd', 24, 2);
            $table->decimal('total', 24, 2);
            $table->decimal('adelanto', 24, 2)->nullable()->default(0);
            $table->decimal("saldo", 24, 2)->nullable()->default(0);
            $table->decimal('garantia', 24, 2)->nullable()->default(0);
            $table->unsignedBigInteger('moneda_id');
            $table->integer('tc')->default(0);  //0: SIN TIPO DE CAMBIO, 1: CON TIPO DE CAMBIO
            $table->decimal('cd_tc', 24, 2)->nullable();  //COSTO DIARIO CON TIPO DE CAMBIO
            $table->decimal('total_tc', 24, 2)->nullable()->default(0);
            $table->decimal('adelanto_tc', 24, 2)->nullable()->default(0);
            $table->decimal('saldo_tc', 24, 2)->nullable()->default(0);
            $table->decimal('garantia_tc', 24, 2)->nullable()->default(0);
            $table->unsignedBigInteger('moneda_id_tc')->nullable();
            $table->unsignedBigInteger('tipo_cambio_id')->nullable();
            $table->text("motivo_salida")->nullable();
            $table->string("tipo")->default("NORMAL"); // RESERVA, NORMAL
            $table->date("fecha_reserva")->nullable();
            $table->time("hora_reserva")->nullable();
            $table->bigInteger("nro_reserva")->nullable();
            $table->string("cod_reserva")->nullable();
            $table->string("tipo_reserva")->nullable(); // DIARIA, MENSUAL, ANUAL
            $table->integer("status")->default(1);
            $table->unsignedBigInteger('user_id')->nullable();
            $table->timestamps();

            $table->foreign('habitacion_id')->references('id')->on('habitacions');
            $table->foreign('cliente_id')->references('id')->on('clientes');
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
        Schema::dropIfExists('registros');
    }
};

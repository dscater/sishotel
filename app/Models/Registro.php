<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Registro extends Model
{
    use HasFactory;

    protected $fillable = [
        "habitacion_id",
        "cliente_id",
        "desayuno",
        "fecha_entrada",
        "hora_entrada",
        "dias_estadia",
        "fecha_salida",
        "hora_salida",
        "hora_salida_reg",
        "cd",
        "total",
        "adelanto",
        "saldo",
        "garantia",
        "desc_garantia",
        "moneda_id",
        "tc",
        "cd_tc",
        "total_tc",
        "adelanto_tc",
        "saldo_tc",
        "garantia_tc",
        "moneda_id_tc",
        "tipo_cambio_id",
        "valor_tc",
        "motivo_salida",
        "tipo",
        "fecha_reserva",
        "hora_reserva",
        "nro_reserva",
        "cod_reserva",
        "tipo_reserva",
        "dev_garantia",
        "estado", // 0:FINALIZADO, 1:ACTIVO, 2: RESERVA PENDIENTE
        "status",
        "user_id",
    ];

    protected $appends = ["fecha_entrada_t", "fecha_salida_t", "fecha_hora_entrada", "fecha_hora_salida", "fecha_reserva_t", "fecha_hora_reserva", "editable", "hoy"];


    public function getHoyAttribute()
    {
        $hoy = Carbon::now("America/La_Paz");

        if ($this->fecha_entrada == $hoy->toDateString()) {
            return true;
        }

        return false;
    }

    public function getEditableAttribute()
    {
        $hoy = Carbon::now("America/La_Paz");

        if ($this->fecha_entrada < $hoy->toDateString()) {
            return false;
        }

        return true;
    }

    public function getFechaHoraReservaAttribute()
    {
        return date("d/m/Y H:i:s", strtotime($this->fecha_reserva . ' ' . $this->hora_reserva));
    }

    public function getFechaReservaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_reserva));
    }

    public function getFechaHoraSalidaAttribute()
    {
        return date("d/m/Y H:i:s", strtotime($this->fecha_salida . ' ' . $this->hora_salida));
    }

    public function getFechaHoraEntradaAttribute()
    {
        return date("d/m/Y H:i:s", strtotime($this->fecha_entrada . ' ' . $this->hora_entrada));
    }

    public function getFechaEntradaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_entrada));
    }
    public function getFechaSalidaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_salida));
    }

    public function habitacion()
    {
        return $this->belongsTo(Habitacion::class);
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class);
    }

    public function moneda()
    {
        return $this->belongsTo(Moneda::class);
    }

    public function moneda_tc()
    {
        return $this->belongsTo(Moneda::class, "moneda_id_tc");
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function registro_servicios()
    {
        return $this->hasMany(RegistroServicio::class);
    }

    public function transferencias()
    {
        return $this->hasMany(Transferencia::class, "registro_id");
    }
}

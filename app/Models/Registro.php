<?php

namespace App\Models;

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
        "moneda_id",
        "tc",
        "cd_tc",
        "total_tc",
        "adelanto_tc",
        "saldo_tc",
        "garantia_tc",
        "moneda_id_tc",
        "motivo_salida",
        "tipo",
        "fecha_reserva",
        "hora_reserva",
        "nro_reserva",
        "cod_reserva",
        "tipo_reserva",
        "dev_garantia",
        "status",
        "user_id",
    ];

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
        return $this->belongsTo(Moneda::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function servicios()
    {
        return $this->hasMany(Servicio::class);
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MovimientoCaja extends Model
{
    use HasFactory;

    protected $fillable = [
        "caja_id",
        "modelo_id",
        "modelo",
        "monto",
        "moneda_id",
        "tc",
        "monto_tc",
        "moneda_id_tc",
        "tipo_cambio_id",
        "valor_tc",
        "tipo", // INGRESO, EGRESO
        "efectivo_banco", // EFECTIVO, BANCO
        "descripcion",
        "fecha_movimiento",
        "hora_movimiento",
        "user_id"
    ];

    protected $appends = ["fecha_movimiento_t", "fecha_hora"];

    public function getFechaMovimientoTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_movimiento));
    }

    public function getFechaHoraAttribute()
    {
        return date("d/m/Y H:i:s", strtotime($this->fecha_movimiento . ' ' . $this->hora_movimiento));
    }

    public function caja()
    {
        return $this->belongsTo(Caja::class);
    }
}

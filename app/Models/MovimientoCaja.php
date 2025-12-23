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
        "tipo", // INGRESO, EGRESO
        "efectivo_banco", // EFECTIVO, BANCO
        "descripcion",
        "fecha_movimiento",
        "hora_movimiento",
        "user_id"
    ];

    public function caja()
    {
        return $this->belongsTo(Caja::class);
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RegistroServicio extends Model
{
    use HasFactory;

    protected $fillable = [
        "registro_id",
        "total",
        "cancelado",
        "saldo",
        "moneda_id",
        "total_tc",
        "cancelado_tc",
        "saldo_tc",
        "moneda_id_tc",
        "tipo_cambio_id",
        "user_id"
    ];

    public function registro()
    {
        return $this->belongsTo(Registro::class);
    }

    public function moneda()
    {
        return $this->belongsTo(Moneda::class);
    }

    public function moneda_tc()
    {
        return $this->belongsTo(Moneda::class, 'moneda_id_tc');
    }

    public function tipo_cambio()
    {
        return $this->belongsTo(TipoCambio::class, 'tipo_cambio_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function servicio_detalles()
    {
        return $this->hasMany(ServicioDetalle::class, 'registro_servicio_id');
    }
}

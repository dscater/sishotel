<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ServicioPago extends Model
{
    use HasFactory;

    protected $fillable = [
        "registro_id",
        "registro_servicio_id",
        "monto",
        "moneda_id",
        "tc",
        "monto_tc",
        "moneda_id_tc",
        "tipo_cambio_id",
        "efectivo_banco",
        "descripcion",
        "fecha",
        "hora",
        "user_id"
    ];

    public function registro()
    {
        return $this->belongsTo(Registro::class);
    }

    public function registro_servicio()
    {
        return $this->belongsTo(RegistroServicio::class);
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
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ServicioDetalle extends Model
{
    use HasFactory;

    protected $fillable = [
        "registro_servicio_id",
        "registro_id",
        "producto_id",
        "tipo",
        "descripcion_externo",
        "cantidad",
        "precio_unitario",
        "total",
    ];

    public function registro_servicio()
    {
        return $this->belongsTo(RegistroServicio::class);
    }

    public function registro()
    {
        return $this->belongsTo(registro::class);
    }

    public function producto()
    {
        return $this->belongsTo(Producto::class);
    }
}

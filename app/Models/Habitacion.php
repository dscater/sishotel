<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Habitacion extends Model
{
    use HasFactory;

    protected $fillable = [
        "numero_habitacion",
        "tipo_habitacion_id",
        "piso",
        "precio_actual",
        "precio_temp",
        "estado",
        "status",
    ];
}

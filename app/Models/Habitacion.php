<?php

namespace App\Models;

use App\Http\Controllers\EstadoHabitacionController;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Habitacion extends Model
{
    use HasFactory;

    protected $fillable = [
        "numero_habitacion",
        "tipo_habitacion_id",
        "piso",
        "capacidad",
        "precio",
        "precio_temp",
        "estado", // 0: disponible, 1: ocupado, 2: mantenimiento, 3: en limpieza, 4: saliente
        "status",
    ];

    protected $appends = ["estado_t"];

    public function getEstadoTAttribute()
    {
        $estadoHabitacionController = new EstadoHabitacionController();
        return $estadoHabitacionController->getEstadoHabitacionText($this->estado);
    }

    public function habitacion_fotos()
    {
        return $this->hasMany(HabitacionFoto::class);
    }

    public function tipo_habitacion()
    {
        return $this->belongsTo(TipoHabitacion::class);
    }
}

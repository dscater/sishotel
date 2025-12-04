<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transferencia extends Model
{
    use HasFactory;

    protected $fillable = [
        "registro_id",
        "habitacion_id",
        "habitacion_destino_id",
        "motivo",
        "fecha"
    ];

    public function registro()
    {
        return $this->belongsTo(Registro::class, 'registro_id');
    }
    public function habitacion()
    {
        return $this->belongsTo(Habitacion::class, 'habitacion_id');
    }
    public function habitacion_destino()
    {
        return $this->belongsTo(Habitacion::class, 'habitacion_destino_id');
    }
}

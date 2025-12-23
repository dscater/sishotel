<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Caja extends Model
{
    use HasFactory;

    protected $fillable = [
        "monto_inicial",
        "monto_final",
        "monto_efectivo_inicial",
        "monto_efectivo_final",
        "monto_banco_inicial",
        "monto_banco_final",
        "fecha_apertura",
        "hora_apertura",
        "fecha_cierre",
        "hora_cierre",
        "status",
        "user_id",
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}

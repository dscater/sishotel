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

    protected $appends = ["fecha_apertura_t", "fecha_cierre_t", "fecha_hora_apertura", "fecha_hora_cierre"];

    public function getFechaHoraAperturaAttribute()
    {
        return date("d/m/Y H:i:s", strtotime($this->fecha_apertura . ' ' . $this->hora_apertura));
    }

    public function getFechaHoraCierreAttribute()
    {
        if ($this->fecha_cierre && $this->hora_cierre) {
            return date("d/m/Y H:i:s", strtotime($this->fecha_cierre . ' ' . $this->hora_cierre));
        }
        return null;
    }

    public function getFechaAperturaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_apertura));
    }

    public function getFechaCierreTAttribute()
    {
        if ($this->fecha_cierre) {
            return date("d/m/Y", strtotime($this->fecha_cierre));
        }
        return null;
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function movimiento_cajas()
    {
        return $this->hasMany(MovimientoCaja::class);
    }
}

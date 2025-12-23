<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class IngresoProducto extends Model
{
    use HasFactory;

    protected $fillable = [
        "producto_id",
        "cantidad",
        "precio_compra",
        "total",
        "fecha_ingreso",
    ];

    public function producto()
    {
        return $this->belongsTo(Producto::class, "producto_id");
    }
}

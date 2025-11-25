<?php

namespace App\Models;

use App\Services\HabitacionFotoService;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HabitacionFoto extends Model
{
    use HasFactory;

    protected $fillable  = [
        "habitacion_id",
        "foto",
    ];

    protected $appends = ["url_archivo", "url_file", "name", "ext"];

    public function getExtAttribute()
    {
        $array = explode(".", $this->foto);
        return $array[1];
    }

    public function getNameAttribute()
    {
        return $this->foto;
    }

    public function getUrlFileAttribute()
    {
        $array_files = ["jpg", "jpeg", "png", "webp", "gif"];
        $ext = HabitacionFotoService::getExtNomHabitacionFoto($this->foto);
        if (in_array($ext, $array_files)) {
            return asset("/imgs/habitacions/" . $this->foto);
        }
        return asset("/imgs/attach.png");
    }

    public function getUrlArchivoAttribute()
    {
        if ($this->foto) {
            return asset("imgs/habitacions/" . $this->foto);
        }
        return asset("imgs/habitacions/roomDefault.webp");
    }

    public function habitacion()
    {
        return $this->belongsTo(Habitacion::class, 'habitacion_id');
    }
}

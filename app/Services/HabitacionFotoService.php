<?php

namespace App\Services;

use App\Models\Habitacion;
use App\Models\HabitacionFoto;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Log;

class HabitacionFotoService
{
    private $pathFiles = "";
    public function __construct(private  CargarArchivoService $cargarArchivoService)
    {
        $this->pathFiles = public_path("imgs/habitacions");
    }

    /**
     * Cargar foto
     *
     * @param Habitacion $habitacion
     * @param UploadedFile $foto
     * @return HabitacionFoto
     */
    public function guardarHabitacionFoto(Habitacion $habitacion, UploadedFile $archivo, int $index = -1): HabitacionFoto
    {
        $nombre = ($index != -1 ? $index : 0) . $habitacion->id . time();
        return $habitacion->habitacion_fotos()->create([
            "foto" => $this->cargarArchivoService->cargarArchivo($archivo, $this->pathFiles, $nombre)
        ]);
    }

    /**
     * Eliminacion fisica de archivo habitacion_foto
     *
     * @param HabitacionFoto $habitacion_foto
     * @return void
     */
    public function eliminarHabitacionFoto(HabitacionFoto $habitacion_foto): void
    {
        $archivo = $habitacion_foto->foto;
        if ($archivo) {
            \File::delete($this->pathFiles . "/" . $archivo);
        }
        $archivo->delete();
    }

    /**
     * Obtener extension del nombre de la archivo
     * ejem: image.png -> png
     * 
     * @param string $archivo
     * @return string
     */
    public static function getExtNomHabitacionFoto(string $archivo): string
    {
        $array = explode(".", $archivo);
        Log::debug("AAA");
        $array[count($array) - 1];
        Log::debug("BB");
        return $array[count($array) - 1];
    }
}

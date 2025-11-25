<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class HabitacionStoreRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            "numero_habitacion" => "required|string|unique:habitacions,numero_habitacion",
            "tipo_habitacion_id" => "required|exists:tipo_habitacions,id",
            "piso" => "required|numeric",
            "capacidad" => "required|numeric",
            "precio" => "required|decimal:0,2",
            "precio_temp" => "required|decimal:0,2",
            "estado" => "required|string",
            "habitacion_fotos" => ["nullable", new \App\Rules\HabitacionFotoRule()],
        ];
    }

    public function messages(): array
    {
        return [
            "numero_habitacion.required" => "El número de habitación es obligatorio.",
            "numero_habitacion.string" => "El número de habitación debe ser una cadena de texto.",
            "numero_habitacion.unique" => "El número de habitación ya está en uso.",
            "tipo_habitacion_id.required" => "El tipo de habitación es obligatorio.",
            "tipo_habitacion_id.exists" => "El tipo de habitación seleccionado no es válido.",
            "piso.required" => "El piso es obligatorio.",
            "piso.numeric" => "El piso debe ser un número.",
            "capacidad.required" => "La capacidad es obligatoria.",
            "capacidad.numeric" => "La capacidad debe ser un número.",
            "precio.required" => "El precio es obligatorio.",
            "precio.decimal" => "El precio debe ser un número decimal con hasta 2 decimales.",
            "precio_temp.required" => "El precio temporal es obligatorio.",
            "precio_temp.decimal" => "El precio temporal debe ser un número decimal con hasta 2 decimales.",
            "estado.required" => "El estado de la habitación es obligatorio.",
            "estado.string" => "El estado de la habitación debe ser una cadena de texto.",
        ];
    }
}

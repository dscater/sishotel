<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class TipoHabitacionUpdateRequest extends FormRequest
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
            "nombre" => "required|string|max:50|unique:tipo_habitacions,nombre," . $this->tipo_habitacion->id,
            "descripcion" => "nullable|string|max:255",
            "capacidad" => "nullable|integer",
        ];
    }

    public function messages(): array
    {
        return [
            "nombre.required" => "El nombre es obligatorio.",
            "nombre.string" => "El nombre debe ser una cadena de texto.",
            "nombre.max" => "El nombre no debe exceder los 50 caracteres.",
            "nombre.unique" => "El nombre ya está en uso.",
            "descripcion.string" => "La descripción debe ser una cadena de texto.",
            "descripcion.max" => "La descripción no debe exceder los 255 caracteres.",
            "capacidad.integer" => "La capacidad debe ser un número entero.",
        ];
    }
}

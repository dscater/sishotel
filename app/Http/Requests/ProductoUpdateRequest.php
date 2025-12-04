<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProductoUpdateRequest extends FormRequest
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
            "nombre" => "required|unique:productos,nombre," . $this->producto->id,
            "descripcion" => "nullable",
            "precio" => "required|decimal:0,2",
            "tipo_producto_id" => "required",
            "imagen" => "nullable|image|mimes:png,jpg,jpeg,webp",
        ];
    }

    public function messages(): array
    {
        return [
            "nombre.required" => "Debes completar este campo",
            "descripcion.required" => "Debes completar este campo",
            "precio.required" => "Debes completar este campo",
            "precio.decimal" => "Debes ingresar un valor númerico con hasta 2 decimales",
            "tipo_producto_id.required" => "Debes completar este campo",
            "imagen.image" => "Debes ingresar una imagen",
            "imagen.mimes" => "Solo puedes cargar png, jpg, jpeg, webp",
            "imagen.max" => "El peso maximo de la imagen es de ",
        ];
    }
}

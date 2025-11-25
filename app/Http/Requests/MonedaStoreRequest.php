<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class MonedaStoreRequest extends FormRequest
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
            "codigo" => "required|unique:monedas,codigo",
            "nombre" => "required|unique:monedas,nombre",
            "simbolo" => "required|unique:monedas,simbolo",
        ];
    }

    public function messages(): array
    {
        return [
            "codigo.required" => "Debes ingresar el código",
            "codigo.unique" => "Este código ya esta en uso",
            "nombre.required" => "Debes ingresar el nombre",
            "nombre.unique" => "Este nombre ya esta en uso",
            "simbolo.required" => "Debes ingresar el simbolo",
            "simbolo.unique" => "Este simbolo ya esta en uso"
        ];
    }
}

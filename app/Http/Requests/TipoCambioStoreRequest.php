<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class TipoCambioStoreRequest extends FormRequest
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
            "moneda_id" => "required",
            "valor" => "required|decimal:0,2",
        ];
    }

    public function messages(): array
    {
        return [
            "moneda_id.required" => "Debes seleccionar una moneda",
            "valor.required" => "Debes ingresar el valor",
            "valor.decimal" => "Demes ingresar un valor númerico con maximo 2 decimales"
        ];
    }
}

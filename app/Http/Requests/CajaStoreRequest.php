<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CajaStoreRequest extends FormRequest
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
            "monto" => "required",
            "moneda_id" => "nullable",
            "tc" => "nullable",
            "monto_tc" => "nullable",
            "moneda_id_tc" => "nullable",
            "tipo_cambio_id" => "nullable",
            "valor_tc" => "nullable",
            "tipo" => "required",
            "efectivo_banco" => "required",
            "descripcion" => "required",
            "fecha_movimiento" => "required",
            "hora_movimiento" => "required",
        ];
    }

    public function messages(): array
    {
        return [
            "monto.required" => "Debes completar este campo",
            "moneda_id.required" => "Debes completar este campo",
            "tipo.required" => "Debes completar este campo",
            "efectivo_banco.required" => "Debes completar este campo",
            "descripcion.required" => "Debes completar este campo",
            "fecha_movimiento.required" => "Debes completar este campo",
            "hora_movimiento.required" => "Debes completar este campo",
        ];
    }
}

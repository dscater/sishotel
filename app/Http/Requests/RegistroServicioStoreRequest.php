<?php

namespace App\Http\Requests;

use App\Rules\RegistroServicioDetalleRule;
use Illuminate\Foundation\Http\FormRequest;

class RegistroServicioStoreRequest extends FormRequest
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
            "registro_id" => "required",
            "tipo" => "required",
            "efectivo_banco" => "required",
            "total" => "required",
            "cancelado" => "required|decimal:0,2",
            "saldo" => "required",
            // "moneda_id" => "required",
            // "total_tc" => "required",
            // "cancelado_tc" => "required",
            // "saldo_tc" => "required",
            // "moneda_id_tc" => "required",
            // "tipo_cambio_id" => "required",
            "servicio_detalles" => ["required", new RegistroServicioDetalleRule()]
        ];
    }
    public function messages(): array
    {
        return [
            "registro_id.required" => "No se pudo registrar intente mas tarde",
            "total.required" => "No se detecto el total",
            "cancelado.required" => "No se detecto el monto cancelado",
            "saldo.required" => "No se detecto el saldo",
            // "moneda_id.required" => "Debes completar este campo",
            // "total_tc.required" => "Debes completar este campo",
            // "cancelado_tc.required" => "Debes completar este campo",
            // "saldo_tc.required" => "Debes completar este campo",
            // "moneda_id_tc.required" => "Debes completar este campo",
            // "tipo_cambio_id.required" => "Debes completar este campo",
            "servicio_detalles.required" => "Debes ingresar al menos 1 producto"
        ];
    }
}

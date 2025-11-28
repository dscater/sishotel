<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class RegistroStoreRequest extends FormRequest
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
            "habitacion_id" => "required",
            "cliente_id" => "required",
            "desayuno" => "required",
            "fecha_entrada" => "required",
            "hora_entrada" => "required",
            "dias_estadia" => "required",
            "fecha_salida" => "required",
            "hora_salida" => "required",
            "cd" => "required|decimal:0,2|min:0",
            "total" => "required|decimal:0,2",
            "adelanto" => "required|decimal:0,2",
            "saldo" => "required|decimal:0,2",
            "garantia" => "required|decimal:0,2",
            "cd_tc" => "nullable|decimal:0,2",
            "total_tc" => "nullable|decimal:0,2",
            "adelanto_tc" => "nullable|decimal:0,2",
            "saldo_tc" => "nullable|decimal:0,2",
            "garantia_tc" => "nullable|decimal:0,2",
            "moneda_id_tc" => "required",
            "tipo" => "required",
        ];
    }

    public function messages(): array
    {
        return [
            "habitacion_id.required" => "No se indico una habitación",
            "cliente_id.required" => "No se seleccionó un cliente",
            "fecha_entrada" => "No se indico la fecha de entrada",
            "hora_entrada" => "No se indico la hora de entrada",
            "dias_estadia" => "No se indico los días de estadía",
            "fecha_salida" => "No se indico la fecha de salida",
            "hora_salida" => "No se indico la hora de salida",
            "cd.required" => "No se indico el precio por día",
            "cd.min" => "Debes ingresar al menos :min",
            "cd.decimal" => "Debes ingresar un valor númerico con hasta 2 decimales",

            "total.required" => "No se indico el precio por día",
            "total.min" => "Debes ingresar al menos :min",
            "total.decimal" => "Debes ingresar un valor númerico con hasta 2 decimales",

            "adelanto.required" => "No se indico el precio por día",
            "adelanto.min" => "Debes ingresar al menos :min",
            "adelanto.decimal" => "Debes ingresar un valor númerico con hasta 2 decimales",

            "saldo.required" => "No se indico el precio por día",
            "saldo.min" => "Debes ingresar al menos :min",
            "saldo.decimal" => "Debes ingresar un valor númerico con hasta 2 decimales",

            "garantia.required" => "No se indico el precio por día",
            "garantia.min" => "Debes ingresar al menos :min",
            "garantia.decimal" => "Debes ingresar un valor númerico con hasta 2 decimales",

            "cd_tc.min" => "Debes ingresar al menos :min",
            "cd_tc.decimal" => "Debes ingresar un valor númerico con hasta 2 decimales",

            "total_tc.min" => "Debes ingresar al menos :min",
            "total_tc.decimal" => "Debes ingresar un valor númerico con hasta 2 decimales",

            "adelanto_tc.min" => "Debes ingresar al menos :min",
            "adelanto_tc.decimal" => "Debes ingresar un valor númerico con hasta 2 decimales",

            "saldo_tc.min" => "Debes ingresar al menos :min",
            "saldo_tc.decimal" => "Debes ingresar un valor númerico con hasta 2 decimales",

            "garantia_tc.required" => "No se indico el precio por día",
            "garantia_tc.min" => "Debes ingresar al menos :min",
            "garantia_tc.decimal" => "Debes ingresar un valor númerico con hasta 2 decimales",
        ];
    }
}

<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ClienteStoreRequest extends FormRequest
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
            "nombre" => "required|min:2",
            "paterno" => "required|min:1",
            "materno" => "nullable|min:1",
            "ci" => "required|numeric|digits_between:6,10|unique:users,ci",
            "ci_exp" => "nullable",
            "dir" => "nullable|min:1",
            "fono" => "required|min:1",
            "correo" => "nullable|email|unique:users,correo",
            "fecha_nac" => "nullable|date",
            "edad" => "nullable|numeric",
            "nacionalidad" => "nullable|min:1",
            "pais" => "nullable|min:1",
        ];
    }

    /**
     * Mensages validacion
     *
     * @return array
     */
    public function messages(): array
    {
        return [
            "nombre.required" => "Este campo es obligatorio",
            "nombre.min" => "Debes ingresar al menos :min caracteres",
            "paterno.required" => "Este campo es obligatorio",
            "paterno.min" => "Debes ingresar al menos :min caracteres",
            "materno.min" => "Debes ingresar al menos :min caracteres",
            "ci.required" => "Este campo es obligatorio",
            "ci.numeric" => "Debes ingresar un valor númerico",
            "ci.digits_between" => "Debes ingresar un valor entre 6 y 10 digitos",
            "ci.unique" => "Este número de C.I. ya fue registrado",
            "ci_exp.required" => "Este campo es obligatorio",
            "dir.required" => "Este campo es obligatorio",
            "dir.min" => "Debes ingresar al menos :min caracteres",
            "fono.required" => "Este campo es obligatorio",
            "fono.min" => "Debes ingresar al menos :min caracteres",
            "correo.required" => "Este campo es obligatorio",
            "correo.email" => "Debes ingresar un correo valido",
            "correo.unique" => "Este correo no esta disponible",
        ];
    }
}

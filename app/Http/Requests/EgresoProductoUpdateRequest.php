<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class EgresoProductoUpdateRequest extends FormRequest
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
            "producto_id" => "required",
            "cantidad" => "required",
            "motivo" => "required",
        ];
    }

    public function messages()
    {
        return [
            "producto_id.required" => "El campo producto es obligatorio.",
            "cantidad.required" => "El campo cantidad es obligatorio.",
            "motivo.required" => "El campo motivo es obligatorio.",
        ];
    }
}

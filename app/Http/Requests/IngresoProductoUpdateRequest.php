<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class IngresoProductoUpdateRequest extends FormRequest
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
            "precio_compra" => "required",
            "total" => "required",
        ];
    }

    public function messages(): array
    {
        return [
            "producto_id.required" => "El campo producto es obligatorio.",
            "cantidad.required" => "El campo cantidad es obligatorio.",
            "precio_compra.required" => "El campo precio de compra es obligatorio.",
            "total.required" => "El campo total es obligatorio.",
        ];
    }
}

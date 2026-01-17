<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use App\Enums\TaskStatus;

class NewTaskRequest extends FormRequest
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
            'title' => ['required', 'string', 'max:250'],
            'description' => ['nullable', 'string'],
            'status' => [
                'nullable',
                Rule::enum(TaskStatus::class)
            ],
        ];

    }
    public function messages(): array
    {
      return [
        'title.required' => "Заголовок задачи требуется задать",
        'title.max:250' => 'длинна заголовка задачи не может превышать 250 символов',
      ];
    }
}

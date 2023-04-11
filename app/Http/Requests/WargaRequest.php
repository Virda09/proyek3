<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class WargaRequest extends FormRequest
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
     * @return array<string, \Illuminate\Contracts\Validation\Rule|array|string>
     */
    public function rules(): array
    {
        $id = $this->get('id');
        $uid = $this->get('id_user');
        if ($this->method() == 'PUT') {
            $telepon = 'required|unique:wargas,telepon,' . $id;
            $username = 'required|unique:users,username,' . $uid;
            $password = 'nullable|string|min:8|confirmed';
            $photo = 'nullable|image|mimes:jpeg,png,jpg,gif|max:4096';
        } else {
            $telepon = 'required|unique:wargas,telepon,NULL';
            $photo = 'required|image|mimes:jpeg,png,jpg,gif|max:4096';
            $username = 'required|unique:users,username,NULL';
            $password = 'required|string|min:8|confirmed';
        }
        return [
            'nama_lengkap' => 'required|string|max:255',
            'pekerjaan' => 'required|string|max:255',
            'alamat' => 'required|string',
            'agama' => 'required',
            'tempat_lahir' => 'required|string|max:255',
            'tanggal_lahir' => 'required|string|max:255',
            'jenis_kelamin' => 'required',
            'status' => 'required',
            'telepon' => $telepon,
            'photo' => $photo,
            'username' => $username,
            'password' => $password,
        ];
    }
}

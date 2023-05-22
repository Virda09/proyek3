<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Resources\PostResource;
use App\Models\Warga;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class ApiUserController extends Controller
{
    public function index()
    {
        $post = Warga::all();
        return new PostResource(true, 'List Data Warga', $post);
    }

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'current_password' => 'nullable|required_with:new_password',
            'new_password' => 'nullable|min:8|max:12|required_with:current_password',
            'password_confirmation' => 'nullable|min:8|max:12|required_with:new_password|same:new_password'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }
        
        try {
            $user = User::findOrFail($id);
            if (!is_null($request->input('current_password'))) {
                if (Hash::check($request->input('current_password'), $user->password)) {
                    $params['password'] = Hash::make($request->input('new_password'));
                } else {
                    $sql = False;
                    $message = 'Password Tidak Cocok';
                }
            }

            if ($user->update($params)) {
                $sql = True;
                $message = 'Update Berhasil';
            } else {
                $sql = False;
                $message = 'Update Gagal';
            }

            return new PostResource($sql, $message, []);
        } catch (\Throwable $th) {
            $sql = False;
            $message = 'Terjadi Kesalahan';

            return new PostResource($sql, $message, []);
        }
    }
}

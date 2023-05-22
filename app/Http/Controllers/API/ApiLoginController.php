<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\PostResource;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ApiLoginController extends Controller
{
    public function __invoke(Request $request)
    {
        //set validation
        $validator = Validator::make($request->all(), [
            'username'     => 'required|string|max:255',
            'password'  => 'required|string|min:8'
        ]);

        //if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $input = $request->all();
        
        try {
            if (auth()->attempt(array('username' => $input['username'], 'password' => $input['password']))) {
                if (auth()->user()->role == 'warga') {
                    $sql = User::where('id', auth()->user()->id)->get();
                    $bool = True;
                    $message = 'Login Berhasil';
                } elseif (auth()->user()->role == 'koordinator') {
                    $sql = User::where('id', auth()->user()->id)->get();
                    $bool = True;
                    $message = 'Login Berhasil';
                } else {
                    $bool = False;
                    $sql = '';
                    $message = 'Login Gagal';
                }
            } else {
                $bool = False;
                $sql = '';
                $message = 'Username atau Password Salah';
            }
            return new PostResource($bool, $message, $sql);
        } catch (\Throwable $th) {
            return new PostResource(False, 'Login Error', []);
        }
    }
}

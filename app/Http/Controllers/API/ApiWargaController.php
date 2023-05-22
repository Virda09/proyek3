<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\PostResource;
use App\Models\User;
use App\Models\Warga;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Nette\Utils\DateTime;

class ApiWargaController extends Controller
{
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nama_lengkap' => 'required|string|max:255',
            'pekerjaan' => 'required|string|max:255',
            'alamat' => 'required|string',
            'agama' => 'required',
            'tempat_lahir' => 'required|string|max:255',
            'tanggal_lahir' => 'required|string|max:255',
            'jenis_kelamin' => 'required',
            'status' => 'required',
            'telepon' => 'required|unique:wargas,telepon,NULL',
            'photo' => 'required|image|mimes:jpeg,png,jpg,gif|max:4096',
            'username' => 'required|unique:users,username,NULL',
            'password' => 'required|string|min:8|confirmed',
        ]);

        //check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $params = $request->all();
        $params['password'] =  Hash::make($request->password);
        $params['role'] = 'warga';
        $params['nama'] = $request->nama_lengkap;

        if ($request->has('photo')) {
            $params['photo'] = $this->simpanImage($request->file('photo'), $request->username);
        }

        try {
            $user = User::create($params);
            if ($user) {
                $params['id_user'] = $user->id;
                if (Warga::create($params)) {
                    $sql = True;
                    $message = 'Registrasi Berhasil';
                } else {
                    $user = User::findOrFail($user->id);
                    $user->delete();
                    $sql = False;
                    $message = 'Registrasi Gagal';
                }
            } else {
                $sql = False;
                $message = 'Registrasi Gagal';
            }
            return new PostResource($sql, $message, []);
        } catch (\Throwable $th) {
            $sql = False;
            $message = 'Terjadi Kesalahan';

            return new PostResource($sql, $message, []);
        }
    }

    public function show($id)
    {
        $posts = Warga::where('id_user', $id)->get();
        return new PostResource(true, 'Data Warga', $posts);
    }

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'nama_lengkap' => 'required|string|max:255',
            'pekerjaan' => 'required|string|max:255',
            'alamat' => 'required|string',
            'agama' => 'required',
            'tempat_lahir' => 'required|string|max:255',
            'tanggal_lahir' => 'required|string|max:255',
            'jenis_kelamin' => 'required',
            'status' => 'required',
            'telepon' => 'required|unique:wargas,telepon,' . $request->id,
            'username' => 'required|unique:users,username,' . $request->id_user,
            'password' => 'nullable|string|min:8|confirmed',
            'photo' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:4096',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $params = $request->all();
        $params['username'] = $request->username;
        $params['nama'] = $request->nama_lengkap;

        if ($request->filled('password')) {
            $params['password'] = Hash::make($request->password);
        } else {
            $params = $request->except('password');
        }

        if ($request->has('photo')) {
            $params['photo'] = $this->simpanImage($request->file('photo'), $request->username);
        } else {
            $params = $request->except('photo');
        }

        try {
            $warga = Warga::findOrFail($id);
            $user = User::findOrFail($warga->id_user);
            if ($warga->update($params) && $user->update($params)) {
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

    private function simpanImage($foto, $nama)
    {
        $dt = new DateTime();

        $path = public_path('storage/uploads/warga');
        if (!File::isDirectory($path)) {
            File::makeDirectory($path, 0755, true, true);
        }
        $file = $foto;
        $name =  $nama . '_' . $dt->format('Y-m-d');
        $fileName = $name . '.' . $file->getClientOriginalExtension();
        $folder = '/uploads/warga';

        $check = public_path($folder) . $fileName;

        if (File::exists($check)) {
            File::delete($check);
        }

        $file->storeAs($folder, $fileName, 'public');
        return $fileName;
    }
}

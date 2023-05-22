<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\PostResource;
use App\Models\Iuran;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Nette\Utils\DateTime;

class ApiIuranController extends Controller
{
    public function listIuran($id)
    {
        $post = Iuran::where('id_warga', $id)->get();
        return new PostResource(true, 'List Data Iuran', $post);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id_warga' => 'required',
            'bukti' => 'required|image|mimes:jpeg,png,jpg,gif|max:4096',
            'tgl_bayar' => 'required',
            'nominal' => 'required|integer'
        ]);

        //check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $date = new DateTime();
        $timeNow = $date->format('Y-m-d H:i');

        $params = $request->all();
        $params['status'] = 'belum dilihat';
        $params['tgl_bayar'] = $timeNow;

        if ($request->has('bukti')) {
            $params['bukti'] = $this->simpanImage($request->file('bukti'), $request->id_warga);
        }

        try {
            $post = Iuran::create($params);
            if ($post) {
                $sql = True;
                $message = 'Data Berhasil Ditambahkan';
            } else {
                $sql = False;
                $message = 'Data Gagal Ditambahkan';
            }
            return new PostResource($sql, $message, $post);
        } catch (\Throwable $th) {
            $sql = False;
            $message = 'Terjadi Kesalahan';

            return new PostResource($sql, $message, []);
        }
    }

    public function show($id)
    {
        $posts = Iuran::find($id);
        return new PostResource(true, 'Detail Iuran', $posts);
    }


    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'id_warga' => 'required',
            'bukti' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:4096',
            'status' => 'required|string',
            'nominal' => 'required|integer'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $params = $request->all();
        $params['status'] = 'belum dilihat';

        if ($request->has('bukti')) {
            $params['bukti'] = $this->simpanImage($request->file('bukti'), $request->id_warga);
        } else {
            $params = $request->except('bukti');
        }

        try {
            $post = Iuran::findOrFail($id);
            if ($post->update($params)) {
                $sql = True;
                $message = 'Update Berhasil';
            } else {
                $sql = False;
                $message = 'Update Gagal';
            }
            return new PostResource($sql, $message, $post);
        } catch (\Throwable $th) {
            $sql = False;
            $message = 'Terjadi Kesalahan';

            return new PostResource($sql, $message, []);
        }
    }

    public function destroy($id)
    {
        $post = Iuran::find($id);
        Storage::delete('storage/uploads/iuran' . basename($post->bukti));
        $post->delete();

        return new PostResource(true, 'Data Berhasil Dihapus', null);
    }

    public function verifikasi($id, $value)
    {
        try {
            if ($value == 'terima') {
                $params['status'] = 'terima';
            } else {
                $params['status'] = 'tolak';
            }
            $iuran = Iuran::findOrFail($id);
            if ($iuran->update($params)) {
                $sql = True;
                $message = 'Update Berhasil';
            } else {
                $sql = False;
                $message = 'Update Gagal';
            }
            return new PostResource($sql, $message, null);
        } catch (\Throwable $th) {
            $sql = False;
            $message = 'Terjadi Kesalahan';

            return new PostResource($sql, $message, null);
        }
    }

    private function simpanImage($foto, $nama)
    {
        $dt = new DateTime();

        $path = public_path('storage/uploads/iuran');
        if (!File::isDirectory($path)) {
            File::makeDirectory($path, 0755, true, true);
        }
        $file = $foto;
        $name =  $nama . '_' . $dt->format('Y-m-d');
        $fileName = $name . '.' . $file->getClientOriginalExtension();
        $folder = '/uploads/iuran';

        $check = public_path($folder) . $fileName;

        if (File::exists($check)) {
            File::delete($check);
        }

        $file->storeAs($folder, $fileName, 'public');
        return $fileName;
    }
}

<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\PostResource;
use App\Models\Aspirasi;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ApiAspirasiController extends Controller
{
    public function index(){
        $post = Aspirasi::orderBy('created_at', 'asc')->get();
        return new PostResource(true, 'List Data Aspirasi', $post);
    }

    public function listAspirasi($id)
    {
        $post = Aspirasi::where('id_warga', $id)->get();
        return new PostResource(true, 'List Data Aspirasi', $post);
    }

    public function show($id)
    {
        $posts = Aspirasi::find($id);
        return new PostResource(true, 'Detail Aspirasi', $posts);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id_warga' => 'required',
            'aspirasi' => 'required|string',
            'status' => 'required',
            'nama' => 'required',
        ]);

        //check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $text = $request->aspirasi;
        $predict = shell_exec("python c:/xampp/htdocs/proyek3/web-dev/app/Http/Controllers/Klasifikasi/klasifikasi.py ".escapeshellarg($text));
        $params = $request->all();
        $params['status'] = 'Belum Dibaca';
        $params['jenis_aspirasi'] = trim($predict);
        try {
            $post = Aspirasi::create($params);
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

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'id_warga' => 'required',
            'aspirasi' => 'required|string',
            'jenis_aspirasi' => 'required|string',
            'status' => 'required',
            'nama' => 'required',
        ]);

        //check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $params = $request->all();
        $params['status'] = 'Belum Dibaca';

        try {
            $post = Aspirasi::findOrFail($id);
            if ($post->update($params)) {
                $sql = True;
                $message = 'Data Berhasil Diupdate';
            } else {
                $sql = False;
                $message = 'Data Gagal Diupdate';
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
        $post = Aspirasi::find($id);
        $post->delete();

        return new PostResource(true, 'Data Berhasil Dihapus', null);
    }
}

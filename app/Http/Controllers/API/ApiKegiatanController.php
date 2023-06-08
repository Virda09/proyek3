<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\PostResource;
use App\Models\Kegiatan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Nette\Utils\DateTime;

class ApiKegiatanController extends Controller
{
    public function index()
    {
        $date = new DateTime();
        $timeNow = $date->format('Y-m-d\TH:i');
        $kegiatan = Kegiatan::all();
        return new PostResource(true, 'List Data Kegiatan', $kegiatan);
    }

    public function activity(){
        $date = new DateTime();
        $timeNow = $date->format('Y-m-d');
        $kegiatan = Kegiatan::where('tanggal_kegiatan', '==', $timeNow)
            ->orderBy('tanggal_kegiatan', 'ASC')
            ->limit(2)
            ->get();
        return new PostResource(true, 'List Data Kegiatan', $kegiatan);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'deskripsi' => 'required|string',
            'tanggal_kegiatan' => 'required|string',
            'nama' => 'required',
        ]);

        //check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $params = $request->all();
        try {
            $post = Kegiatan::create($params);
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
            'deskripsi' => 'required|string',
            'tanggal_kegiatan' => 'required|string',
            'nama' => 'required',
        ]);

        //check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $params = $request->all();

        try {
            $post = Kegiatan::findOrFail($id);
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
        $post = Kegiatan::find($id);
        $post->delete();

        return new PostResource(true, 'Data Berhasil Dihapus', null);
    }
}

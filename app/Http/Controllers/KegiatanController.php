<?php

namespace App\Http\Controllers;

use App\Models\Kegiatan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;

class KegiatanController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $kegiatans = Kegiatan::all();
        $this->data['kegiatan'] = $kegiatans;
        return view('kegiatan.index', $this->data);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('kegiatan.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $params = $request->all();

            // if ($request->has('photo')) {
            //     $params['photo'] = $this->simpanImage('instance', $request->file('photo'), $params['username']);
            // }

            $kegiatan = Kegiatan::create($params);
            if ($kegiatan) {
                Alert()->success('Success', 'Data Berhasil Disimpan');
            } else {
                Session::flash('errors', 'Data Gagal Disimpan');
            }
            return redirect('kegiatan');
        } catch (\Throwable $th) {
            Session::flash('errors', 'Data Gagal Disimpan');
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $kegiatan = Kegiatan::findOrFail(Crypt::decrypt($id));
        $this->data['data'] = $kegiatan;
        return view('kegiatan.edit', $this->data);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        try {
            $params = $request->all();

            // if ($request->has('photo')) {
            //     $params['photo'] = $this->simpanImage('instance', $request->file('photo'), $params['username']);
            // } else {
            //     $params = $request->except('photo');
            // }

            $kegiatan = Kegiatan::findOrFail(Crypt::decrypt($id));
            if ($kegiatan->update($params)) {
                Alert()->success('Success', 'Data Berhasil Disimpan');
            } else {
                Session::flash('errors', 'Data Gagal Disimpan');
            }
            return redirect('kegiatan');
        } catch (\Throwable $th) {
            Session::flash('errors', 'Data Gagal Disimpan');
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        try {
            $kegiatan = Kegiatan::findOrFail(Crypt::decrypt($id));
            // $url = $kegiatan->photo;
            // $dir = public_path('storage/' . substr($url, 0, strrpos($url, '/')));
            // $path = public_path('storage/' . $url);

            // File::delete($path);

            // rmdir($dir);
            if ($kegiatan->delete()) {
                alert()->success('Success', 'Data Berhasil Dihapus');
            }
            return redirect('kegiatan');
        } catch (\Throwable $th) {
            Session::flash('errors', 'Data Gagal Dihapus');
        }
    }
}

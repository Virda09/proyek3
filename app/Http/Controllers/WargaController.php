<?php

namespace App\Http\Controllers;

use App\Http\Requests\WargaRequest;
use App\Models\User;
use App\Models\Warga;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;
use Nette\Utils\DateTime;

class WargaController extends Controller
{
    public function index()
    {
        $warga = Warga::all();
        $data['warga'] = $warga;
        return view('warga.index', $data);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('warga.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(WargaRequest $request)
    {
        try {
            $params = $request->all();
            $params['password'] =  Hash::make($request->password);
            $params['role'] = 'warga';
            $params['nama'] = $request->nama_lengkap;

            if ($request->has('photo')) {
                $params['photo'] = $this->simpanImage('kd', $request->file('photo'), $params['username']);
            }

            $user = User::create($params);
            if ($user) {
                alert()->success('Success', 'Data Berhasil Disimpan');
                $params['id_user'] = $user->id;
                if (Warga::create($params)) {
                    alert()->success('Success', 'Data Berhasil Disimpan');
                } else {
                    $user = User::findOrFail($user->id);
                    $user->delete();
                    Session::flash('errors', 'Data Gagal Disimpan');
                    // alert()->error('Error', 'Data Gagal Disimpan');
                }
            }
            return redirect('warga');
        } catch (\Throwable $th) {
            Session::flash('errors', 'Data Gagal Disimpan');
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {

    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $warga = Warga::findOrFail(Crypt::decrypt($id));
        $data['data'] = $warga;
        $user = User::findOrFail($warga->id_user);
        $data['username'] = $user->username;
        return view('warga.edit', $data);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(WargaRequest $request, string $id)
    {
        try {
            $params = $request->all();
            $params['username'] = $request->username;
            $params['nama'] = $request->nama_lengkap;

            if ($request->filled('password')) {
                $params['password'] = Hash::make($request->password);
            } else {
                $params = $request->except('password');
            }

            if ($request->has('photo')) {
                $params['photo'] = $this->simpanImage('kd', $request->file('photo'), $params['username']);
            } else {
                $params = $request->except('photo');
            }

            $warga = Warga::findOrFail(Crypt::decrypt($id));
            $user = User::findOrFail($warga->id_user);
            if ($warga->update($params) && $user->update($params)) {
                alert()->success('Success', 'Data Berhasil Disimpan');
            } else {
                // Session::flash('errors', 'Data Gagal Disimpan');
                alert()->error('Error','Data Berhasil Disimpan');
            }
            return redirect('warga');
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
            $warga = Warga::findOrFail(Crypt::decrypt($id));
            $url = $warga->photo;
            $dir = public_path('storage/' . substr($url, 0, strrpos($url, '/')));
            $path = public_path('storage/' . $url);

            File::delete($path);

            rmdir($dir);
            if ($warga->delete()) {
                $user = User::findOrFail($warga->id_user);
                $user->delete();
                alert()->success('Success', 'Data Berhasil Dihapus');
            }
            return redirect('warga');
        } catch (\Throwable $th) {
            Session::flash('errors', 'Data Gagal Dihapus');
        }
    }

    private function simpanImage($type, $foto, $nama)
    {
        $dt = new DateTime();

        $path = public_path('storage/uploads/koordinator/' . $type . '/' . $dt->format('Y-m-d') . '/' . $nama);
        if (!File::isDirectory($path)) {
            File::makeDirectory($path, 0755, true, true);
        }
        $file = $foto;
        $name =  $type . '_' . $nama . '_' . $dt->format('Y-m-d');
        $fileName = $name . '.' . $file->getClientOriginalExtension();
        $folder = '/uploads/koordinator/' . $type . '/' . $dt->format('Y-m-d') . '/' . $nama;

        $check = public_path($folder) . $fileName;

        if (File::exists($check)) {
            File::delete($check);
        }

        $filePath = $file->storeAs($folder, $fileName, 'public');
        return $filePath;
    }
}

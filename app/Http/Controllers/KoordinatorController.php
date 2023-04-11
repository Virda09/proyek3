<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;

class KoordinatorController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $user = User::where('role', 'koordinator')->get();
        $data['user'] = $user;
        return view('koordinator.index', $data);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('koordinator.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $params = $request->all();
            $params['password'] =  Hash::make($request->password);
            $params['role'] = 'koordinator';

            $user = User::create($params);
            if ($user) {

                alert()->success('Success', 'Data Berhasil Disimpan');
            } else {
                Session::flash('errors', 'Data Gagal Disimpan');
                // alert()->error('Error', 'Data Gagal Disimpan');
            }
            return redirect('koordinator');
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
        $user = User::findOrFail(Crypt::decrypt($id));
        $data['data'] = $user;
        return view('koordinator.edit', $data);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        try {
            $params = $request->all();

            if ($request->filled('password')) {
                $params['password'] = Hash::make($request->password);
            } else {
                $params = $request->except('password');
            }

            $user = User::findOrFail(Crypt::decrypt($id));
            if ($user->update($params)) {
                alert()->success('Success', 'Data Berhasil Disimpan');
            } else {
                Session::flash('errors', 'Data Gagal Disimpan');
                // alert()->error('Error','Data Berhasil Disimpan');
            }
            return redirect('koordinator');
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
            $user = User::findOrFail(Crypt::decrypt($id));
            if ($user->delete()) {
                alert()->success('Success', 'Data Berhasil Dihapus');
            }
            return redirect('koordinator');
        } catch (\Throwable $th) {
            Session::flash('errors', 'Data Gagal Dihapus');
        }
    }
}

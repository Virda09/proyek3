<?php

namespace App\Http\Controllers;

use App\Models\Aspirasi;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Session;

class AspirasiController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return view('livewire.aspirasi.home');
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
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
       
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        try {
            $params['status'] = 'dibaca';
            $aspirasi = Aspirasi::findOrFail(Crypt::decrypt($id));
            // dd($aspirasi);
            if ($aspirasi->update(['status' => 'dibaca'])) {
                Alert()->success('Success', 'Data Berhasil Disimpan');
            } else {
                Session::flash('errors', 'Data Gagal Disimpan');
            }
            // return redirect('aspirasi');
        } catch (\Throwable $th) {
            Session::flash('errors', 'Data Gagal Disimpan');
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}

<?php

namespace App\Http\Controllers;

use App\Models\Aspirasi;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Session;
use Nette\Utils\DateTime;
use PDF;

class AspirasiController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $date = new DateTime();

        Session::put('filter', 'Hari Ini');
        $timeNow = $date->format('Y-m-d');
        $aspirasi = Aspirasi::where('created_at', 'like', '%' . $timeNow . '%')->get();

        $data['aspirasi'] = $aspirasi;
        return view('aspirasi.index', $data);
    }

    public function filter(string $filter)
    {
        $date = new DateTime();
        if ($filter == '' || $filter == 'hari ini') {
            Session::put('filter', 'Hari Ini');
            $timeNow = $date->format('Y-m-d');
        } elseif ($filter == 'bulan ini') {
            Session::put('filter', 'Bulan Ini');
            $timeNow = $date->format('Y-m');
        } else {
            Session::put('filter', 'Tahun Ini');
            $timeNow = $date->format('Y');
        }

        $aspirasi = Aspirasi::where('created_at', 'like', '%' . $timeNow . '%')->get();
        $data['aspirasi'] = $aspirasi;
        return view('aspirasi.index', $data);
    }

    public function cetak(string $cetak)
    {
        $date = Carbon::now();
        if ($cetak == 'bulan ini') {
            $timeNow = $date->format('Y-m');
        } else {
            $timeNow = $date->subMonth()->format('Y-m');
        }
        $aspirasi = Aspirasi::where('created_at', 'like', '%' . $timeNow . '%')
                ->orderBy('jenis_aspirasi')
                ->get();
        $data = [
            'title' => 'Aspirasi Warga',
            'date' => $date->format('m/d/Y'),
            'aspirasi' => $aspirasi
        ];
        $pdf = PDF::loadView('cetak.aspirasi', $data);
        return $pdf->download('aspirasi.pdf');
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
            $status = $aspirasi->update(['status' => 'dibaca']);
            if ($status) {
                Alert()->success('Success', 'Data Berhasil Disimpan');
            } else {
                Session::flash('errors', 'Data Gagal Disimpan');
            }
            return redirect('aspirasi');
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

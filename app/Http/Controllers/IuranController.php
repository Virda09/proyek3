<?php

namespace App\Http\Controllers;

use App\Models\Iuran;
use App\Models\Warga;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use PDF;
use Illuminate\Support\Facades\Session;

class IuranController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $iuran = Warga::join("iurans", function ($join) {
            $join->on("iurans.id_warga", "=", "wargas.id");
        })
            ->selectRaw("wargas.*, count(iurans.status) as validasi")
            ->where("iurans.status", "=", "belum dilihat")
            ->groupBy('wargas.nama_lengkap')->get();
        $data['iuran'] = $iuran;
        return view('iuran.index', $data);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
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
        $iuran = Iuran::where('id_warga', Crypt::decrypt($id))->get();
        $data['iuran'] = $iuran;
        return view('iuran.detail', $data);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function terima(string $id)
    {
        try {
            $params['status'] = 'terima';
            $iuran = Iuran::findOrFail(Crypt::decrypt($id));
            if ($iuran->update($params)) {
                Alert()->success('Success', 'Data Berhasil Disimpan');
            } else {
                Session::flash('errors', 'Data Gagal Disimpan');
            }
            return redirect()->back();
        } catch (\Throwable $th) {
            Session::flash('errors', 'Data Gagal Disimpan');
        }
    }

    public function tolak(string $id)
    {
        try {
            $params['status'] = 'tolak';
            $iuran = Iuran::findOrFail(Crypt::decrypt($id));
            if ($iuran->update($params)) {
                Alert()->success('Success', 'Data Berhasil Disimpan');
            } else {
                Session::flash('errors', 'Data Gagal Disimpan');
            }
            return redirect()->back();
        } catch (\Throwable $th) {
            Session::flash('errors', 'Data Gagal Disimpan');
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }

    public function cetak(string $cetak)
    {
        $date = Carbon::now();
        if ($cetak == 'bulan ini') {
            $timeNow = $date->format('Y-m');
            $title = "Bulan ".$date->isoFormat('MMMM Y');
        } else if ($cetak == 'kemarin') {
            $timeNow = $date->subMonth()->format('Y-m');
            $title = "Bulan ".$date->isoFormat('MMMM Y');
        } else {
            $timeNow = $date->format('Y');
            $title = "Tahun ".$date->isoFormat('Y');
        }

        $iuran = Iuran::join("wargas", function ($join) {
            $join->on("iurans.id_warga", "=", "wargas.id");
        })
            ->selectRaw("iurans.*, wargas.nama_lengkap")
            ->where('iurans.created_at', 'like', '%' . $timeNow . '%')
            ->orderBy('wargas.nama_lengkap')
            ->get();
        $data = [
            'title' => 'Iuran Warga',
            'date' => $title,
            'iuran' => $iuran
        ];
        $pdf = PDF::loadView('cetak.iuran', $data);
        return $pdf->download('iuran.pdf');
    }
}

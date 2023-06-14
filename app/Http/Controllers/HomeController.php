<?php

namespace App\Http\Controllers;

use App\Models\Aspirasi;
use App\Models\Iuran;
use App\Models\Kegiatan;
use App\Models\Warga;
use Illuminate\Http\Request;
use Nette\Utils\DateTime;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        $warga = Warga::count();
        $data['warga'] = $warga;
        $iuran = Iuran::where('status', 'Belum Dilihat')->get()->count();
        $data['iuran'] = $iuran;
        $aspirasi = Aspirasi::where('status', 'Belum Dibaca')->get()->count();
        $data['aspirasi'] = $aspirasi;
        $date = new DateTime();
        $timeNow = $date->format('Y-m-d\TH:i');
        $kegiatan = Kegiatan::where('tanggal_kegiatan', '>=', $timeNow)
            ->orderBy('tanggal_kegiatan', 'ASC')
            ->limit(5)
            ->get();
        // dd($timeNow);
        $data['kegiatan'] = $kegiatan;
        return view('home', $data);
    }
}

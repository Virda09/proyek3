<?php

namespace App\Http\Controllers;

use App\Models\Aspirasi;
use App\Models\Iuran;
use App\Models\Warga;
use Illuminate\Http\Request;

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
        $iuran = Iuran::where('status', 'tunggu')->get()->count();
        $data['iuran'] = $iuran;
        $aspirasi = Aspirasi::where('status', 'belum dibaca')->get()->count();
        $data['aspirasi'] = $aspirasi;
        return view('home', $data);
    }
}

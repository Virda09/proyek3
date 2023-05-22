<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\PostResource;
use App\Models\Kegiatan;
use Nette\Utils\DateTime;

class ApiKegiatanController extends Controller
{
    public function index()
    {
        $date = new DateTime();
        $timeNow = $date->format('Y-m-d\TH:i');
        $kegiatan = Kegiatan::where('tanggal_kegiatan', '>=', $timeNow)
            ->orderBy('tanggal_kegiatan', 'ASC')
            ->limit(5)
            ->get();
        return new PostResource(true, 'List Data Kegiatan', $kegiatan);
    }
}

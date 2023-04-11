<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Aspirasi;
use Illuminate\Database\Seeder;

class AspirasiSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        Aspirasi::create([
            'id_warga' => '1',
            // 'nama' => 'anonim1',
            'aspirasi' => 'tingkatkan Keamanan',
            'jenis_aspirasi' => 'keamanan',
            'status' => 'belum dibaca'
        ]);
        Aspirasi::create([
            'id_warga' => '1',
            // 'nama' => 'anonim1',
            'aspirasi' => 'tingkatkan Keamanan',
            'jenis_aspirasi' => 'keamanan',
            'status' => 'belum dibaca'
        ]);
        Aspirasi::create([
            'id_warga' => '1',
            // 'nama' => 'anonim1',
            'aspirasi' => 'tingkatkan Keamanan',
            'jenis_aspirasi' => 'keamanan',
            'status' => 'belum dibaca'
        ]);
        Aspirasi::create([
            'id_warga' => '1',
            // 'nama' => 'anonim1',
            'aspirasi' => 'tingkatkan Keamanan',
            'jenis_aspirasi' => 'keamanan',
            'status' => 'belum dibaca'
        ]);
        Aspirasi::create([
            'id_warga' => '1',
            // 'nama' => 'anonim1',
            'aspirasi' => 'tingkatkan Keamanan',
            'jenis_aspirasi' => 'keamanan',
            'status' => 'belum dibaca'
        ]);
    }
}

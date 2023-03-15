<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Aspirasi extends Model
{
    use HasFactory;

    protected $fillable = [
        'id_warga',
        'aspirasi',
        'jenis_aspirasi',
    ];

    public function warga(){
        return $this->belongsTo('App\Models\Warga');
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Iuran extends Model
{
    use HasFactory;

    protected $fillable = [
        'id_warga',
        'bukti',
        'status',
        'tgl_bayar',
        'nominal'
    ];

    protected function bukti(): Attribute
    {
        return Attribute::make(
            get: fn ($bukti) => asset('storage/uploads/iuran/' . $bukti),
        );
    }

    public function warga(){
        return $this->belongsTo('App\Models\Warga');
    }
}

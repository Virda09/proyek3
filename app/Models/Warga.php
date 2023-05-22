<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Warga extends Model
{
    use HasFactory;

    protected $fillable = [
        'id_user',
        'nama_lengkap',
        'alamat',
        'pekerjaan',
        'agama', 
        'tempat_lahir',
        'tanggal_lahir',
        'jenis_kelamin',
        'status',
        'telepon',
        'photo'
    ];

    protected function photo(): Attribute
    {
        return Attribute::make(
            get: fn ($photo) => asset('storage/uploads/warga' . $photo),
        );
    }

    public function users(){
        return $this->belongsTo('App\Models\User');
    }

    public function warga(){
        return $this->hasMany('App\Models\Aspirasi');
    }
}

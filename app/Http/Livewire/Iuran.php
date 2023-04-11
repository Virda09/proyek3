<?php

namespace App\Http\Livewire;

use App\Models\Iuran as ModelsIuran;
use Livewire\Component;

class Iuran extends Component
{
    public $iurans, $iuran_id, $id_warga, $bukti, $status, $tgl_bayar,$nominal;
    public $updateMode = false;

    public function render()
    {
        $this->iurans = ModelsIuran::all()->orderby('tgl_bayar');
        return view('livewire.iuran.iuran');
    }
}

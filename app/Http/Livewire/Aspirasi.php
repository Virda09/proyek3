<?php

namespace App\Http\Livewire;

use App\Models\Aspirasi as ModelsAspirasi;
use Livewire\Component;

class Aspirasi extends Component
{
    public $aspirasis, $aspirasi_id, $nama, $aspirasi, $jenis_aspirasi;
    public $updateMode = false;

    public function render()
    {
        $this->aspirasis = ModelsAspirasi::all();
        return view('livewire.aspirasi.aspirasi');
    }

    public function edit($id)
    {
        $this->updateMode = true;
        $aspirasi = ModelsAspirasi::where('id', $id)->get();
        $this->aspirasi_id = $id;
        $this->nama = $aspirasi->nama;
        $this->jenis_aspirasi = $aspirasi->jenis_aspirasi;
        $this->aspirasi = $aspirasi->aspirasi;
    }

    public function update()
    {
        if ($this->aspirasi_id) {
            $user = ModelsAspirasi::findOrFail($this->aspirasi_id);
            $user->update([
                'status' => 'dibaca',
            ]);
            $this->updateMode = false;
            $this->resetInputFields();
        }
    }
}

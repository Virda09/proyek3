<div>
    @include('livewire.aspirasi.update')
    <div class="card-body mb-1">
        <h5 class="card-title">Aspirasi Warga <span>| Hari Ini</span></h5>
        <div id="list" class="list-group scroll">
            @foreach($aspirasis as $data)
            <div class="list-group-item">
                <div class="row">
                    <div class="col-lg-1">
                        <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                            <i class="bi bi-chat-text"></i>
                        </div>
                    </div>
                    <div class="col-lg-10 align-items-center justify-content-center">
                        <h6><strong>{{$data->nama}} </strong> <span>| Kategori : {{$data->jenis_aspirasi}} </span> &nbsp
                            @if($data->status == 'dibaca')
                            <span class="badge rounded-pill bg-success">Sudah Dibaca</span>
                            @else
                            <span class="badge rounded-pill bg-danger">Belum Dibaca</span>
                            @endif
                        </h6>
                        <h6>{{ \Illuminate\Support\Str::limit($data->aspirasi, 100, $end='...') }}</h6>

                    </div>
                    <div class="col-lg-1 d-flex align-items-center justify-content-center">
                        <button data-bs-toggle="modal" data-bs-target="#updateModal" wire:click="edit({{ $data->id }})" class="btn btn-sm btn-primary d-flex align-items-center justify-content-center">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
            </div>
            @endforeach
        </div>
    </div>
</div>
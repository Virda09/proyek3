@extends('layouts.app')

@section('main-content')
<div class="content">
    <div class="d-sm-flex align-items-center justify-content-between">
        <div class="pagetitle">
            <h1>Iuran Warga</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="{{Route('home')}}">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="{{Route('iuran.index')}}">Iuran Warga</a></li>
                    <li class="breadcrumb-item active">Detail Iuran</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <div class="card recent-sales overflow-auto">

                <div class="card-body">
                    <div class="card-title">
                        <div class="d-sm-flex align-items-center justify-content-between">
                            <h5>Iuran Warga</h5>
                        </div>
                    </div>

                    <table class="table table-borderless datatable">
                        <thead>
                            <tr>
                                <th scope="col">No</th>
                                <th scope="col">Tanggal Bayar</th>
                                <th scope="col">Nominal</th>
                                <th scope="col">Status</th>
                                <th scope="col">Bukti</th>
                                <th scope="col">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse ($iuran as $data)
                            <tr>
                                <td scope="row">{{ $loop->iteration }}</td>
                                <td>{{ $data->tgl_bayar }}</td>
                                <td>{{ $data->nominal}}</td>
                                <td>
                                    @if($data->status == 'belum dilihat')
                                    <span class="badge rounded-pill bg-primary">Belum Divalidasi</span>
                                    @elseif($data->status == 'terima')
                                    <span class="badge rounded-pill bg-success">Diterima</span>
                                    @else
                                    <span class="badge rounded-pill bg-danger">Ditolak</span>
                                    @endif
                                </td>
                                <td>
                                    <div class="align-items-center justify-content-center">
                                        <button type="submit" class="btn btn-sm btn-primary d-flex align-items-center justify-content-center" data-bs-toggle="modal" data-bs-target="#ShowModal">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                    </div>
                                </td>
                                <td>
                                    <div class="align-items-center justify-content-around">
                                        <a href="{{ route('iuran.terima', Crypt::encrypt($data->id)) }}" class="btn btn-sm btn-success">
                                            <i class="bi bi-check"></i>
                                        </a>
                                        <a href="{{ route('iuran.tolak', Crypt::encrypt($data->id)) }}" class="btn btn-sm btn-danger">
                                            <i class="bi bi-x"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <div class="modal fade" id="ShowModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalLabel">Bukti Iuran</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <img id="preview" src="{{ asset('storage/'.$data->bukti) }}" width="200px" height="200px" />
                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                                        </div>
                                    </div>
                                </div>
                                @empty
                                <tr>
                                    <td colspan="4">Data Tidak Ditemukan</td>
                                </tr>
                                @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
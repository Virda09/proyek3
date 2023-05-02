@extends('layouts.app')

@section('main-content')
<div class="content">
  <div class="d-sm-flex align-items-center justify-content-between">
    <div class="pagetitle">
      <h1>Aspirasi</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="{{Route('home')}}">Dashboard</a></li>
          <li class="breadcrumb-item active">Aspirasi</li>
        </ol>
      </nav>
    </div>
    <div class="dropdown">
      <a class="icon" data-bs-toggle="dropdown"><button type="button" class="btn btn-primary"><i class="bi bi-printer-fill me-1"></i> Cetak</button></a>
      <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
        <li><a class="dropdown-item" href="{{Route('aspirasi.cetak','bulan ini')}}">Bulan Ini</a></li>
        <li><a class="dropdown-item" href="{{Route('aspirasi.cetak','kemarin')}}">Bulan Sebelumnya</a></li>
      </ul>
    </div>
  </div>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="filter">
          <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
            <li class="dropdown-header text-start">
              <h6>Filter</h6>
            </li>

            <li><a class="dropdown-item" href="{{Route('aspirasi.filter','hari ini')}}">Hari Ini</a></li>
            <li><a class="dropdown-item" href="{{Route('aspirasi.filter','bulan ini')}}">Bulan Ini</a></li>
            <li><a class="dropdown-item" href="{{Route('aspirasi.filter','tahun ini')}}">Tahun Ini</a></li>
          </ul>
        </div>
        <div class="card-body mb-1">
          <h5 class="card-title">Aspirasi Warga <span>| {{Session('filter')}}</span></h5>
          <table class="table table-borderless datatable">
            <thead>
              <tr>
                <th scope="col">No</th>
                <th scope="col">Pengirim</th>
                <th scope="col">kategori</th>
                <th scope="col">Tanggal</th>
                <th scope="col">Status</th>
                <th scope="col">Aksi</th>
              </tr>
            </thead>
            <tbody>
              @forelse ($aspirasi as $data)
              <tr>
                <td scope="row">{{ $loop->iteration }}</td>
                <td>{{ $data->nama }}</td>
                <td>{{ $data->jenis_aspirasi}}</td>
                <td>{{ $data->created_at}}</td>
                <td>
                  @if($data->status == 'dibaca')
                  <span class="badge rounded-pill bg-success">Sudah Dibaca</span>
                  @else
                  <span class="badge rounded-pill bg-danger">Belum Dibaca</span>
                  @endif
                </td>
                <td>
                  <button type="submit" class="btn btn-sm btn-primary d-flex align-items-center justify-content-center" data-bs-toggle="modal" data-bs-target="#ShowModal-{{$data->id}}">
                    <i class="bi bi-eye"></i>
                  </button>
                </td>
              </tr>
              <div class="modal fade" id="ShowModal-{{$data->id}}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h1 class="modal-title fs-5" id="exampleModalLabel">Aspirasi Warga</h1>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      <div class="row">
                        <div class="col">
                          <p>Kategori : {{$data->jenis_aspirasi}}</p>
                        </div>
                        <div class="col">
                          <p style="text-align: right; color: grey;">{{$data->created_at}}</p>
                        </div>
                      </div>
                      <p style="text-align: justify; text-indent: 45px;">{{$data->aspirasi}}</p>
                      </br>
                      <p style="text-align: right; padding-right: 5px;">Penulis : {{$data->nama}}</p>
                    </div>
                    <div class="modal-footer">
                      <a class="btn btn-secondary" href="{{ route('aspirasi.update', Crypt::encrypt($data->id)) }}" onclick="event.preventDefault(); document.getElementById('logout-form-{{$data->id}}').submit();">{{ __('Tutup')}}</a>
                      <form id="logout-form-{{$data->id}}" action="{{ route('aspirasi.update', Crypt::encrypt($data->id)) }}" method="POST" style="display: none;">
                        {{ csrf_field() }}
                        {{ method_field('PUT') }}
                      </form>
                    </div>
                  </div>
                </div>
              </div>
              @empty
              <tr>
                <td colspan="6">Data Tidak Ditemukan</td>
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
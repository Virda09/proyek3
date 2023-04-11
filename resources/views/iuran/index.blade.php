@extends('layouts.app')

@section('main-content')
<div class="content">
  <div class="d-sm-flex align-items-center justify-content-between">
    <div class="pagetitle">
      <h1>Iuran Warga</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="{{Route('home')}}">Dashboard</a></li>
          <li class="breadcrumb-item active">Iuran Warga</li>
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
                <th scope="col">Warga</th>
                <th scope="col">Belum Validasi</th>
                <th scope="col">Aksi</th>
              </tr>
            </thead>
            <tbody>
              @forelse ($iuran as $data)
              <tr>
                <td scope="row">{{ $loop->iteration }}</td>
                <td>{{ $data->nama_lengkap }}</td>
                <td>{{ $data->validasi}}</td>
                <td>
                  <a href="{{ route('iuran.show', Crypt::encrypt($data->id)) }}" class="btn btn-sm btn-primary">
                    <i class="bi bi-eye"></i>
                  </a>
                </td>
              </tr>
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
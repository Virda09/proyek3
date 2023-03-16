@extends('layouts.app')

@section('main-content')
<div class="content">
  <div class="d-sm-flex align-items-center justify-content-between">
    <div class="pagetitle">
      <h1>Koordinator</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="{{Route('home')}}">Dashboard</a></li>
          <li class="breadcrumb-item active">Koordinator</li>
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
              <h5>Koordinator</h5>
              <a href="{{ route('koordinator.create') }}" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fa fa-plus-circle fa-sm text-white mr-2"></i>Tambah Data</a>
            </div>
          </div>

          <table class="table table-borderless datatable">
            <thead>
              <tr>
                <th scope="col">No</th>
                <th scope="col">Nama</th>
                <th scope="col">Username</th>
                <th scope="col">Aksi</th>
              </tr>
            </thead>
            <tbody>
              @forelse ($user as $data)
              <tr>
                <td scope="row">{{ $loop->iteration }}</td>
                <td>{{ $data->username }}</td>
                <td>{{ $data->nama }}</td>
                <td>
                  <div class="d-sm-flex align-items-center justify-content-around">
                      <a href="{{ route('koordinator.edit', Crypt::encrypt($data->id)) }}" class="btn btn-sm btn-primary">
                        <i class="bi bi-pencil"></i>
                      </a>
                      <form action="{{ route('koordinator.destroy', Crypt::encrypt($data->id)) }}" method="post">
                        @csrf
                        @method('delete')
                        <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Anda yakin ingin menghapus data ini?')"><i class="bi bi-trash"></i></button>
                      </form>
                  </div>
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
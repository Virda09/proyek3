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

            <li><a class="dropdown-item" href="#">Today</a></li>
            <li><a class="dropdown-item" href="#">This Month</a></li>
            <li><a class="dropdown-item" href="#">This Year</a></li>
          </ul>
        </div>
        <div class="card-body mb-1">
          <h5 class="card-title">Aspirasi Warga <span>| Hari Ini</span></h5>
          <div id="list" class="list-group scroll">
            @forelse($aspirasi as $data)
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
                  <h6>{{$data->aspirasi}}</h6>

                </div>
                <div class="col-lg-1 d-flex align-items-center justify-content-center">
                  <button type="submit" class="btn btn-sm btn-primary d-flex align-items-center justify-content-center" data-bs-toggle="modal" data-bs-target="#ShowModal">
                    <i class="bi bi-eye"></i>
                  </button>
                </div>
              </div>
            </div>

            <div class="modal fade" id="ShowModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                  <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Aspirasi Warga</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    {{$data->aspirasi}}
                  </div>
                  <div class="modal-footer">
                    <!-- <a href="{{ route('aspirasi.edit', Crypt::encrypt($data->id)) }}" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</a> -->
                    <a class="btn btn-secondary" href="{{ route('aspirasi.update', Crypt::encrypt($data->id)) }}" onclick="event.preventDefault(); document.getElementById('logout-form').submit();">{{ __('Tutup') }}</a>
                    <form id="logout-form" action="{{ route('aspirasi.update', Crypt::encrypt($data->id)) }}" method="POST" style="display: none;">
                      {{ csrf_field() }}
                      {{ method_field('PUT') }}
                    </form>
                  </div>
                </div>
              </div>
            </div>
            @empty

            @endforelse
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
@endsection
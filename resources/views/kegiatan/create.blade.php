@extends('layouts.app')

@section('main-content')
<div class="content">
    <div class="d-sm-flex align-items-center justify-content-between">
        <div class="pagetitle">
            <h1>Kegiatan - Tambah</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="{{Route('home')}}">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="{{Route('kegiatan.index')}}">Kegiatan</a></li>
                    <li class="breadcrumb-item active">Tambah</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <form action="{{route('kegiatan.store')}}" method="POST" enctype="multipart/form-data" class="row g-3 needs-validation">
            {{ csrf_field() }}
            <!-- <div class="col-lg-4 order-lg-2">
                <div class="card">
                    <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
                        
                        <img id="preview" src="{{ asset('images/preview.png') }}" class="rounded-circle" width="200px" height="200px" />                      
                        <div class="card-body mt-3">
                        <input accept="image/*" type='file' id="photo" class="form-control " name="photo" value="{{ old('photo') }}" required/>
                            @if ($errors->has('photo'))
                            <span class="invalid-feedback">{{ $errors->first('photo') }}</span>
                            @endif
                        </div>
                    </div>
                </div>
            </div> -->
            <div class="col-lg-8 order-lg-1">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Tambah Data</h5>
                        @include('layouts.components.flash')
                        <div class="row mb-3">
                            <div class="col-lg-12">
                                <label for="nama" class="form-label">Nama Kegiatan</label>
                                <input name="nama" type="text" class="form-control" id="nama" require placeholder="Nama Kegiatan" value="{{old('nama')}}">
                                @if ($errors->has('nama'))
                                <span class="invalid-feedback">{{ $errors->first('nama') }}</span>
                                @endif
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-lg-12">
                                <label for="tanggal_kegiatan" class="form-label">Tanggal Kegiatan</label>
                                <input name="tanggal_kegiatan" type="datetime" class="form-control" require id="tanggal_kegiatan" placeholder="Tanggal Kegiatan" value="{{old('tanggal_kegiatan')}}">
                                @if ($errors->has('tanggal_kegiatan'))
                                <span class="invalid-feedback">{{ $errors->first('tanggal_kegiatan') }}</span>
                                @endif
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-lg-12">
                                <label for="deskripsi" class="form-label">Deskripsi</label>
                                <textarea name="deskripsi" placeholder="Deskripsi Kegiatan" require class="form-control" id="deskripsi">{{old('deskripsi')}}</textarea>
                                @if ($errors->has('deskripsi'))
                                <span class="invalid-feedback">{{ $errors->first('deskripsi') }}</span>
                                @endif
                            </div>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">Simpan</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
@endsection
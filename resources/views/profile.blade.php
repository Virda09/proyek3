@extends('layouts.app')

@section('main-content')
<div class="content">
    <div class="d-sm-flex align-items-center justify-content-between">
        <div class="pagetitle">
            <h1>Edit Profile</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="{{Route('home')}}">Home</a></li>
                    <li class="breadcrumb-item active">Ubah Password</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <form action="{{route('profile.update', Crypt::encrypt($data->id))}}" method="POST" enctype="multipart/form-data" class="row g-3 needs-validation">
            {{ csrf_field() }}
            {{ method_field('PUT') }}
            <div class="col-lg-8 order-lg-1">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Edit Profile</h5>
                        @include('layouts.components.flash')
                        <input id="id" type="hidden" class="form-control" name="id" value="{{ $data->id }}">
                        <div class="row mb-3">
                            <div class="col-lg-4">
                                <label for="current_password" class="form-label">Password Lama</label>
                                <input name="current_password" type="password" class="form-control" placeholder="Password Lama" id="current_password">
                                @if ($errors->has('password'))
                                <span class="invalid-feedback">{{ $errors->first('password') }}</span>
                                @endif
                            </div>
                            <div class="col-lg-4">
                                <label class="form-label" for="new_password">Password Baru</label>
                                <input type="password" id="new_password" class="form-control" name="new_password" placeholder="Password Baru">
                                @if ($errors->has('new_password'))
                                <span class="invalid-feedback">{{ $errors->first('new_password') }}</span>
                                @endif
                            </div>
                            <div class="col-lg-4">
                                <label for="password-confirm" class="form-label">Konfirmasi Password</label>
                                <input type="password" id="password-confirm" class="form-control" placeholder="Konfirmasi password" name="password_confirmation" autocomplete="password">
                                @if ($errors->has('password-confirm'))
                                <span class="invalid-feedback">{{ $errors->first('password-confirm') }}</span>
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
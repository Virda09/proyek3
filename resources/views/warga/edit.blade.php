@extends('layouts.app')

@section('main-content')
<div class="content">
    <div class="d-sm-flex align-items-center justify-content-between">
        <div class="pagetitle">
            <h1>Warga - Edit</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="{{Route('home')}}">Home</a></li>
                    <li class="breadcrumb-item"><a href="{{Route('warga.index')}}">Warga</a></li>
                    <li class="breadcrumb-item active">Edit</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="row">
        <form action="{{route('warga.update', Crypt::encrypt($data->id))}}" method="POST" enctype="multipart/form-data" class="row g-3 needs-validation">
            {{ csrf_field() }}
            {{ method_field('PUT') }}
            <div class="col-lg-4 order-lg-2">
                <div class="card">
                    <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
                        <img id="preview" src="{{ $data->photo == null ? asset('images/preview.png') : asset('storage/'.$data->photo) }}" class="rounded-circle" width="200px" height="200px" />
                        <div class="card-body mt-3">
                            <input accept="image/*" type='file' id="photo" class="form-control " name="photo" value="{{ old('photo') }}" />
                            @if ($errors->has('photo'))
                            <span class="invalid-feedback">{{ $errors->first('photo') }}</span>
                            @endif
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-8 order-lg-1">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Edit Data</h5>
                        @include('layouts.components.flash')
                        <input id="id" type="hidden" class="form-control" name="id" value="{{ $data->id }}">
                        <input id="id_user" type="hidden" class="form-control" name="id_user" value="{{ $data->id_user }}">
                        <div class="row mb-3">
                            <div class="col-lg-12">
                                <label for="nama_lengkap" class="form-label">Nama Lengkap</label>
                                <input name="nama_lengkap" type="text" class="form-control" id="nama_lengkap" require placeholder="Nama Lengkap" value="{{$data->nama_lengkap}}">
                                @if ($errors->has('nama_lengkap'))
                                <span class="invalid-feedback">{{ $errors->first('nama_lengkap') }}</span>
                                @endif
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-lg-12">
                                <label for="alamat" class="form-label">Alamat</label>
                                <textarea name="alamat" placeholder="Alamat" require class="form-control" id="alamat">{{$data->alamat}}</textarea>
                                @if ($errors->has('alamat'))
                                <span class="invalid-feedback">{{ $errors->first('alamat') }}</span>
                                @endif
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-lg-12">
                                <label for="pekerjaan" class="form-label">Pekerjaan</label>
                                <input name="pekerjaan" type="text" class="form-control" require id="pekerjaan" placeholder="Pekerjaan" value="{{$data->pekerjaan}}">
                                @if ($errors->has('pekerjaan'))
                                <span class="invalid-feedback">{{ $errors->first('pekerjaan') }}</span>
                                @endif
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-lg-12">
                                <div class="form-group{{ $errors->has('agama') ? ' has-error' : '' }}">
                                    <label for="agama" class="form-label">Agama</label>
                                    <select class="form-control" name="agama" required="">
                                        <option value="Islam" {{$data->agama == 'Islam' ? 'selected' : ''}}>Islam</option>
                                        <option value="Kristen" {{$data->agama == 'Kristen' ? 'selected' : ''}}>Kristen</option>
                                        <option value="Hindu" {{$data->agama == 'Hindu' ? 'selected' : ''}}>Hindu</option>
                                        <option value="Buddha" {{$data->agama == 'Buddha' ? 'selected' : ''}}>Buddha</option>
                                        <option value="Kong Hu Chu" {{$data->agama == 'Kong Hu Chu' ? 'selected' : ''}}>Kong Hu Chu</option>
                                    </select>
                                    @if ($errors->has('agama'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('agama') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-lg-6">
                                <label for="tempat_lahir" class="form-label">Tempat Lahir</label>
                                <input name="tempat_lahir" type="text" class="form-control" require placeholder="Tempat Lahir" id="tempat_lahir" value="{{$data->tempat_lahir}}">
                                @if ($errors->has('tempat_lahir'))
                                <span class="invalid-feedback">{{ $errors->first('tempat_lahir') }}</span>
                                @endif
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group{{ $errors->has('tanggal_lahir') ? ' has-error' : '' }}">
                                    <label for="tanggal_lahir" class=" form-label">Tanggal Lahir</label>
                                    <input id="tanggal_lahir" type="date" class="form-control" name="tanggal_lahir" value="{{ $data->tanggal_lahir }}" required>
                                    @if ($errors->has('tanggal_lahir'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('tanggal_lahir') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-lg-6">
                                <div class="form-group{{ $errors->has('jenis_kelamin') ? ' has-error' : '' }}">
                                    <label for="dender" class="  form-label">Jenis Kelamin</label>
                                    <select class="form-control" name="jenis_kelamin">
                                        <option value="laki-laki" {{$data->jenis_kelamin == 'laki-laki' ? 'selected' : ''}}>Laki - Laki</option>
                                        <option value="perempuan" {{$data->jenis_kelamin == 'perempuan' ? 'selected' : ''}}>Perempuan</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group{{ $errors->has('status') ? ' has-error' : '' }}">
                                    <label for="dender" class="  form-label">Jenis Kelamin</label>
                                    <select class="form-control" name="status">
                                        <option value="Menikah" {{$data->status == 'Menikah' ? 'selected' : ''}}>Menikah</option>
                                        <option value="Belum Menikah" {{$data->status == 'Belum Menikah' ? 'selected' : ''}}>Belum Menikah</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-lg-12">
                                <label for="telepon" class="form-label">No. Telephone</label>
                                <input name="telepon" type="text" class="form-control" require placeholder="No. Telephone" id="telepon" value="{{$data->telepon}}">
                                @if ($errors->has('telepon'))
                                <span class="invalid-feedback">{{ $errors->first('telepon') }}</span>
                                @endif
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-lg-12">
                                <label for="username" class="form-label">Username</label>
                                <input name="username" type="text" placeholder="Username" require class="form-control" id="username" value="{{ $username }}">
                                @if ($errors->has('username'))
                                <span class="invalid-feedback">{{ $errors->first('username') }}</span>
                                @endif
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-lg-6">
                                <label for="password" class="form-label">Password</label>
                                <input name="password" type="password" class="form-control" placeholder="Password" id="password">
                                @if ($errors->has('password'))
                                <span class="invalid-feedback">{{ $errors->first('password') }}</span>
                                @endif
                            </div>
                            <div class="col-lg-6">
                                <label for="password-confirm" class="form-label">Konfirmasi Password</label>
                                <input type="password" id="password-confirm" class="form-control" name="password_confirmation" autocomplete="password">
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
@push('scripts')
<script>
    photo.onchange = evt => {
        const [file] = photo.files
        if (file) {
            preview.src = URL.createObjectURL(file)
        }
    }
</script>
@endpush
@endsection
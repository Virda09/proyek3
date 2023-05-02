@extends('layouts.app')

@section('main-content')
<div class="pagetitle">
    <h1>Dashboard</h1>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item">Home</li>
            <li class="breadcrumb-item active">Dashboard</li>
        </ol>
    </nav>
</div><!-- End Page Title -->

<section class="section dashboard">
    <div class="row">

        <!-- Left side columns -->
        <div class="col-lg-8">
            <div class="row">

                <!-- Sales Card -->
                <div class="col-xxl-4 col-md-6">
                    <div class="card info-card customers-card">
                        <div class="card-body">
                            <h5 class="card-title">Warga <span>| Saat Ini </span></h5>

                            <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                    <i class="bi bi-people"></i>
                                </div>
                                <div class="ps-3">
                                    <h6>{{$warga}}</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- End Sales Card -->

                <!-- Revenue Card -->
                <div class="col-xxl-4 col-md-6">
                    <div class="card info-card revenue-card">

                        <div class="card-body">
                            <h5 class="card-title">Aspirasi <span>| Beum Dilihat</span></h5>

                            <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                    <i class="bi bi-chat-text"></i>
                                </div>
                                <div class="ps-3">
                                    <h6>{{$aspirasi}}</h6>
                                </div>
                            </div>
                        </div>

                    </div>
                </div><!-- End Revenue Card -->

                <!-- Customers Card -->
                <div class="col-xxl-4 col-xl-12">

                    <div class="card info-card sales-card">
                        <div class="card-body">
                            <h5 class="card-title">Iuran <span>| Belum Dilihat</span></h5>

                            <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                    <i class="bi bi-currency-dollar"></i>
                                </div>
                                <div class="ps-3">
                                    <h6>{{$iuran}}</h6>
                                </div>
                            </div>
                        </div>
                    </div>

                </div><!-- End Customers Card -->

            </div>
        </div><!-- End Left side columns -->

        <!-- Right side columns -->
        <div class="col-lg-4">

            <!-- Recent Activity -->
            <div class="card">

                <div class="card-body">
                    <h5 class="card-title">Kegiatan <span>| Akan Datang</span></h5>

                    <div class="activity">
                        @forelse($kegiatan as $data)
                        <div class="activity-item d-flex">
                            <div class="activite-label">@php $date = new DateTime($data->tanggal_kegiatan); echo $date->format('d M Y'); @endphp </div>
                            <i class="bi bi-circle-fill activity-badge text-success align-self-start"></i>
                            <div class="activity-content">
                                {{$data->nama}}
                            </div>
                        </div>
                        @empty
                        <div class="activity-content">
                            Tidak Ada Kegiatan
                        </div>
                        @endforelse
                    </div>

                </div>
            </div><!-- End Recent Activity -->

        </div><!-- End Right side columns -->

    </div>
</section>
@endsection
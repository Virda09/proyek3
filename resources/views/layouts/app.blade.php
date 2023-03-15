@extends('layouts.asset')

@section('body')
<!-- ======= Header ======= -->
@include('layouts.components.header')
<!-- End Header -->

<!-- ======= Sidebar ======= -->
@include('layouts.components.sidebar')
<!-- End Sidebar-->

<main id="main" class="main">

    <section class="section dashboard">
        @yield('main-content')
    </section>

</main><!-- End #main -->

<!-- ======= Footer ======= -->

<!-- End Footer -->
<div class="modal fade" id="logoutModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">{{ __('Ready to Leave?') }}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">Anda yakin ingin Logout?</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                <a class="btn btn-danger" href="{{ route('logout') }}" onclick="event.preventDefault(); document.getElementById('logout-form').submit();">{{ __('Logout') }}</a>
                <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                    @csrf
                </form>
            </div>
        </div>
    </div>
</div>
@endsection
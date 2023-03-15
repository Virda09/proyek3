<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
            <a class="nav-link {{ Route::current()->getName()=='home' ? '' : 'collapsed' }}" href="{{route('home')}}">
                <i class="bi bi-grid"></i>
                <span>Dashboard</span>
            </a>
        </li><!-- End Dashboard Nav -->
        <li class="nav-item">
            <a class="nav-link {{ Route::current()->getName()=='warga.index' ? '' : 'collapsed' }}" href="{{ route('warga.index') }}">
                <i class="bi bi-person"></i>
                <span>Warga</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{ Route::current()->getName()=='koordinator.index' ? '' : 'collapsed' }}" href="{{ route('koordinator.index') }}">
                <i class="bi bi-person"></i>
                <span>Koordinator</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{ Route::current()->getName()=='aspirasi.index' ? '' : 'collapsed' }}" href="{{ route('aspirasi.index') }}">
                <i class="bi bi-person"></i>
                <span>Aspirasi</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{ Route::current()->getName()=='iuran.index' ? '' : 'collapsed' }}" href="{{ route('iuran.index') }}">
                <i class="bi bi-person"></i>
                <span>Iuran</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{ Route::current()->getName()=='kegiatan.index' ? '' : 'collapsed' }}" href="{{ route('kegiatan.index') }}">
                <i class="bi bi-person"></i>
                <span>Kegiatan</span>
            </a>
        </li>
    </ul>
</aside>
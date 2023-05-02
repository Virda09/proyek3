<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
            <a class="nav-link {{ Route::current()->getName()=='home' ? '' : 'collapsed' }}" href="{{route('home')}}">
                <i class="bi bi-grid"></i>
                <span>Dashboard</span>
            </a>
        </li><!-- End Dashboard Nav -->
        <li class="nav-item">
            <a class="nav-link {{ Route::current()->getName()=='warga.index' ? '' : (Route::current()->getName()=='koordinator.index' ? '' : 'collapsed') }}" data-bs-target="#charts-nav" data-bs-toggle="collapse" href="#" aria-expanded="false">
                <i class="bi bi-person"></i></i><span>User</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="charts-nav" class="nav-content {{ Route::current()->getName()=='warga.index' ? '' : (Route::current()->getName()=='koordinator.index' ? '' : 'collapse') }}" data-bs-parent="#sidebar-nav" style="">
                <li>
                    <a class="nav-link {{ Route::current()->getName()=='warga.index' ? '' : (Route::current()->getName()=='warga.edit' ? '' : 'collapsed') }}" href="{{ route('warga.index') }}">
                        <span>Warga</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link {{ Route::current()->getName()=='koordinator.index' ? '' : (Route::current()->getName()=='koordinator.edit' ? '' : 'collapsed') }}" href="{{ route('koordinator.index') }}">
                        <span>Koordinator</span>
                    </a>
                </li>
            </ul>
        </li>

        <li class="nav-item">
            <a class="nav-link {{ Route::current()->getName()=='aspirasi.index' ? '' : (Route::current()->getName()=='aspirasi.filter' ? '' : 'collapsed') }}" href="{{ route('aspirasi.index') }}">
                <i class="bi bi-chat-text"></i>
                <span>Aspirasi</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{ Route::current()->getName()=='iuran.index' ? '' : (Route::current()->getName()=='iuran.show' ? '' : 'collapsed') }}" href="{{ route('iuran.index') }}">
                <i class="bi bi-currency-dollar"></i>
                <span>Iuran</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{ Route::current()->getName()=='kegiatan.index' ? '' : (Route::current()->getName()=='kegiatan.edit' ? '' : 'collapsed') }}" href="{{ route('kegiatan.index') }}">
                <i class="bi bi-activity"></i>
                <span>Kegiatan</span>
            </a>
        </li>
    </ul>
</aside>
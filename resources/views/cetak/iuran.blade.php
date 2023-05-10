<!DOCTYPE html>
<html>

<head>
    <title>Data Iuran Warga</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>

<body>
    <center><h1>{{ $title }}</h1></center>
    <center><p>{{ $date }}</p></center>
    <table class="table table-bordered">
        <tr>
            <th>No</th>
            <th>Nama</th>
            <th>Tanggal Submit</th>
            <th>Nominal</th>
            <th>Status</th>
        </tr>
        @forelse($iuran as $data)
        <tr>
            <td scope="row">{{ $loop->iteration }}</td>
            <td>{{ $data->nama_lengkap }}</td>
            <td>{{ $data->created_at}}</td>
            <td>{{ $data->nominal}}</td>
            <td> @if($data->status == 'belum dilihat')
                <span class="badge rounded-pill bg-primary">Belum Divalidasi</span>
                @elseif($data->status == 'terima')
                <span class="badge rounded-pill bg-success">Diterima</span>
                @else
                <span class="badge rounded-pill bg-danger">Ditolak</span>
                @endif
            </td>
        </tr>
        @empty
        <tr>
            <td colspan="5">Data Tidak Ditemukan</td>
        </tr>
        @endforelse
    </table>
</body>

</html>
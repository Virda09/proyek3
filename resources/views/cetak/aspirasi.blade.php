<!DOCTYPE html>
<html>

<head>
    <title>Data Aspirasi Warga</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>

<body>
    <h1>{{ $title }}</h1>
    <p>{{ $date }}</p>
    <table class="table table-bordered">
        <tr>
            <th>No</th>
            <th>Nama</th>
            <th>Tanggal</th>
            <th>Kategori</th>
            <th>Aspirasi</th>
        </tr>
        @forelse($aspirasi as $data)
        <tr>
            <td scope="row">{{ $loop->iteration }}</td>
            <td>{{ $data->nama }}</td>
            <td>{{ $data->created_at}}</td>
            <td>{{ $data->jenis_aspirasi}}</td>
            <td>{{ $data->aspirasi}}</td>
        </tr>
        @empty
        <tr>
            <td colspan="5">Data Tidak Ditemukan</td>
        </tr>
        @endforelse
    </table>
</body>

</html>
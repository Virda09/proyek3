// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Warga {
  int? id;
  String nama_lengkap;
  String tempat_lahir;
  String tanggal_lahir;
  String jenis_kelamin;
  String alamat;
  String agama;
  String status;
  String pekerjaan;
  String photo;
  String telepon;
  String? username;
  String? password;

  Warga({
    this.id,
    required this.nama_lengkap,
    required this.tempat_lahir,
    required this.tanggal_lahir,
    required this.jenis_kelamin,
    required this.alamat,
    required this.agama,
    required this.status,
    required this.pekerjaan,
    required this.photo,
    required this.telepon,
    this.username,
    this.password,
  });

  factory Warga.fromJson(Map<String, dynamic> map) {
    return Warga(
      id: map["id"],
      nama_lengkap: map["nama_lengkap"],
      tempat_lahir: map["tempat_lahir"],
      tanggal_lahir: map["tanggal_lahir"],
      jenis_kelamin: map["jenis_kelamin"],
      alamat: map["alamat"],
      agama: map["agama"],
      status: map["status"],
      pekerjaan: map["pekerjaan"],
      photo: map["photo"],
      telepon: map["telepon"],
      username: map["username"],
      password: map["password"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama_lengkap": nama_lengkap,
      "tempat_lahir": tempat_lahir,
      "tanggal_lahir": tanggal_lahir,
      "jenis_kelamin": jenis_kelamin,
      "alamat": alamat,
      "agama": agama,
      "status": status,
      "pekerjaan": pekerjaan,
      "photo": photo,
      "telepon": telepon,
      "username": username,
      "password": password,
    };
  }
}

List<Warga> WargaFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Warga>.from(data['data'].map((item) => Warga.fromJson(item)));
}

String WargaToJson(Warga data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

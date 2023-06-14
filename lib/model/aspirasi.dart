// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Aspirasi {
  String aspirasi, status, nama;
  int id_warga;
  String? created_at,method, jenis_aspirasi;
  int? id;

  Aspirasi({required this.id_warga, required this.nama, required this.aspirasi, this.jenis_aspirasi, required this.status, this.created_at,this.id,this.method});

  factory Aspirasi.fromJson(Map<String, dynamic> map) {
    return Aspirasi(
      id: map["id"],
        id_warga: map["id_warga"],
        nama: map["nama"],
        aspirasi: map["aspirasi"],
        jenis_aspirasi: map["jenis_aspirasi"],
        status: map["status"],
        created_at: map['created_at'],
        method: map['_method']
        );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "id_warga": id_warga,
      "nama": nama,
      "aspirasi": aspirasi,
      "jenis_aspirasi": jenis_aspirasi,
      "status": status,
      "created_at": created_at,
      "_method": method
    };
  }
}

List<Aspirasi> AspirasiFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Aspirasi>.from(
      data['data'].map((item) => Aspirasi.fromJson(item)));
}

String AspirasiToJson(Aspirasi data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

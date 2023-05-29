// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Activity {
  String tanggal_kegiatan,nama, deskripsi;
  int? id;
  String? method,created_at;

  Activity({required this.tanggal_kegiatan, required this.nama, required this.deskripsi, this.created_at,this.id,this.method});

  factory Activity.fromJson(Map<String, dynamic> map) {
    return Activity(
      id: map["id"],
        tanggal_kegiatan: map["tanggal_kegiatan"],
        nama: map["nama"],
        deskripsi: map["deskripsi"],
        created_at: map['created_at'],
        method: map['_method'],
        );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "tanggal_kegiatan": tanggal_kegiatan,
      "nama": nama,
      "deskripsi": deskripsi,
      "created_at": created_at,
      "_method": method
    };
  }
}

List<Activity> ActivityFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Activity>.from(
      data['data'].map((item) => Activity.fromJson(item)));
}

String ActivityToJson(Activity data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

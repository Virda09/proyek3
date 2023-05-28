// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Iuran {
  String nominal, status,bukti;
  int id_warga;
  String? created_at,method;
  int? id;

  Iuran({required this.id_warga, required this.nominal, required this.status, this.created_at,this.id,this.method,required this.bukti});

  factory Iuran.fromJson(Map<String, dynamic> map) {
    return Iuran(
      id: map["id"],
        id_warga: map["id_warga"],
        nominal: map["nominal"],
        status: map["status"],
        created_at: map['created_at'],
        method: map['_method'],
        bukti: map['bukti']
        );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "id_warga": id_warga,
      "nominal": nominal,
      "status": status,
      "created_at": created_at,
      "bukti": bukti,
      "_method": method
    };
  }
}

List<Iuran> IuranFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Iuran>.from(
      data['data'].map((item) => Iuran.fromJson(item)));
}

String IuranToJson(Iuran data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

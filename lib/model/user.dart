// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class User {
  int? id;
  String? nama;
  String? username;
  String? password;
  String? role;

  User(
      {
      this.id,
      this.nama,
      this.username,
      this.password,
      this.role});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        id: map["id"],
        nama: map["nama"],
        username: map["username"],
        password: map["password"],
        role: map["role"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama": nama,
      "username": username,
      "password": password,
      "role": role
    };
  }
}

List<User> UserFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<User>.from(data['data'].map((item) => User.fromJson(item)));
}

String UserToJson(User data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

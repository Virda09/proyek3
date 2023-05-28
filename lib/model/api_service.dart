// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:proyek3/model/aspirasi.dart';
import 'package:proyek3/model/iuran.dart';
import 'package:proyek3/model/kegiatan.dart';
import 'package:proyek3/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:proyek3/model/warga.dart';

class ApiService {
  final String baseUrl = "http://192.168.43.166:8080/api";

  String dateFormat(String date) {
    var newStr = '${date.substring(0, 10)} ${date.substring(11, 23)}';
    DateTime dt = DateTime.parse(newStr);
    var result = DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt);
    return result.toString();
  }

  Future<List<User>?> login(User data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"content-type": "application/json"},
      body: UserToJson(data),
    );
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['success']) {
        return UserFromJson(response.body);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> ubahPassword(var data, String id) async {
    final response = await http.put(
      Uri.parse("$baseUrl/user/$id"),
      headers: {"content-type": "application/json"},
      body: json.encode(data),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> registrasi(
      {required File file, required Map<String, String> data}) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/warga"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(await http.MultipartFile.fromPath('photo', file.path,
        contentType: MediaType('image', 'jpeg,png,jpg,gif')));

    request.headers.addAll(headers);
    request.fields.addAll(data);
    // print("request: "+request.toString());
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    // print(response.body);
    if (res.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<List<Warga>> getAkun(String id, String role) async {
    http.Response response;
    if (role == 'warga') {
      response = await http.get(Uri.parse("$baseUrl/warga/$id"));
    } else {
      response = await http.get(Uri.parse("$baseUrl/warga"));
    }
    print(response.statusCode);
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['success']) {
        return WargaFromJson(response.body);
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<bool> editAkun({
    File? file,
    required Map<String, String> data,
  }) async {
    late http.Response response;

    if (file != null) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/updateAkun"),
      );
      Map<String, String> headers = {"Content-type": "multipart/form-data"};

      request.files.add(await http.MultipartFile.fromPath('photo', file.path,
          contentType: MediaType('image', 'jpeg,png,jpg,gif')));
      request.headers.addAll(headers);
      request.fields.addAll(data);
      var res = await request.send();
      response = await http.Response.fromStream(res);
    } else {
      response = await http.post(
        Uri.parse("$baseUrl/updateAkun"),
        headers: {"content-type": "application/json"},
        body: json.encode(data),
      );
    }

    print(response.body);
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<List<Aspirasi>> getAspirasi(String id, String role) async {
    http.Response response;
    if (role == 'warga') {
      response = await http.get(Uri.parse("$baseUrl/list-aspirasi/$id"));
    } else {
      response = await http.get(Uri.parse("$baseUrl/aspirasi"));
    }
    print(response.body);
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['success']) {
        return AspirasiFromJson(response.body);
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<bool> createAspirasi(Aspirasi data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/aspirasi"),
      headers: {"content-type": "application/json"},
      body: AspirasiToJson(data),
    );
    if (response.statusCode == 201) {
      final res = json.decode(response.body);
      if (res['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> editAspirasi(Aspirasi data) async {
    final response = await http.put(
      Uri.parse("$baseUrl/aspirasi/${data.id}"),
      headers: {"content-type": "application/json"},
      body: AspirasiToJson(data),
    );

    print(response.body);
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> deleteAspirasi(String id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/aspirasi/$id"),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<List<Iuran>> getIuran(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/list-iuran/$id"));
    print(response.body);
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['success']) {
        return IuranFromJson(response.body);
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<List<Kegiatan>> getKegiatan() async {
    final response = await http.get(Uri.parse("$baseUrl/kegiatan"));
    print(response.body);
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['success']) {
        return KegiatanFromJson(response.body);
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<bool> createIuran(
      {File? file, required Map<String, String> data}) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/iuran"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(await http.MultipartFile.fromPath('bukti', file!.path,
        contentType: MediaType('image', 'jpeg,png,jpg,gif')));

    request.headers.addAll(headers);
    request.fields.addAll(data);
    // print("request: $request");
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    print(response.body);
    if (res.statusCode == 201) {
      final res = json.decode(response.body);
      if (res['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> editIuran(
      {required File? file, required Map<String, String> data}) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/update-iuran"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('bukti', file.path,
          contentType: MediaType('image', 'jpeg,png,jpg,gif')));
    }
    request.headers.addAll(headers);
    request.fields.addAll(data);
    print("request: $request");
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    print(response.body);
    if (res.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> deleteIuran(String id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/iuran/$id"),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

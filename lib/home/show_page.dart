// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, empty_catches, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:proyek3/color.dart';
import 'package:proyek3/komponents/build_textfield.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/kegiatan.dart';

class ShowPage extends StatefulWidget {
  final Kegiatan? kegiatan;

  const ShowPage({super.key, this.kegiatan});

  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  TextEditingController deskripsi = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    if (widget.kegiatan != null) {
      nama.text = widget.kegiatan!.nama;
      deskripsi.text = widget.kegiatan!.deskripsi;
      tanggal.text = _apiService.dateFormat(widget.kegiatan!.created_at!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'Lihat Detail',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: secondaryColor),
        ),
      ),
      key: _scaffold,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: primaryColor,
            image: DecorationImage(
              opacity: 0.5,
              image: AssetImage('assets/bg2.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          "Detail Kegiatan / Pengumuman",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: BuildTextField(
                                  color: primaryColor,
                                  con: nama,
                                  hint: 'Judul',
                                  icon: Icons.person,
                                  label: 'Judul',
                                  read: "true",
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: BuildTextField(
                                  color: primaryColor,
                                  con: tanggal,
                                  hint: 'Tanggal Dibuat',
                                  icon: Icons.date_range,
                                  label: 'Tanggal Dibuat',
                                  read: "true",
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  readOnly: true,
                                  maxLines: null,
                                  style: TextStyle(color: primaryColor),
                                  controller: deskripsi,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: primaryColor,
                                          width: 2,
                                        )),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    focusColor: primaryColor,
                                    labelText: "Deskripsi",
                                    hintText: "Deskripsi",
                                    labelStyle: TextStyle(
                                      color: primaryColor,
                                    ),
                                    prefixIcon: Icon(Icons.speaker_notes,
                                        color: primaryColor),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

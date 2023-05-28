// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, empty_catches, non_constant_identifier_names


import 'package:flutter/material.dart';
import 'package:proyek3/komponents/build_textfield.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/aspirasi.dart';

class ShowPage extends StatefulWidget {
  final String id_warga;
  final Aspirasi? aspirasi;

  const ShowPage({super.key, required this.id_warga, this.aspirasi});

  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  TextEditingController aspirasi = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController jenis_aspirasi = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    if (widget.aspirasi != null) {
      nama.text = widget.aspirasi!.nama;
      aspirasi.text = widget.aspirasi!.aspirasi;
      jenis_aspirasi.text = widget.aspirasi!.jenis_aspirasi;
      tanggal.text = _apiService.dateFormat(widget.aspirasi!.created_at!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withRed(100),
        elevation: 0,
        title: Text(
          'Data Aspirasi',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      key: _scaffold,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.black.withRed(100)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          "Detail Aspirasi",
                          style: TextStyle(
                            color: Colors.black.withRed(100),
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
                                  color: Colors.black.withRed(100),
                                  con: nama,
                                  hint: 'Nama Inisial',
                                  icon: Icons.person,
                                  label: 'Nama Inisial',
                                  read: "true",
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: BuildTextField(
                                  color: Colors.black.withRed(100),
                                  con: jenis_aspirasi,
                                  hint: 'Jenis Aspirasi',
                                  icon: Icons.speaker_notes,
                                  label: 'Jenis Aspirasi',
                                  read: "true",
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: BuildTextField(
                                  color: Colors.black.withRed(100),
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
                                  style: TextStyle(
                                      color: Colors.black.withRed(100)),
                                  controller: aspirasi,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black.withRed(100),
                                          width: 2,
                                        )),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black.withRed(100),
                                        width: 2,
                                      ),
                                    ),
                                    focusColor: Colors.black.withRed(100),
                                    labelText: "Pesan Aspirasi",
                                    hintText: "Pesan Aspirasi",
                                    labelStyle: TextStyle(
                                      color: Colors.black.withRed(100),
                                    ),
                                    prefixIcon: Icon(Icons.speaker_notes,
                                        color: Colors.black.withRed(100)),
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

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, empty_catches, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:proyek3/color.dart';
import 'package:proyek3/komponents/build_textfield.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/warga.dart';

class ShowWarga extends StatefulWidget {
  final Warga? warga;

  const ShowWarga({super.key, this.warga});

  @override
  State<ShowWarga> createState() => _ShowWargaState();
}

class _ShowWargaState extends State<ShowWarga> {
  TextEditingController nama = TextEditingController();
  TextEditingController pekerjaan = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController tempatLahir = TextEditingController();
  TextEditingController tanggalLahir = TextEditingController();
  TextEditingController telpon = TextEditingController();
  late String image2;
  TextEditingController jenisKelamin = TextEditingController();
  TextEditingController agama = TextEditingController();
  TextEditingController status = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    if (widget.warga != null) {
      nama.text = widget.warga!.nama_lengkap;
      pekerjaan.text = widget.warga!.pekerjaan;
      alamat.text = widget.warga!.alamat;
      tempatLahir.text = widget.warga!.tempat_lahir;
      tanggalLahir.text = widget.warga!.tanggal_lahir;
      telpon.text = widget.warga!.telepon;
      image2 = widget.warga!.photo;
      jenisKelamin.text = widget.warga!.jenis_kelamin;
      agama.text = widget.warga!.agama;
      status.text = widget.warga!.status;
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
          'Info Warga',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: secondaryColor),
        ),
      ),
      key: _scaffold,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: primaryColor,
            image: const DecorationImage(
              opacity: 0.5,
              image: AssetImage('assets/bg2.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      "Data Warga",
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(
                          image2,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: BuildTextField(
                              con: nama,
                              hint: "Nama Lengkap",
                              label: "Nama Lengkap",
                              icon: Icons.person,
                              color: primaryColor,
                              read: "true",
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: BuildTextField(
                              con: tempatLahir,
                              hint: "Tempat Lahir",
                              label: "Tempat Lahir",
                              icon: Icons.location_city,
                              color: primaryColor,
                              read: "true",
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: BuildTextField(
                              con: tanggalLahir,
                              hint: "Tanggal Lahir",
                              label: "Tanggal Lahir",
                              icon: Icons.date_range,
                              color: primaryColor,
                              read: "true",
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: BuildTextField(
                              con: jenisKelamin,
                              hint: "Jenis Kelamin",
                              label: "jenis Kelamin",
                              icon: jenisKelamin.text == "Laki-laki"
                                  ? Icons.male
                                  : Icons.female,
                              color: primaryColor,
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
                              controller: alamat,
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
                                labelText: "Alamat",
                                hintText: "Alamat",
                                labelStyle: TextStyle(
                                  color: primaryColor,
                                ),
                                prefixIcon: Icon(Icons.location_on,
                                    color: primaryColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: BuildTextField(
                              con: agama,
                              hint: "Agama",
                              label: "Agama",
                              icon: agama.text == "Islam"
                                  ? Icons.mosque
                                  : agama.text == "Katolik"
                                      ? Icons.church
                                      : agama.text == "Protestan"
                                          ? Icons.church
                                          : agama.text == "Hindu"
                                              ? Icons.temple_hindu
                                              : agama.text == "Buddha"
                                                  ? Icons.temple_buddhist
                                                  : Icons.temple_buddhist,
                              color: primaryColor,
                              read: "true",
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: BuildTextField(
                              con: status,
                              hint: "Status Perkawinan",
                              label: "Status Perkawinan",
                              icon: status.text == "Menikah"
                                  ? Icons.group
                                  : Icons.person,
                              color: primaryColor,
                              read: "true",
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: BuildTextField(
                              con: telpon,
                              hint: "Telepone",
                              label: "Telepone",
                              icon: Icons.call,
                              color: primaryColor,
                              read: "true",
                            ),
                          ),SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: BuildTextField(
                              con: pekerjaan,
                              hint: "Pekerjaan",
                              label: "Pekerjaan",
                              icon: Icons.work,
                              read: "true",
                              color: primaryColor,
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
          ),
        ),
      ),
    );
  }
}

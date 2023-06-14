// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, empty_catches, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:proyek3/akun/alert.dart';
import 'package:proyek3/aspirasi/aspirasi_page.dart';
import 'package:proyek3/color.dart';
import 'package:proyek3/komponents/build_dropdown.dart';
import 'package:proyek3/komponents/build_textfield.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/aspirasi.dart';

class AddEditPage extends StatefulWidget {
  final String id_warga;
  final Aspirasi? aspirasi;

  const AddEditPage({super.key, required this.id_warga, this.aspirasi});

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _form = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  TextEditingController nama = TextEditingController();
  TextEditingController aspirasi = TextEditingController();

  final Alert alert = Alert();

  // late String jenisAspirasi;

  bool _isLoading = false;

  // List<String> jenis_aspirasi = ["Keamanan", "Kebersihan", 'Ketetanggaan'];

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // jenisAspirasi = jenis_aspirasi[0];
    if (widget.aspirasi != null) {
      // jenisAspirasi = widget.aspirasi!.jenis_aspirasi;
      nama.text = widget.aspirasi!.nama;
      aspirasi.text = widget.aspirasi!.aspirasi;
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
          widget.aspirasi == null ? 'Buat Aspirasi' : "Edit Aspirasi",
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: secondaryColor),
        ),
      ),
      key: _scaffold,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: primaryColor,
              image: const DecorationImage(
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
                            "Form Aspirasi",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Form(
                            key: _form,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: BuildTextField(
                                      con: nama,
                                      hint: "Anonym",
                                      label: "Nama Inisial",
                                      icon: Icons.person,
                                      validasi: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Nama Inisial tidak boleh kosong';
                                        }
                                      },
                                      input: TextInputType.name,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // Padding(
                                  //   padding:
                                  //       EdgeInsets.symmetric(horizontal: 20),
                                  //   child: BuildDropdown(
                                  //     val: jenisAspirasi,
                                  //     hint: "Jenis Aspirasi",
                                  //     label: "Jenis Aspirasi",
                                  //     icon: Icons.speaker_notes_outlined,
                                  //     color: primaryColor,
                                  //     aksi: (val) {
                                  //       setState(() => jenisAspirasi = val!);
                                  //     },
                                  //     item: jenis_aspirasi.map(
                                  //       (String val) {
                                  //         return DropdownMenuItem(
                                  //           value: val,
                                  //           child: Text(val),
                                  //         );
                                  //       },
                                  //     ).toList(),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: TextFormField(
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      style: TextStyle(color: primaryColor),
                                      controller: aspirasi,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: primaryColor,
                                              width: 2,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                        focusColor: primaryColor,
                                        labelText: "Aspirasi",
                                        hintText: "Aspirasi",
                                        labelStyle: TextStyle(
                                          color: primaryColor,
                                        ),
                                        prefixIcon: Icon(Icons.location_on,
                                            color: primaryColor),
                                      ),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Aspirasi tidak boleh kosong!';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  // NOTE: BUTTON REGISTER
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: SizedBox(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          final isValid =
                                              _form.currentState?.validate();
                                          if (!isValid!) {
                                            return;
                                          } else {
                                            setState(() => _isLoading = true);
                                            Aspirasi data = Aspirasi(
                                                id_warga:
                                                    int.parse(widget.id_warga),
                                                nama: nama.text,
                                                aspirasi: aspirasi.text,
                                                status: "Belum Dibaca");
                                            if (widget.aspirasi == null) {
                                              _apiService
                                                  .createAspirasi(data)
                                                  .then(
                                                (isSuccess) {
                                                  setState(
                                                      () => _isLoading = false);
                                                  if (isSuccess) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AspirasiPage(),
                                                      ),
                                                    );
                                                  } else {
                                                    alert.showAlertDialog(
                                                        context,
                                                        "Create Aspirasi Gagal");
                                                  }
                                                },
                                              );
                                            } else {
                                              data.id = widget.aspirasi!.id;
                                              data.method = "PUT";
                                              _apiService
                                                  .editAspirasi(data)
                                                  .then(
                                                (isSuccess) {
                                                  setState(
                                                      () => _isLoading = false);
                                                  if (isSuccess) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AspirasiPage(),
                                                      ),
                                                    );
                                                  } else {
                                                    alert.showAlertDialog(
                                                        context,
                                                        "Update Aspirasi Gagal");
                                                  }
                                                },
                                              );
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(17))),
                                        child: Text("Simpan".toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: secondaryColor)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
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
          _isLoading
              ? Stack(
                  children: [
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                ),
        ],
      ),
    );
  }
}

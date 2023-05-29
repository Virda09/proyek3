// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, empty_catches, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyek3/akun/alert.dart';
import 'package:proyek3/color.dart';
import 'package:proyek3/kegiatan/kegiatan_page.dart';
import 'package:proyek3/komponents/build_textfield.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/kegiatan.dart';

class AddEditPage extends StatefulWidget {
  final Kegiatan? kegiatan;

  const AddEditPage({super.key, this.kegiatan});

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _form = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  TextEditingController nama = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  final Alert alert = Alert();
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (widget.kegiatan != null) {
      deskripsi.text = widget.kegiatan!.deskripsi;
      nama.text = widget.kegiatan!.nama;
      tanggal.text = widget.kegiatan!.tanggal_kegiatan;
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
          widget.kegiatan == null
              ? 'Buat Kegiatan/Berita'
              : "Edit Kegiatan/Berita",
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
                            "Form Kegiatan",
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
                                      hint: "Judul",
                                      label: "Judul",
                                      icon: Icons.local_activity,
                                      validasi: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Judul tidak boleh kosong';
                                        }
                                      },
                                      input: TextInputType.name,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: TextFormField(
                                      style: TextStyle(color: primaryColor),
                                      controller: tanggal,
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101),
                                        );
                                        if (pickedDate != null) {
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          setState(() {
                                            tanggal.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                        }
                                      },
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
                                        labelText: "Tanggal Kegiatan",
                                        labelStyle: TextStyle(
                                          color: primaryColor,
                                        ),
                                        prefixIcon: Icon(Icons.date_range,
                                            color: primaryColor),
                                      ),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Tanggal tidak boleh kosong!';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: TextFormField(
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      style: TextStyle(color: primaryColor),
                                      controller: deskripsi,
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
                                        labelText: "Deskripsi",
                                        hintText: "Deskripsi",
                                        labelStyle: TextStyle(
                                          color: primaryColor,
                                        ),
                                        prefixIcon: Icon(Icons.description,
                                            color: primaryColor),
                                      ),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Deskripsi tidak boleh kosong!';
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
                                            Kegiatan data = Kegiatan(
                                                tanggal_kegiatan: tanggal.text,
                                                nama: nama.text,
                                                deskripsi: deskripsi.text);
                                            if (widget.kegiatan == null) {
                                              _apiService
                                                  .createKegiatan(data)
                                                  .then(
                                                (isSuccess) {
                                                  setState(
                                                      () => _isLoading = false);
                                                  if (isSuccess) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            KegiatanPage(),
                                                      ),
                                                    );
                                                  } else {
                                                    alert.showAlertDialog(
                                                        context,
                                                        "Create Kegiatan Gagal");
                                                  }
                                                },
                                              );
                                            } else {
                                              data.id = widget.kegiatan!.id;
                                              data.method = "PUT";
                                              _apiService
                                                  .editKegiatan(data)
                                                  .then(
                                                (isSuccess) {
                                                  setState(
                                                      () => _isLoading = false);
                                                  if (isSuccess) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            KegiatanPage(),
                                                      ),
                                                    );
                                                  } else {
                                                    alert.showAlertDialog(
                                                        context,
                                                        "Update Kegiatan Gagal");
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

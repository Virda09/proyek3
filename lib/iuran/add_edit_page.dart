// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, empty_catches, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyek3/akun/alert.dart';
import 'package:proyek3/color.dart';
import 'package:proyek3/komponents/build_textfield.dart';
import 'package:proyek3/iuran/iuran_page.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/iuran.dart';

class AddEditPage extends StatefulWidget {
  final String id_warga;
  final Iuran? iuran;

  const AddEditPage({super.key, required this.id_warga, this.iuran});

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _form = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  TextEditingController nominal = TextEditingController();
  final ImagePicker picker = ImagePicker();
  final Alert alert = Alert();
  XFile? image;
  String bukti = "";
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  void myAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text('Please choose media to select'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 7,
            child: Column(
              children: [
                ElevatedButton(
                  //if user click this button, user can upload image from gallery
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Text('From Gallery'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  //if user click this button. user can upload image from camera
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      Text('From Camera'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    if (widget.iuran != null) {
      nominal.text = widget.iuran!.nominal;
      bukti = widget.iuran!.bukti;
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
          widget.iuran == null ? 'Tambah Iuran' : "Edit Iuran",
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: secondaryColor),
        ),
      ),
      key: _scaffold,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                              "Form Iuran",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            bukti != "" || image != null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: image != null
                                            ? Image.file(
                                                //to show image, you type like this.
                                                File(image!.path),
                                                fit: BoxFit.contain,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 300,
                                              )
                                            : Image.network(
                                                //to show image, you type like this.
                                                widget.iuran!.bukti,
                                                fit: BoxFit.contain,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 300,
                                              )),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Container(
                                        color: Colors.grey.shade300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 300,
                                        child: Icon(
                                          Icons.image,
                                          size: 80,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    myAlert();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: Text('Upload Bukti',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: secondaryColor)),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
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
                                        con: nominal,
                                        hint: "Nominal iuran yang dibayar",
                                        label: "Nominal",
                                        icon: Icons.money,
                                        validasi: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Nominal tidak boleh kosong';
                                          }
                                        },
                                        input: TextInputType.number,
                                        color: primaryColor,
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            final isValid =
                                                _form.currentState?.validate();
                                            if (!isValid! &&
                                                (image != null &&
                                                    bukti != "")) {
                                              return;
                                            } else {
                                              setState(() => _isLoading = true);
                                              Map<String, String> data = {
                                                "id_warga": widget.id_warga,
                                                "nominal": nominal.text,
                                                "status": "Belum Dilihat",
                                              };
                                              if (widget.iuran == null) {
                                                _apiService
                                                    .createIuran(
                                                        data: data,
                                                        file: image != null
                                                            ? File(image!.path)
                                                            : null)
                                                    .then(
                                                  (isSuccess) {
                                                    setState(() =>
                                                        _isLoading = false);
                                                    if (isSuccess) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              IuranPage(),
                                                        ),
                                                      );
                                                    } else {
                                                      alert.showAlertDialog(
                                                          context,
                                                          "Create Iuran Gagal");
                                                    }
                                                  },
                                                );
                                              } else {
                                                data['id'] =
                                                    widget.iuran!.id.toString();
                                                _apiService
                                                    .editIuran(
                                                        data: data,
                                                        file: image != null
                                                            ? File(image!.path)
                                                            : null)
                                                    .then(
                                                  (isSuccess) {
                                                    setState(() =>
                                                        _isLoading = false);
                                                    if (isSuccess) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              IuranPage(),
                                                        ),
                                                      );
                                                    } else {
                                                      alert.showAlertDialog(
                                                          context,
                                                          "Update Iuran Gagal");
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
                                                      BorderRadius.circular(
                                                          17))),
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

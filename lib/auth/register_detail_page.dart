// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, empty_catches, non_constant_identifier_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proyek3/auth/login_page.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/komponents/build_textfield.dart';
import 'package:proyek3/komponents/build_dropdown.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class RegisterDetailPage extends StatefulWidget {
  final String user, pass;
  const RegisterDetailPage({super.key, required this.user, required this.pass});

  @override
  State<RegisterDetailPage> createState() => _RegisterDetailPageState();
}

class _RegisterDetailPageState extends State<RegisterDetailPage> {
  final _form = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  TextEditingController nama = TextEditingController();
  TextEditingController pekerjaan = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController tempatLahir = TextEditingController();
  TextEditingController tanggalLahir = TextEditingController();
  TextEditingController telpon = TextEditingController();
  XFile? image;

  final ImagePicker picker = ImagePicker();

  late String jenisKelamin;
  late String agama;
  late String status;

  bool _isLoading = false;

  List<String> status_value = ["Menikah", "Belum Menikah"];
  List<String> jk_value = ["Laki-laki", "Perempuan"];
  List<String> agama_value = [
    "Islam",
    "Protestan",
    "Katolik",
    "Hindu",
    "Buddha",
    "Konghuchu"
  ];

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    tanggalLahir.text = "";
    jenisKelamin = jk_value[0];
    agama = agama_value[0];
    status = status_value[0];
    super.initState();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withRed(100),
        elevation: 0,
        title: Text(
          "REGISTRASI",
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      key: _scaffold,
      body: Stack(
        children: [
          SingleChildScrollView(
            // reverse: true,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withRed(100),
                image: DecorationImage(
                  opacity: 0.5,
                  image: AssetImage('assets/bg2.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
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
                          "Biodata Diri",
                          style: TextStyle(
                            color: Colors.black.withRed(100),
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        image != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    //to show image, you type like this.
                                    File(image!.path),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
                                  ),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      color: Colors.grey.shade300,
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image,
                                            size: 80,
                                            color: Colors.grey.shade500,
                                          ),
                                          Text(
                                            "Foto Profil",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                        SizedBox(
                          height: 10,
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
                                  primary: Colors.black.withRed(100),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17))),
                              child: Text('Upload Foto',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
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
                                      con: nama,
                                      hint: "Nama Lengkap",
                                      label: "Nama Lengkap",
                                      icon: Icons.person,
                                      validasi: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Nama Lengkap tidak boleh kosong';
                                        }
                                      },
                                      input: TextInputType.name,
                                      color: Colors.black.withRed(100),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: BuildTextField(
                                      con: tempatLahir,
                                      hint: "Tempat Lahir",
                                      label: "Tempat Lahir",
                                      icon: Icons.location_city,
                                      validasi: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Tempat Lahir tidak boleh kosong!';
                                        }
                                      },
                                      input: TextInputType.name,
                                      color: Colors.black.withRed(100),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: TextFormField(
                                      style: TextStyle(
                                          color: Colors.black.withRed(100)),
                                      controller: tanggalLahir,
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
                                            tanggalLahir.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black.withRed(100),
                                              width: 2,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.black.withRed(100),
                                            width: 2,
                                          ),
                                        ),
                                        focusColor: Colors.black.withRed(100),
                                        labelText: "Tanggal Lahir",
                                        labelStyle: TextStyle(
                                          color: Colors.black.withRed(100),
                                        ),
                                        prefixIcon: Icon(Icons.date_range,
                                            color: Colors.black.withRed(100)),
                                      ),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Tanggal Lahir tidak boleh kosong!';
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
                                    child: BuildDropdown(
                                      val: jenisKelamin,
                                      hint: "Jenis Kelamin",
                                      label: "Jenis Kelamin",
                                      icon: jenisKelamin == "Laki-laki"
                                          ? Icons.male_sharp
                                          : Icons.female_sharp,
                                      color: Colors.black.withRed(100),
                                      aksi: (val) {
                                        setState(() => jenisKelamin = val!);
                                      },
                                      item: jk_value.map(
                                        (String val) {
                                          return DropdownMenuItem(
                                            value: val,
                                            child: Text(val),
                                          );
                                        },
                                      ).toList(),
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
                                      style: TextStyle(
                                          color: Colors.black.withRed(100)),
                                      controller: alamat,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black.withRed(100),
                                              width: 2,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.black.withRed(100),
                                            width: 2,
                                          ),
                                        ),
                                        focusColor: Colors.black.withRed(100),
                                        labelText: "Alamat",
                                        hintText: "Alamat",
                                        labelStyle: TextStyle(
                                          color: Colors.black.withRed(100),
                                        ),
                                        prefixIcon: Icon(Icons.location_on,
                                            color: Colors.black.withRed(100)),
                                      ),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Alamat tidak boleh kosong!';
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
                                    child: BuildDropdown(
                                      val: agama,
                                      hint: "Agama",
                                      label: "Agama",
                                      icon: agama == "Islam"
                                          ? Icons.mosque
                                          : agama == "Katolik"
                                              ? Icons.church
                                              : agama == "Protestan"
                                                  ? Icons.church
                                                  : agama == "Hindu"
                                                      ? Icons.temple_hindu
                                                      : agama == "Buddha"
                                                          ? Icons
                                                              .temple_buddhist
                                                          : Icons
                                                              .temple_buddhist,
                                      color: Colors.black.withRed(100),
                                      aksi: (val) {
                                        setState(() => agama = val!);
                                      },
                                      item: agama_value.map(
                                        (String val) {
                                          return DropdownMenuItem(
                                            value: val,
                                            child: Text(val),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: BuildDropdown(
                                      val: status,
                                      hint: "Status Perkawinan",
                                      label: "Status Perkawinan",
                                      icon: status == "Menikah"
                                          ? Icons.group_rounded
                                          : Icons.person,
                                      color: Colors.black.withRed(100),
                                      aksi: (val) {
                                        setState(() => status = val!);
                                      },
                                      item: status_value.map(
                                        (String val) {
                                          return DropdownMenuItem(
                                            value: val,
                                            child: Text(val),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: BuildTextField(
                                      con: telpon,
                                      hint: "08xxxxxxxxxx",
                                      label: "Telephone",
                                      icon: Icons.call,
                                      validasi: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Telephone tidak boleh kosong!';
                                        }
                                      },
                                      input: TextInputType.phone,
                                      color: Colors.black.withRed(100),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: BuildTextField(
                                      con: pekerjaan,
                                      hint: "Pekerjaan",
                                      label: "Pekerjaan",
                                      icon: Icons.work,
                                      validasi: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Pekerjaan tidak boleh kosong!';
                                        }
                                      },
                                      input: TextInputType.name,
                                      color: Colors.black.withRed(100),
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
                                          if (!isValid! && image == null) {
                                            return;
                                          } else {
                                            setState(() => _isLoading = true);
                                            Map<String, String> data = {
                                              "nama_lengkap": nama.text,
                                              "tempat_lahir": tempatLahir.text,
                                              "tanggal_lahir":
                                                  tanggalLahir.text,
                                              "jenis_kelamin": jenisKelamin,
                                              "alamat": alamat.text,
                                              "agama": agama,
                                              "status": status,
                                              "pekerjaan": pekerjaan.text,
                                              "telepon": telpon.text,
                                              "username": widget.user,
                                              "password": widget.pass
                                            };
                                            _apiService
                                                .registrasi(
                                                    file: File(image!.path),
                                                    data: data)
                                                .then((isSuccess) {
                                              setState(
                                                  () => _isLoading = false);
                                              if (isSuccess) {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPage()),
                                                    (route) => false);
                                              } else {}
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.black.withRed(100),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(17))),
                                        child: Text('Register',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: SizedBox(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.grey,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(17))),
                                        child: Text('Kembali',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 10),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
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
              : Container(),
        ],
      ),
    );
  }
}

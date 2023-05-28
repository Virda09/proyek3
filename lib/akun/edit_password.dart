// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, empty_catches
import 'package:flutter/material.dart';
import 'package:proyek3/akun/akun_page.dart';
import 'package:proyek3/akun/alert.dart';
import 'package:proyek3/model/api_service.dart';

class EditPasswordPage extends StatefulWidget {
  final String id;
  const EditPasswordPage({super.key, required this.id});

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController pass = TextEditingController();
  TextEditingController npass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  bool _isObpass = true;
  bool _isObcpass = true;
  bool _isObnpass = true;

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  Alert alert = Alert();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withRed(100),
        title: Text(
          "Edit Password",
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      key: _scaffold,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 1000,
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
                          "Edit Password",
                          style: TextStyle(
                            color: Colors.black.withRed(100),
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
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: TextFormField(
                                      controller: pass,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Password tidak boleh kosong!';
                                        } else if (text.length < 8) {
                                          return "Password harus lebih dari 8 karakter!";
                                        }
                                        return null;
                                      },
                                      obscureText: _isObpass,
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
                                            )),
                                        hintText: "Password",
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                          color: Colors.black.withRed(100),
                                        ),
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.black.withRed(100)),
                                        suffixIcon: IconButton(
                                          icon: _isObpass
                                              ? Icon(
                                                  Icons.visibility,
                                                  color: Colors.black.withRed(100),
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.black.withRed(100),
                                                ),
                                          onPressed: () {
                                            setState(
                                              () {
                                                _isObpass = !_isObpass;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: TextFormField(
                                      controller: npass,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Password Baru tidak boleh kosong!';
                                        } else if (text.length < 8) {
                                          return "Password Baru harus lebih dari 8 karakter!";
                                        }
                                        return null;
                                      },
                                      obscureText: _isObnpass,
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
                                            )),
                                        hintText: "Password Baru",
                                        labelText: 'Password Baru',
                                        labelStyle: TextStyle(
                                          color: Colors.black.withRed(100),
                                        ),
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.black.withRed(100)),
                                        suffixIcon: IconButton(
                                          icon: _isObnpass
                                              ? Icon(
                                                  Icons.visibility,
                                                  color: Colors.black.withRed(100),
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.black.withRed(100),
                                                ),
                                          onPressed: () {
                                            setState(
                                              () {
                                                _isObnpass = !_isObnpass;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: TextFormField(
                                      controller: cpass,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Konfirmasi password tidak boleh kosong';
                                        } else if (text != npass.text) {
                                          return "Password tidak cocok";
                                        }
                                        return null;
                                      },
                                      obscureText: _isObcpass,
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
                                            )),
                                        hintText: "Konfirmasi Password",
                                        labelText: 'Konfirmasi Password',
                                        labelStyle: TextStyle(
                                          color: Colors.black.withRed(100),
                                        ),
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.black.withRed(100)),
                                        suffixIcon: IconButton(
                                          icon: _isObcpass
                                              ? Icon(
                                                  Icons.visibility,
                                                  color: Colors.black.withRed(100),
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.black.withRed(100),
                                                ),
                                          onPressed: () {
                                            setState(
                                              () {
                                                _isObcpass = !_isObcpass;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  // NOTE: BUTTON REGISTER
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
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
                                            Map data = {
                                              "new_password": npass.text,
                                              "current_password": pass.text
                                            };
                                            _apiService
                                                .ubahPassword(data, widget.id)
                                                .then((isSuccess) async => {
                                                      setState(
                                                          () => _isLoading = false),
                                                      if (isSuccess)
                                                        {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AkunPage(),
                                                            ),
                                                          ),
                                                        }
                                                      else
                                                        {
                                                          alert.showAlertDialog(
                                                              context,
                                                              "Ubah Password Gagal")
                                                        }
                                                    });
                                            setState(() {
                                              pass.text = "";
                                              cpass.text = "";
                                              npass.text = "";
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.black.withRed(100),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(17))),
                                        child: Text('Simpan',
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
              : Container(height: MediaQuery.of(context).size.height,),
        ],
      ),
    );
  }
}

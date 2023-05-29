// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, empty_catches
import 'package:flutter/material.dart';
import 'package:proyek3/color.dart';
import 'package:proyek3/komponents/build_textfield.dart';
import 'package:proyek3/auth/register_detail_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();

  bool _isObpass = true;
  bool _isObcpass = true;

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "REGISTRASI",
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: secondaryColor),
        ),
      ),
      key: _scaffold,
      body: SingleChildScrollView(
        // reverse: true,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: primaryColor,
            image: DecorationImage(
              opacity: 0.5,
                  image: AssetImage('assets/bg2.jpg'),
                  fit: BoxFit.fill,
                ),),
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
                    child: Form(
                      key: _form,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: BuildTextField(
                                con: user,
                                hint: "Username",
                                label: "Username",
                                icon: Icons.person,
                                validasi: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Username tidak boleh kosong';
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
                                        color: primaryColor,
                                        width: 2,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: primaryColor,
                                        width: 2,
                                      )),
                                  hintText: "Password",
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: primaryColor,
                                  ),
                                  prefixIcon: Icon(Icons.lock,
                                      color: primaryColor),
                                  suffixIcon: IconButton(
                                    icon: _isObpass
                                        ? Icon(
                                            Icons.visibility,
                                            color: primaryColor,
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: primaryColor,
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
                                controller: cpass,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Konfirmasi password tidak boleh kosong';
                                  } else if (text != pass.text) {
                                    return "Password tidak cocok";
                                  }
                                  return null;
                                },
                                obscureText: _isObcpass,
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
                                      )),
                                  hintText: "Konfirmasi Password",
                                  labelText: 'Konfirmasi Password',
                                  labelStyle: TextStyle(
                                    color: primaryColor,
                                  ),
                                  prefixIcon: Icon(Icons.lock,
                                      color: primaryColor),
                                  suffixIcon: IconButton(
                                    icon: _isObcpass
                                        ? Icon(
                                            Icons.visibility,
                                            color: primaryColor,
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: primaryColor,
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterDetailPage(
                                            user: user.text,
                                            pass: pass.text,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17))),
                                  child: Text('Selanjutnya',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: secondaryColor)),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Sudah Punya Akun?",
                                    style: TextStyle(fontSize: 18)),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(" Masuk",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: primaryColor)),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
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

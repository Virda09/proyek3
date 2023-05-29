// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, unrelated_type_equality_checks, non_constant_identifier_names

import 'package:proyek3/color.dart';
import 'package:proyek3/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyek3/auth/register_page.dart';
import 'package:flutter/material.dart';
import 'package:proyek3/model/user.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/komponents/build_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isObpass = true;
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  late SharedPreferences pref;
  List<User> list_user =[];
  late User user;

  _showAlertDialog(BuildContext context, String e) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(e),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (context) => alert,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor),
                ),
              ),
              Text("Silahkan Masuk Terlebih Dahulu\n",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: secondaryColor)),
              Form(
                  key: _form,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: BuildTextField(
                          con: username,
                          hint: "username",
                          label: "Username",
                          icon: Icons.person,
                          input: TextInputType.text,
                          validasi: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                          },
                          color: secondaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          style: TextStyle(color: secondaryColor),
                          controller: password,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Password tidak boleh kosong';
                            } else if (text.length < 8) {
                              return "Password harus lebih dari 8 karakter";
                            }
                            return null;
                          },
                          obscureText: _isObpass,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: secondaryColor,
                                  width: 2,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: secondaryColor,
                                  width: 2,
                                )),
                            focusColor: secondaryColor,
                            hintText: "Password",
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: secondaryColor,
                            ),
                            prefixIcon: Icon(Icons.lock, color: secondaryColor),
                            suffixIcon: IconButton(
                              icon: _isObpass
                                  ? Icon(
                                      Icons.visibility,
                                      color: secondaryColor,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: secondaryColor,
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

                      // NOTE: BUTTON LOGIN
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              final isValid = _form.currentState?.validate();
                              if (!isValid!) {
                                return;
                              } else {
                                setState(() => _isLoading = true);
                                User data = User(
                                    username: username.text,
                                    password: password.text);
                                _apiService.login(data).then((value) async => {
                                      setState(() => _isLoading = false),
                                      if (value != null)
                                        {
                                          list_user = value,
                                          pref = await SharedPreferences
                                              .getInstance(),
                                         
                                          for(var i =0;i<list_user.length;i++){
                                            user = list_user[i],
                                            pref.setString('id', user.id.toString()),
                                            pref.setString('nama', user.nama.toString()),
                                            pref.setString('role', user.role!),
                                            pref.setBool('login', true),
                                          },
                                          
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()),
                                              (route) => false)
                                        }
                                      else
                                        {
                                          _showAlertDialog(
                                              context, "Login Failed")
                                        }
                                    });
                                setState(() {
                                  username.text = "";
                                  password.text = "";
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: secondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17))),
                            child: Text('Login',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor)),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Don’t have an account?",
                              style:
                                  TextStyle(fontSize: 18, color: secondaryColor)),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              );
                            },
                            child: Text(" Register",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                    ],
                  ))
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
            : Container(),
      ],
    ));
  }
}

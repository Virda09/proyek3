// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proyek3/auth/login_page.dart';
import 'package:proyek3/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({super.key});

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  late SharedPreferences pref;
  var _isLogin = false;

  _getLogin() async {
    pref = await SharedPreferences.getInstance();
    _isLogin = pref.getBool('login') ?? false;
  }

  @override
  void initState() {
    super.initState();
    _getLogin();
    startLaunching();
  }

  startLaunching() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => _isLogin ? HomePage() : LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withRed(100),
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage('assets/bg2.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "DIMADES",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

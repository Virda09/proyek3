import 'package:flutter/material.dart';
import 'package:login_id/pages/pages.dart';
import 'package:login_id/pages/splash_page.dart';
import 'package:login_id/shared/shared.dart';
import 'package:login_id/pages/home_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: ColorPalette.purpleColor,
          primaryColor: primaryColor,
          canvasColor: Colors.transparent,
        ),
        home: const SplashPage());
  }
}

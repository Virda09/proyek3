// ignore_for_file: prefer_const_constructors, missing_return, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    required this.con,
    required this.hint,
    required this.label,
    required this.icon,
    this.validasi,
    this.input,
    required this.color,
    this.read
  });

  final TextEditingController con;
  final String hint, label;
  final IconData icon;
  final validasi;
  final TextInputType? input;
  final Color color;
  final String? read;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: read == "true" ? true : false,
      keyboardType: input,
      style: TextStyle(color: color),
      controller: con,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: color,
              width: 2,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: color,
              width: 2,
            )),
        focusColor: color,
        hintText: hint,
        labelText: label,
        labelStyle: TextStyle(
          color: color,
        ),
        prefixIcon: Icon(icon, color: color),
      ),
      validator: validasi,
    );
  }
}

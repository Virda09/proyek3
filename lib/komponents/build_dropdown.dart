// ignore_for_file: prefer_const_constructors, missing_return, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class BuildDropdown extends StatelessWidget {
  const BuildDropdown({
    super.key,
    required this.val,
    required this.hint,
    required this.label,
    required this.icon,
    required this.color, required this.item, this.aksi,
  });

  final String val;
  final String hint, label;
  final IconData icon;
  final Color color;
  final List<DropdownMenuItem> item;
  final aksi;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      items: item,
      value: val,
      onChanged: aksi,
      style: TextStyle(color: color),
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
          ),
        ),
        focusColor: color,
        labelText: label,
        labelStyle: TextStyle(
          color: color,
        ),
        prefixIcon: Icon(icon, color: color),
      ),
    );
  }
}

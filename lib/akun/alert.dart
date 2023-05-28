import 'package:flutter/material.dart';

class Alert {
  showAlertDialog(BuildContext context, String e) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () => Navigator.pop(context),
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: Text(e),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (context) => alert,
    );
  }
}
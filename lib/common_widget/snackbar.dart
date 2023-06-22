import 'package:flutter/material.dart';

class Snackbar {
  static show(BuildContext context, { String msg}) {
    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: (Colors.redAccent),
    );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

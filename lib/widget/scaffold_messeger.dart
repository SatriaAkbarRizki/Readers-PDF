import 'package:flutter/material.dart';

class ShowSnackBar {
  BuildContext context;
  String message;

  ShowSnackBar(this.context, this.message);

  void showSnackBar({Color colors = Colors.red}) {
    final snackBar = SnackBar(
      backgroundColor: colors,
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

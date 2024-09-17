import 'package:flutter/material.dart';

class MyTheme {
  var lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xffFDFCFA),
      textTheme: const TextTheme(
          titleMedium: TextStyle(
              fontSize: 26,
              fontFamily: 'GideonRoman',
              fontWeight: FontWeight.w800),
          labelSmall: TextStyle(
              fontSize: 14,
              fontFamily: 'PublicSans',
              fontWeight: FontWeight.w600),
          labelMedium: TextStyle(fontSize: 14)),
      popupMenuTheme: const PopupMenuThemeData(color: Color(0xffFDFCFA)),
      dialogTheme: const DialogTheme(
          backgroundColor: Color(0xffFDFCFA),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white, backgroundColor: Color(0xff1b5ed1)),
      snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color.fromARGB(255, 235, 57, 57)));
}

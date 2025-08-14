import 'package:flutter/material.dart';

class MyTheme {
  var lightTheme = ThemeData(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      scaffoldBackgroundColor: const Color(0xffFDFCFA),
      textTheme: const TextTheme(
          titleMedium: TextStyle(
              fontSize: 18,
              color: Color(0xff1b5ed1),
              fontWeight: FontWeight.bold),
          titleLarge: TextStyle(  
              fontSize: 26,
              fontFamily: 'GideonRoman',
              color: Color(0xffFDFCFA),
              fontWeight: FontWeight.w800),
          labelSmall: TextStyle(
              fontSize: 14,
              fontFamily: 'PublicSans',
              color: Color(0xffFDFCFA),
              fontWeight: FontWeight.w600),
          labelMedium: TextStyle(
            fontSize: 14,
            color: Color(0xffFDFCFA),
            fontWeight: FontWeight.w800,
            fontFamily: 'PublicSans',
          )),
      popupMenuTheme: const PopupMenuThemeData(color: Color(0xffFDFCFA)),

// I dont know why,maybe have differenet version Flutter

      // dialogTheme: const DialogTheme(
      //     backgroundColor: Color(0xffFDFCFA),
      //     shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(20)))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white, backgroundColor: Color(0xff1b5ed1)),
      snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color.fromARGB(255, 235, 57, 57)));
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplereader/model/thememodel.dart';

class ThemeCubit extends Cubit<Thememodel> {
  List<Thememodel> listColorTheme = [
    Thememodel(
        const Color(0xff1d1d1d),
        const Color(0xff1b5ed1), // Done
        const Color(0xffFDFCFA)),
    Thememodel(
        const Color(0xff214f44),
        const Color.fromARGB(255, 117, 163, 133),
        const Color(0xffFDFCFA)), // Done
    Thememodel(
        const Color(0xffFDFCFA), const Color(0xfff9e069), Colors.black), // Done
    Thememodel(
        const Color(0xff071432),
        const Color(0xff1b5ed1), // Done
        const Color(0xffFDFCFA)),
    Thememodel(const Color(0xfffea64e), const Color(0xfff1521c),
        const Color(0xfffefffe)), // Done
    Thememodel(const Color(0xff9b84b4), const Color(0xff1a0e21), Colors.white),
Thememodel(
              const Color(0xff303138), const Color(0xfff3c0c5), Colors.white)
  ];
  ThemeCubit()
      : super(
          Thememodel(
        const Color(0xff1d1d1d),
        const Color(0xff1b5ed1), // Done
        const Color(0xffFDFCFA)),
        );

  void chanetTheme(int index) {
    emit(listColorTheme[index]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplereader/model/thememodel.dart';

class ThemeCubit extends Cubit<Thememodel> {
  List<Thememodel> listColorTheme = [
    Thememodel(Colors.black, const Color(0xff1b5ed1), const Color(0xffFDFCFA)),
    Thememodel(Colors.green, const Color(0xff1b5ed1), const Color(0xffFDFCFA)),
    Thememodel(const Color(0xfffeefda), const Color(0xff1b5ed1),
        const Color(0xffFDFCFA)),
    Thememodel(const Color(0xff071432), const Color(0xff1b5ed1),
        const Color(0xffFDFCFA)),
    Thememodel(const Color(0xffc7dc56), const Color(0xff1b5ed1),
        const Color(0xffFDFCFA)),
    Thememodel(const Color(0xff86a1b6), const Color(0xff1b5ed1),
        const Color(0xffFDFCFA)),
    Thememodel(const Color(0xffec6a30), const Color(0xff1b5ed1),
        const Color(0xffFDFCFA)),
  ];
  ThemeCubit()
      : super(Thememodel(
            Colors.black, const Color(0xff1b5ed1), const Color(0xffFDFCFA)));

  void chanetTheme(int index) {
    emit(listColorTheme[index]);
  }
}

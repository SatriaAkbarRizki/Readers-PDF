import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplereader/database/theme.dart';
import 'package:simplereader/model/thememodel.dart';

class ThemeCubit extends Cubit<Thememodel> {
  List<Thememodel> listColorTheme = [
    Thememodel(0,const Color(0xff1d1d1d), const Color(0xff1b5ed1),
        const Color(0xffFDFCFA)),
    Thememodel(1,const Color(0xff214f44),
        const Color.fromARGB(255, 117, 163, 133), const Color(0xffFDFCFA)),
    Thememodel(2,const Color(0xffFDFCFA), const Color(0xff1b5ed1), Colors.black),
    Thememodel(3,const Color(0xff071432), const Color(0xff1b5ed1),
        const Color(0xffFDFCFA)),
    Thememodel(4,const Color(0xfffea64e), const Color(0xfff1521c),
        const Color(0xfffefffe)),
    Thememodel(5,const Color(0xff9b84b4), const Color(0xff1a0e21), Colors.white),
    Thememodel(6,const Color(0xff303138), const Color(0xfff3c0c5), Colors.white)
  ];

  ThemeCubit()
      : super(Thememodel(0, const Color(0xff1d1d1d), const Color(0xff1b5ed1),
            const Color(0xffFDFCFA)));

  void getCurretTheme() async {
    final current = await DatabasesTheme.getHiveTheme();
    emit(current ?? listColorTheme[0]);
  }

  void chanetTheme(Thememodel themes) async {
    await DatabasesTheme.putHiveTheme(themes);
    emit(themes);
  }
}

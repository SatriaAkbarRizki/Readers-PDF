import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorPickerCubit extends Cubit<Color> {
  ColorPickerCubit() : super(Colors.red);

  Color pickerColor = Colors.red;
  Color currentColor = const Color(0xff443a49);

  void changeColor(Color colors) {
    pickerColor = colors;
    emit(colors);
  }
}

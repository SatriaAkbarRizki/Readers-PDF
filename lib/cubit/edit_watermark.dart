import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditWatermark extends Cubit<dynamic> {
  EditWatermark() : super(());

  String nameWatermark = 'Watermark';
  String hintnameWatermark = 'Click To Edit';
  String fontSize = '12';
  Alignment postionWatermark = Alignment.bottomLeft;

  int indexPosition = 4;

  TextEditingController watermarkNameController = TextEditingController();
  TextEditingController fontSizeController = TextEditingController();

  void changeWatermark(String value) {
    nameWatermark = value;
    emit(value);
  }

  void changeFontSize(String value) {
    fontSize = value;
    emit(value);
  }

  void changePosition(int index) {
    indexPosition = index;
    changePostionWatermark(indexPosition);
    emit(index);
  }

  void changePostionWatermark(int value) {
    switch (value) {
      case 0:
        postionWatermark = Alignment.topLeft;
      case 1:
        postionWatermark = Alignment.topCenter;
      case 2:
        postionWatermark = Alignment.topRight;
      case 3:
        postionWatermark = Alignment.centerLeft;
      case 4:
        postionWatermark = Alignment.center;
      case 5:
        postionWatermark = Alignment.centerRight;
      case 6:
        postionWatermark = Alignment.bottomLeft;
      case 7:
        postionWatermark = Alignment.bottomCenter;
      case 8:
        postionWatermark = Alignment.bottomRight;
      default:
        postionWatermark = Alignment.bottomLeft;
    }

    emit(postionWatermark);
  }
}

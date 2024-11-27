import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditWatermark extends Cubit<dynamic> {
  EditWatermark() : super(());

  String nameWatermark = 'Watermark';
  String fontSize = '24';
  Alignment postionWatermark = Alignment.center;

  int indexPosition = 4;
  double rotateValue = 0;

  TextEditingController watermarkNameController = TextEditingController();
  TextEditingController fontSizeController = TextEditingController();

  List<DropdownMenuItem<double>> dropMenuItem = [
    const DropdownMenuItem(
      value: 0,
      child: Text('Do not rotate'),
    ),
    const DropdownMenuItem(
      value: -45,
      child: Text('45 degress'),
    ),
    const DropdownMenuItem(
      value: 90,
      child: Text('90 degress'),
    ),
    const DropdownMenuItem(
      value: 180,
      child: Text('180 degress'),
    ),
    const DropdownMenuItem(
      value: 270,
      child: Text('270 degress'),
    ),
  ];

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

  void changeRotate(double value) {
    rotateValue = value;
    emit(value);
  }

  void resetWatermark() {
    watermarkNameController.clear();
    fontSizeController.clear();

    
    emit(fontSize = '24');
    emit(indexPosition = 4);
    emit(rotateValue = 0);
    emit(nameWatermark = 'Watermark');
    emit(postionWatermark = Alignment.center);
  }
}

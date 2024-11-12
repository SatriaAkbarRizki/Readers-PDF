import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class ClickOrderDelete extends Cubit<List<int>> {
  ClickOrderDelete() : super([]);

  List<int> get listOrderDelete => state;

  void click(int index) {
    final clickOrder = List<int>.from(state);

    clickOrder.contains(index)
        ? clickOrder.remove(index)
        : clickOrder.add(index);
    emit(clickOrder);
  }
}

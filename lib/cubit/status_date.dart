import 'package:flutter_bloc/flutter_bloc.dart';

class StatusDate extends Cubit<String> {
  StatusDate() : super('Good Morning');

  void checkStatus() {
    final String message =
        DateTime.now().hour < 12 ? "Good Morning 🌅" : "Good Afternoon 🌃";
    emit(message);
  }
}

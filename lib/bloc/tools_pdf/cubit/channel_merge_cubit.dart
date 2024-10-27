import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class ChannelMergeCubit extends Cubit<bool> {
  bool statusClose = false;
  ChannelMergeCubit() : super(false);

  void changeStatus(bool value) {
    statusClose = value;
    emit(statusClose);
  }
}

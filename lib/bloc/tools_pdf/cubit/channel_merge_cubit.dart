import 'package:bloc/bloc.dart';

class ChannelMergeCubit extends Cubit<bool> {
  bool statusClose = false;
  ChannelMergeCubit() : super(false);

  void changeStatus(bool value) {
    statusClose = value;
    emit(statusClose);
  }
}

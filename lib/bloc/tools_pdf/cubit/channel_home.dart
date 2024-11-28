import 'package:flutter_bloc/flutter_bloc.dart';

class ChannelHome extends Cubit<bool> {
  ChannelHome() : super(true);

  void isHome(bool value) => emit(value);

  void onceFetch() => emit(false);
}

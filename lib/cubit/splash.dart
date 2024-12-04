import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplereader/database/splash.dart';

class SplashDatabaseCubit extends Cubit<bool> {
  SplashDatabaseCubit() : super(false);

  void getStatusSplash() async {
    final status = await DatabasesSplash.getSplashHive();
    emit(status ?? false);
  }

  void changeStatus(bool value) async {
    await DatabasesSplash.putSplashHive(value);
    emit(value);
  }
}

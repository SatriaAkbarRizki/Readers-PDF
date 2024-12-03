import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplereader/service/permission.dart';

class StatusPermissionCubit extends Cubit<bool> {
  StatusPermissionCubit() : super(false);

  void listenStatusPermission() async {
    await requestPermission().then(
      (value) => emit(value),
    );
  }
}

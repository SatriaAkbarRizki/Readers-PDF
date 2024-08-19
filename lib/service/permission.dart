  import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {
    if (await Permission.manageExternalStorage.request().isGranted &&
        await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {
  if (await Permission.storage.request().isGranted &&
      await Permission.manageExternalStorage.request().isGranted) {
    return true;
  }
  return false;
}

Future<bool> requestStorage() async {
  final statusPermission = await Permission.storage.request().isGranted;
  return statusPermission;
}


Future<bool> requestExternalStorage() async{
    final statusPermission = await Permission.manageExternalStorage.request().isGranted;
  return statusPermission;
}

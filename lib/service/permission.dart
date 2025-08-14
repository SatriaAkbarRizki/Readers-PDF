import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {
  final deviceInfo = DeviceInfoPlugin();
  final androidInfo = await deviceInfo.androidInfo;
  int version = int.parse(androidInfo.version.release);

  if (version < 13) {
    if (await Permission.storage.request().isGranted &&
        await Permission.manageExternalStorage.request().isGranted) {
      return true;
    }
  } else {
    if (await Permission.manageExternalStorage.request().isGranted) {
      return true;
    }
  }

  return false;
}

Future statusPermission() async {
  final deviceInfo = DeviceInfoPlugin();
  final androidInfo = await deviceInfo.androidInfo;
  int version = int.parse(androidInfo.version.release);

  if (version < 13) {
    if (await Permission.storage.status.isGranted &&
        await Permission.manageExternalStorage.status.isGranted) {
      return true;
    }
  } else {
    if (await Permission.manageExternalStorage.status.isGranted) {
      return true;
    }
  }
  return false;
}

// Future<bool> requestStorage() async {
//   final statusPermission = await Permission.storage.request().isGranted;
//   return statusPermission;
// }

// Future<bool> requestExternalStorage() async {
//   final statusPermission =
//       await Permission.manageExternalStorage.request().isGranted;
//   return statusPermission;
// }

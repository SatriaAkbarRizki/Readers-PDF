import 'dart:io';

import 'package:file_picker/file_picker.dart';

class ServiceFile {
  Future<File?> getFileDoc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    }
    return null;
  }
}

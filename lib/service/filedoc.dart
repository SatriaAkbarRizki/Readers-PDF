import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:simplereader/service/permission.dart';

class ServiceFile {
  List<FileSystemEntity> rootDirectory = [];
  List<String> listPDF = [];
  Future<FilePickerResult?> getFileDoc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return result;
    }
    return null;
  }

  Future<List<String>> findPDFAll() async {
    listPDF.clear();
    if (await requestPermission()) {
      try {
        Directory dir = Directory('/storage/emulated/0');
        rootDirectory = dir.listSync();

        for (var elementDir in rootDirectory) {
          if (FileSystemEntity.isDirectorySync(elementDir.path)) {
            Directory(elementDir.path).listSync().forEach((elementDirInside) {
              if (elementDirInside.path.endsWith('.pdf')) {
                
                listPDF.add(elementDirInside.path);
              }
            });
          }
        }
      } catch (e) {
        log('Error: $e');
      }
    }
    return listPDF;
  }
}

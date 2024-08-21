import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:simplereader/model/pdfmodel.dart';
import 'package:simplereader/service/permission.dart';

class ServiceFile {
  List<FileSystemEntity> rootDirectory = [];
  List<Pdfmodel> listPDF = [];
  Future<Pdfmodel?> getFileDoc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String namePdf = path.basename(result.files.first.path!);
      namePdf = namePdf.replaceAll('.pdf', '');

      final modelPDF =
          Pdfmodel(name: namePdf, path: result.files.first.path.toString());
      log('Name PDF: ${modelPDF.name} and Path PDF: ${modelPDF.path}');

      // TODO CHANGE CONSTRUCTOR CLASS USING MODEL NOT FilePickerResult
      return modelPDF;
    }
    return null;
  }

  Future<List<Pdfmodel>> findPDFAll() async {
    listPDF.clear();
    if (await requestPermission()) {
      try {
        Directory dir = Directory('/storage/emulated/0');
        rootDirectory = dir.listSync();

        for (var elementDir in rootDirectory) {
          if (FileSystemEntity.isDirectorySync(elementDir.path)) {
            Directory(elementDir.path).listSync().forEach((elementDirInside) {
              if (elementDirInside.path.endsWith('.pdf')) {
                String namePdf = path.basename(elementDirInside.path);
                namePdf = namePdf.replaceAll('.pdf', '');

                listPDF
                    .add(Pdfmodel(name: namePdf, path: elementDirInside.path));
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

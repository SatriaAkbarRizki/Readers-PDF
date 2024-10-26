import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<void> deleteFile(FileSystemEntity filePdf) async {
    final file = File(filePdf.path);
    await file.delete();
  }

  Future<String> renameFile(String newName, FileSystemEntity pathPdf) async {
    log(pathPdf.path);
    final dir = Directory(pathPdf.path);
    final namePdf = dir.path.split('/').last;

    final file = File(pathPdf.path);
    String replacePdf = dir.path.replaceFirst(namePdf, '$newName.pdf');
    log('New Name file: $replacePdf');
    await file.rename(replacePdf);

    return replacePdf;
  }

  Future<File> movingFile(String pdf) async {
    log(pdf);
    final namePdf = pdf.split('/').last;
    final sourceFile = File(pdf);

    final destinationPath = "/storage/emulated/0/Documents/$namePdf";
    final newFile = await sourceFile.copy(destinationPath);
    await sourceFile.delete();

    log('Results Move: ${newFile.path}');
    return newFile;
  }
}

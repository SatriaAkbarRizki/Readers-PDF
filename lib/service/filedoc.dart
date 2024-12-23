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
      return modelPDF;
    }
    return null;
  }

  Future<Pdfmodel?> getFileDocCustom(String value) async {
    String pdfPath = Uri.decodeFull(value);
    String namePdf = pdfPath.split("/").last;

    final modelPDF = Pdfmodel(name: namePdf, path: pdfPath);
    return modelPDF;
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
    final dir = Directory(pathPdf.path);
    final namePdf = dir.path.split('/').last;

    final file = File(pathPdf.path);
    String replacePdf = dir.path.replaceFirst(namePdf, '$newName.pdf');
    await file.rename(replacePdf);

    return replacePdf;
  }

  Future<File> movingFile(String pdf) async {
    final namePdf = pdf.split('/').last;
    final sourceFile = File(pdf);

    final destinationPath = "/storage/emulated/0/Documents/$namePdf";
    final newFile = await sourceFile.copy(destinationPath);
    await sourceFile.delete();

    return newFile;
  }

  Future<List<Pdfmodel>> searchFile(String name) async {
    final List<Pdfmodel> listSearch = [];
    listSearch.clear();
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

                if (namePdf.toLowerCase().contains(name.toLowerCase())) {
                  listSearch.add(
                      Pdfmodel(name: namePdf, path: elementDirInside.path));
                }
              }
            });
          }
        }
      } catch (e) {
        log('Error: $e');
      }
    }
    return listSearch;
  }
}

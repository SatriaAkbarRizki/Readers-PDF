import 'dart:io';

import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:simplereader/service/filedoc.dart';

class Deletepdf {
  final String name;
  final String pdfPath;
  final List<int> pageNumbers;

  Deletepdf(this.name, this.pdfPath, this.pageNumbers);

  ServiceFile serviceFile = ServiceFile();

  Future<String?> delete() async {
    String? deletedPagesPdfPath = await PdfManipulator().pdfPageDeleter(
      params: PDFPageDeleterParams(pdfPath: pdfPath, pageNumbers: pageNumbers),
    );

    if (deletedPagesPdfPath != null) {
      await serviceFile
          .renameFile(name, File(deletedPagesPdfPath))
          .then((value) => deletedPagesPdfPath = value);
      return deletedPagesPdfPath;
    }
    return null;
  }
}

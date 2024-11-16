import 'dart:io';

import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:simplereader/service/filedoc.dart';

class CompressPDF {
  final String name;
  final String path;
  final double valueQuality;
  final double valueScale;

  CompressPDF(this.name, this.path, this.valueQuality, this.valueScale);

  ServiceFile serviceFile = ServiceFile();

  Future<String?> compress() async {
    String? deletedPagesPdfPath = await PdfManipulator().pdfCompressor(
        params: PDFCompressorParams(
            pdfPath: path,
            imageQuality: valueQuality.round(),
            imageScale: valueScale));

    if (deletedPagesPdfPath != null) {
      await serviceFile
          .renameFile(name, File(deletedPagesPdfPath))
          .then((value) => deletedPagesPdfPath = value);
      return deletedPagesPdfPath;
    }
    return null;
  }
}

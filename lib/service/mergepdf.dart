import 'dart:io';

import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:simplereader/service/filedoc.dart';

import '../model/pdfmodel.dart';

class Mergepdf {
  String name;
  List<Pdfmodel> pdfs;
  Mergepdf(
    this.name,
    this.pdfs,
  );

  ServiceFile serviceFile = ServiceFile();

  Future<String?> merge() async {
    String? mergedPdfPath = await PdfManipulator().mergePDFs(
      params: PDFMergerParams(pdfsPaths: [pdfs[0].path, pdfs[1].path]),
    );

    if (mergedPdfPath != null) {
      await serviceFile
          .renameFile(name, File(mergedPdfPath))
          .then((value) => mergedPdfPath = value);
    }

    return mergedPdfPath;
  }
}

part of 'tools_pdf_bloc.dart';

@immutable
sealed class ToolsPdfEvent {
  final BuildContext context;

  const ToolsPdfEvent(this.context);
}

class OnPickPDFMerge extends ToolsPdfEvent {
  const OnPickPDFMerge(super.context);
}

class OnPDFMerge extends ToolsPdfEvent {
  final List<Pdfmodel> pdfs;
  final String nameMergePdf;
  const OnPDFMerge(this.nameMergePdf, this.pdfs, super.context);
}

class OnCancelMerge extends ToolsPdfEvent {
  final int numberPdf;
  const OnCancelMerge(super.context, this.numberPdf);
}

class OnPDFDeletingPage extends ToolsPdfEvent {
  final String nameMergePdf;
  final String pdfPath;
  final List<int> pageNumbers;
  const OnPDFDeletingPage(
      this.nameMergePdf, this.pdfPath, this.pageNumbers, super.context);
}

class OnPDFComprerssing extends ToolsPdfEvent {
  final String name;
  final String path;
  final double valueQuality;
  final double valueScale;
  const OnPDFComprerssing(
    this.name,
    this.path,
    this.valueQuality,
    this.valueScale,
    super.context,
  );
}

class OnPDFWatermark extends ToolsPdfEvent {
  final String namePDF;
  final String nameWatermark;
  final String path;
  final String fontSize;
  final Alignment postionWatermark;
  final Color colors;
  final double valueOpacity;

  const OnPDFWatermark(this.namePDF, this.nameWatermark, this.path, this.fontSize, this.postionWatermark, this.colors, this.valueOpacity,super.context);
}

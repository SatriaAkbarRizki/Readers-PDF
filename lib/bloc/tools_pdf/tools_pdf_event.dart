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
  const OnPDFMerge(this.nameMergePdf,this.pdfs, super.context);
}

class OnCancelMerge extends ToolsPdfEvent {
  final int numberPdf;
  const OnCancelMerge(super.context, this.numberPdf);
}

class OnPDFDeletingPage extends ToolsPdfEvent {
  const OnPDFDeletingPage(super.context);
}

class OnPDFComprerssing extends ToolsPdfEvent {
  const OnPDFComprerssing(super.context);
}

class OnPDFWatermark extends ToolsPdfEvent {
  const OnPDFWatermark(super.context);
}

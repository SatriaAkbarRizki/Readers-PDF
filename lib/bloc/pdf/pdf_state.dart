part of 'pdf_bloc.dart';

@immutable
sealed class PdfState {}

final class PdfInitial extends PdfState {}

final class PdfOpenSearch extends PdfState {}

final class PdfCloseSearch extends PdfState {}

final class PdfSearchingText extends PdfState {
  final String? text;

  PdfSearchingText(this.text);
}

final class PdfOpenFile extends PdfState {
  final Pdfmodel? modelPDF;

  PdfOpenFile({required this.modelPDF});
}

final class PdfShowingAll extends PdfState {
  PdfShowingAll();
}

final class PdfRenameFile extends PdfState{}
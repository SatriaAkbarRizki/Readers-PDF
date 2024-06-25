part of 'pdf_bloc.dart';

@immutable
sealed class PdfEvent {}

class OnPdfOpenSearch extends PdfEvent {}

class OnPdfCloseSearch extends PdfEvent {}

class OnPdfSearchingText extends PdfEvent {
  final String? text;

  OnPdfSearchingText(this.text);
}

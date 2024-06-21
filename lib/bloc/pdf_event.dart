part of 'pdf_bloc.dart';

@immutable
sealed class PdfEvent {}

class OnPdfSearch extends PdfEvent {}

class OnUnPdfSearch extends PdfEvent {}

class OnPdfSearchText extends PdfEvent {
  final String? text;

  OnPdfSearchText(this.text);
}

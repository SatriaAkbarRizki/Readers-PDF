part of 'pdf_bloc.dart';

@immutable
sealed class PdfEvent {}

class OnPdfSearch extends PdfEvent {}

class OnUnPdfSearch extends PdfEvent {}

class OnSearchText extends PdfEvent {
  final String? text;

  OnSearchText(this.text);
}

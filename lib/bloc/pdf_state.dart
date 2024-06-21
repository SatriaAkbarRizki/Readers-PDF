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

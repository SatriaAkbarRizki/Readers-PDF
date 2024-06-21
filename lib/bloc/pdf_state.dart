part of 'pdf_bloc.dart';

@immutable
sealed class PdfState {}

final class PdfInitial extends PdfState {}

final class PdfSearch extends PdfState {}

final class PdfNotSearch extends PdfState {}

final class PdfSearchText extends PdfState {
  final String? text;

  PdfSearchText(this.text);
}

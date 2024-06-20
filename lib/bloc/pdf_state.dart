part of 'pdf_bloc.dart';

@immutable
sealed class PdfState {}

final class PdfInitial extends PdfState {}

final class PdfSearch extends PdfState {}

final class PdfNotSearch extends PdfState {}

final class SearchText extends PdfState {
  final String? text;

  SearchText(this.text);
}

part of 'pdf_bloc.dart';

@immutable
sealed class PdfEvent {}

class OnPdfOpenSearch extends PdfEvent {}

class OnPdfCloseSearch extends PdfEvent {}

class OnPdfSearchingText extends PdfEvent {
  final String? text;

  OnPdfSearchingText(this.text);
}

class OnPdfOpenFile extends PdfEvent {
  final BuildContext context;

  OnPdfOpenFile({required this.context});
}

class OnPdfShowingAll extends PdfEvent {}


class OnPdfDeleted extends PdfEvent {
  final FileSystemEntity filePdf;

  OnPdfDeleted({required this.filePdf});
}

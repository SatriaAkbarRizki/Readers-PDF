part of 'pdf_bloc.dart';

@immutable
sealed class PdfEvent {}

class OnPdfInitial extends PdfEvent {}

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

class OnPdfOpenFileIntent extends PdfEvent {
  final String path;
  final BuildContext context;

  OnPdfOpenFileIntent({required this.path, required this.context});
}

class OnPdfShowingAll extends PdfEvent {}

class OnPdfDeleted extends PdfEvent {
  final FileSystemEntity filePdf;

  OnPdfDeleted({required this.filePdf});
}

class OnPdfRename extends PdfEvent {
  final String newName;
  final FileSystemEntity filePdf;

  OnPdfRename({required this.newName, required this.filePdf});
}

class OnPDFSearchFile extends PdfEvent {
  final String name;

  OnPDFSearchFile(this.name);
}

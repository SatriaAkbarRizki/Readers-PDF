import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import '../../model/pdfmodel.dart';
import '../../screens/readingpdf.dart';
import '../../service/filedoc.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  ServiceFile serviceFile = ServiceFile();
  List<Pdfmodel> listPdf = [];

  PdfBloc() : super(PdfInitial()) {
    // Fetch the PDF list when the bloc is created
    _fetchAllPdfs();

    on<OnPdfOpenSearch>((event, emit) {
      emit(PdfOpenSearch());
    });

    on<OnPdfCloseSearch>((event, emit) {
      emit(PdfCloseSearch());
    });

    on<OnPdfSearchingText>((event, emit) {
      emit(PdfSearchingText(event.text));
    });

    on<OnPdfOpenFile>((event, emit) async {
      await serviceFile.getFileDoc().then(
        (results) {
          if (results != null && event.context.mounted) {
            final isPdf = results.path.contains('.pdf');

            if (isPdf) {
              event.context.go(ReadPDFScreens.routeName, extra: results);
            } else {
              SnackBar snackBar =
                  const SnackBar(content: Text('This not documents'));
              ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
              log('Not Pdf');
            }
          }
        },
      );
    });

    on<OnPdfShowingAll>((event, emit) {
      emit(PdfShowingAll());
    });
  }

  void _fetchAllPdfs() async {
    await serviceFile.findPDFAll().then(
      (value) {
        for (var element in value) {
          log('PDF found: $element');
        }
        listPdf = value;
        log('Value: ${listPdf.length}');
        add(OnPdfShowingAll());
      },
    );
  }
}

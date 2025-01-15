import 'dart:developer';
import 'dart:io';
import 'package:simplereader/widget/scaffold_messeger.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/pdfmodel.dart';
import '../../screens/readingpdf.dart';
import '../../service/filedoc.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  ServiceFile serviceFile = ServiceFile();

  List<Pdfmodel> listPdf = [];
  bool isOpen = false;

  PdfBloc() : super(PdfInitial()) {
    if (listPdf.isEmpty) {
      _fetchAllPdfs();
    }

    on<OnPdfInitial>((event, emit) {
      _fetchAllPdfs();
    });

    on<OnPdfOpenSearch>((event, emit) {
      isOpen = true;
      emit(PdfOpenSearch());
    });

    on<OnPdfCloseSearch>((event, emit) {
      isOpen = false;
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
              event.context.push(ReadPDFScreens.routeName, extra: results);
            } else {
              ShowSnackBar(event.context, 'This not documents').showSnackBar();
            }
          }
        },
      );
    });

    on<OnPdfOpenFileIntent>((event, emit) async {
      await serviceFile.getFileDocCustom(event.path).then(
        (results) {
          if (results != null && event.context.mounted) {
            final isPdf = results.path.contains('.pdf');
            event.context.go(ReadPDFScreens.routeName, extra: results);
            // if (isPdf) {

            // } else {
            //   ShowSnackBar(event.context, 'This not documents').showSnackBar();
            // }
          }
        },
      );
    });

    on<OnPdfShowingAll>((event, emit) {
      emit(PdfShowingAll());
    });

    on<OnPdfDeleted>((event, emit) async {
      await serviceFile.deleteFile(event.filePdf);
      _fetchAllPdfs();
    });

    on<OnPdfRename>((event, emit) async {
      await serviceFile.renameFile(event.newName, event.filePdf);
      _fetchAllPdfs();
      emit(PdfRenameFile());
    });

    on<OnPDFSearchFile>((event, emit) async {
      await serviceFile.searchFile(event.name).then(
            (value) =>
                Future.delayed(const Duration(milliseconds: 200)).whenComplete(
              () => emit(PdfSearchFile(value)),
            ),
          );
    });
  }

  void _fetchAllPdfs() async {
    await serviceFile.findPDFAll().then(
      (value) {
        listPdf = value;
        add(OnPdfShowingAll());
      },
    );
  }
}

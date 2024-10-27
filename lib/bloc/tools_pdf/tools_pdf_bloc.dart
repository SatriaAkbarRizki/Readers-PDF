import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:simplereader/model/pdfmodel.dart';
import 'package:simplereader/service/mergepdf.dart';
import 'package:simplereader/widget/scaffold_messeger.dart';

import '../../service/filedoc.dart';

part 'tools_pdf_event.dart';
part 'tools_pdf_state.dart';

class ToolsPdfBloc extends Bloc<ToolsPdfEvent, ToolsPdfState> {
  final List<Pdfmodel> listMerge = [];

  late BuildContext context;

  ServiceFile serviceFile = ServiceFile();

  ToolsPdfBloc() : super(ToolsPdfInitial()) {
    on<ToolsPdfEvent>((event, emit) {
      context = event.context;
    });

    on<OnPickPDFMerge>((event, emit) async {
      await serviceFile.getFileDoc().then((results) {
        if (results != null && event.context.mounted) {
          final isPdf = results.path.contains('.pdf');

          if (isPdf) {
            emit(ToolsPickPdfMerge(results));

            listMerge.add(results);
          } else {
            ShowSnackBar(event.context, 'This is not a PDF document')
                .showSnackBar();
          }
        }
      });
    });

    on<OnPDFMerge>((event, emit) async {
      emit(ToolsRunning());
      log('Name Merge: ${event.nameMergePdf}');
      // for (var element in event.pdfs) {
      //   log('List name pdf merge: ${element.name}');
      // }

      final toolsmerge = Mergepdf(event.nameMergePdf, event.pdfs);
        await toolsmerge.merge().then(
            (value) async => await serviceFile.movingFile(value!).then(
              (value) {
                emit(ToolsSucces());
              },
            ),
          );
    });

    on<OnCancelMerge>((event, emit) {
      log('IS CLICK CANCEL');
      emit(ToolsCancelMerge());
    });
  }
}

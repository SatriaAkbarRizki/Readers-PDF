import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  PdfBloc() : super(PdfInitial()) {
    on<OnPdfOpenSearch>((event, emit) {
      emit(PdfOpenSearch());
    });

    on<OnPdfCloseSearch>((event, emit) {
      emit(PdfCloseSearch());
    });

    on<OnPdfSearchingText>((event, emit) {
      emit(PdfSearchingText(event.text));
    });
  }
}

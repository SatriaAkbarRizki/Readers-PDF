import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  PdfBloc() : super(PdfInitial()) {
    on<OnPdfSearch>((event, emit) {
      emit(PdfSearch());
    });

    on<OnUnPdfSearch>((event, emit) {
      emit(PdfNotSearch());
    });

    on<OnSearchText>((event, emit) {
      emit(SearchText(event.text));
    });
  }
}

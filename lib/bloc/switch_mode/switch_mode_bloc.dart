import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'switch_mode_event.dart';
part 'switch_mode_state.dart';

class SwitchModeBloc extends Bloc<SwitchModeEvent, SwitchModeState> {
  SwitchModeBloc() : super(const SwitchModeInitial(false)) {
    on<ToggleReaderEvent>((event, emit) {
        if (state is ReaderMode){
          emit(const UnReaderMode(false));
        }else{
          emit (const ReaderMode(true));
        }
    });
  }
}

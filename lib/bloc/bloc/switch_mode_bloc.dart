import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'switch_mode_event.dart';
part 'switch_mode_state.dart';

class SwitchModeBloc extends Bloc<SwitchModeEvent, SwitchModeState> {
  SwitchModeBloc() : super(SwitchModeInitial()) {
    on<SwitchModeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

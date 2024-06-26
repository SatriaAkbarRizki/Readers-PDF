part of 'switch_mode_bloc.dart';

@immutable
sealed class SwitchModeState {
  final bool value;

  const SwitchModeState(this.value);
}

final class SwitchModeInitial extends SwitchModeState {
  const SwitchModeInitial(super.value);
}

final class SwitchModeUi extends SwitchModeState {
  const SwitchModeUi(super.value);
}

final class ReaderMode extends SwitchModeState {
  const ReaderMode(super.value);
}

final class UnReaderMode extends SwitchModeState {
  const UnReaderMode(super.value);
}

part of 'switch_mode_bloc.dart';

@immutable
sealed class SwitchModeEvent {}

class ToggleLightDarkEvent extends SwitchModeEvent {}

class ToggleReaderEvent extends SwitchModeEvent {}

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class PdfBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    log('State Now: ${change.currentState} && State Next: ${change.nextState}');
  }
}

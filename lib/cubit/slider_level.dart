import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<double> {
  SliderCubit(super.initialState);

  double valueQuality = 0.0;
  double valueScale = 0.0;
  double valueOpacity = 0.0;

  void changeValueQuality(double valueSlider) =>
      {valueQuality = valueSlider, emit(valueSlider)};
  void changeValueScale(double valueSlider) =>
      {valueScale = valueSlider, emit(valueSlider)};

    void changeValueOpacity(double valueSlider) =>
      {valueOpacity = valueSlider, emit(valueSlider)};

  void reset() => {emit(valueQuality = 100.0), emit(valueScale = 1.0)};
}

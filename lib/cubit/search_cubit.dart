import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<String?>{
  SearchCubit() : super(null);

  void searchingText(String text) => emit(text);
}
import 'package:flutter_bloc/flutter_bloc.dart';

class NavbarCubit extends Cubit<int>{
  NavbarCubit() :  super(0);

  void switchNavBar(int index) => emit(index);
  
}
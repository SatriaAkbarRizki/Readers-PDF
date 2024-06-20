import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:simplereader/service/filedoc.dart';

class FileCubit extends Cubit<File?> {
  FileCubit() : super(null);
  ServiceFile serviceFile = ServiceFile();

  void getFile() async => await serviceFile.getFileDoc().then(
        (value) => emit(value),
      );
}

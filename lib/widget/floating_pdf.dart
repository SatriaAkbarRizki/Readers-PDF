import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplereader/bloc/pdf/pdf_bloc.dart';
import 'package:simplereader/cubit/theme_cubit.dart';
import 'package:simplereader/model/thememodel.dart';

class FloatingPdfAction extends StatelessWidget {
  const FloatingPdfAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, Thememodel>(
      builder: (context, state) {
        return FloatingActionButton(
          backgroundColor: state.widget,
          onPressed: () async {
            context.read<PdfBloc>().add(OnPdfOpenFile(context: context));
          },
          child: Builder(
            builder: (context) {
              if (state.indexTheme == 2) {
                return Icon(
                  Icons.add,
                  color: state.background,
                );
              } else if (state.indexTheme == 6) {
                return Icon(
                  Icons.add,
                  color: state.background,
                );
              }
              return Icon(
                Icons.add,
                color: state.text,
              );
            },
          ),
        );
      },
    );
  }
}

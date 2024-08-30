import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplereader/bloc/pdf/pdf_bloc.dart';

class FloatingPdfAction extends StatelessWidget {
  const FloatingPdfAction({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // context.read<FileCubit>().findPdf();
        // context.read<FileCubit>().getFile(context);

        context.read<PdfBloc>().add(OnPdfOpenFile(context: context));
      },
      child: const Icon(Icons.add),
    );
  }
}

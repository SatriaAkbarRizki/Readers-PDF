import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplereader/bloc/pdf/pdf_bloc.dart';
import 'package:simplereader/cubit/theme_cubit.dart';

class ErrorScreen extends StatefulWidget {
  String message;
  Uri uriPDF;
  ErrorScreen(this.message, this.uriPDF, {super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  Future<void> getSharedData() async {
    try {
      if (mounted) {
        final results = Uri.parse(widget.uriPDF.path);
        if (results.scheme == 'file') {
          final filePath = results.path;
          context
              .read<PdfBloc>()
              .add(OnPdfOpenFileIntent(path: filePath, context: context));
        } else {
          final file = File.fromUri(results);
          log("Respon From URI: ${file.path}");
          context
              .read<PdfBloc>()
              .add(OnPdfOpenFileIntent(path: file.path, context: context));
        }
      }
    } catch (e) {
      log("Error fetching shared data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      getSharedData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themes = context.read<ThemeCubit>().state;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(
                      color: themes.widget,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "Please Wait",
              style: TextStyle(color: themes.text),
            ),
            // Builder(
            //   builder: (context) {
            //     Future.delayed(const Duration(milliseconds: 1000)).whenComplete(
            //       () => context.read<PdfBloc>().add(OnPdfOpenFileIntent(
            //           path: widget.uriPDF.path, context: context)),
            //     );
            //     return SizedBox();
            //   },
            // )
          ],
        ),
      ),
    );
  }
}

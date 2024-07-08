import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/screens/readingpdf.dart';

class FloatingPdfAction extends StatelessWidget {
  const FloatingPdfAction({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final results = await FilePicker.platform.pickFiles(type: FileType.any);

        if (results != null && context.mounted) {
          PlatformFile file = results.files.first;
          final isPdf = file.name.endsWith('pdf');
          if (isPdf) {
            context.go(ReadPDFScreens.routeName, extra: results);
          } else {
            SnackBar snackBar =
                const SnackBar(content: Text('This not documents'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            log('Not Pdf');
          }
        }
      },
      child: const Icon(Icons.add),
    );
  }
}

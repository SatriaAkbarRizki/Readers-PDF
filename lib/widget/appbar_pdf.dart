import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfrx/pdfrx.dart';

import 'package:simplereader/bloc/pdf_bloc.dart';

class AppBarPDF extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final PdfViewerController pdfViewerController;
  AppBarPDF({
    super.key,
    required this.pdfViewerController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () => {
                  context.read<PdfBloc>().add(OnPdfOpenSearch()),
                },
            icon: const Icon(Icons.search)),
        PopupMenuButton(
          itemBuilder: (context) => [
            _dialogRenamePDF(context),
            _dialogGotoPage(context),
            const PopupMenuItem(child: Text('Dark Mode')),
          ],
        )
      ],
    );
  }

  PopupMenuItem _dialogRenamePDF(context) => PopupMenuItem(
        child: const Text('Rename Pdf'),
        onTap: () => showDialog(
          useSafeArea: true,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Rename Pdf'),
            content: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              controller: _textEditingController,
            ),
            actions: [
              TextButton(onPressed: () {}, child: const Text('Rename'))
            ],
          ),
        ),
      );

  PopupMenuItem _dialogGotoPage(context) => PopupMenuItem(
        child: const Text('Go To Page'),
        onTap: () => showDialog(
          useSafeArea: true,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Go To Page Number'),
            content: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              controller: _textEditingController,
              keyboardType: TextInputType.number,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (int.parse(_textEditingController.text) <=
                        pdfViewerController.pages.length) {
                      pdfViewerController.goToPage(
                          pageNumber: int.parse(_textEditingController.text));
                    }

                    Navigator.pop(context);
                  },
                  child: const Text('Go'))
            ],
          ),
        ),
      );
}

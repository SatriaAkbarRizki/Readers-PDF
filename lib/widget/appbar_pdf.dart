import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:share_plus/share_plus.dart';

import 'package:simplereader/bloc/pdf/pdf_bloc.dart';
import 'package:simplereader/bloc/switch_mode/switch_mode_bloc.dart';
import 'package:simplereader/model/thememodel.dart';

import '../cubit/theme_cubit.dart';
import '../model/pdfmodel.dart';

class AppBarPDF extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final PdfViewerController pdfViewerController;
  Pdfmodel pdf;
  AppBarPDF({super.key, required this.pdfViewerController, required this.pdf});

  @override
  Widget build(BuildContext context) {
    final themes = context.read<ThemeCubit>().state;
    return Row(
      children: [
        IconButton(
            onPressed: () => {
                  context.read<PdfBloc>().add(OnPdfOpenSearch()),
                },
            icon: Image.asset(
              'assets/icons/search.png',
              color: themes.widget,
            )),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: PopupMenuButton(
            color: themes.background,
            icon: Image.asset(
              'assets/icons/menu-alt-right.png',
              color: themes.widget,
            ),
            offset: const Offset(50, 55),
            itemBuilder: (context) => [
              _dialogSharePDF(context, themes),
              _dialogGotoPage(context, themes),
              PopupMenuItem(
                child:
                    Text('Reader Mode', style: TextStyle(color: themes.text)),
                onTap: () =>
                    context.read<SwitchModeBloc>().add(ToggleReaderEvent()),
              )
            ],
          ),
        )
      ],
    );
  }

  PopupMenuItem _dialogSharePDF(contex, Thememodel themes) => PopupMenuItem(
        child: SizedBox(
          width: 100,
          height: 20,
          child: Text(
            'Share Pdf',
            style: TextStyle(color: themes.text),
          ),
        ),
        onTap: () {
          final params = ShareParams(text: pdf.name, files: [XFile(pdf.path)]);
          // Share.shareXFiles(
          //   [XFile(pdf.path)],
          // );

          SharePlus.instance.share(params);
        },
      );

  PopupMenuItem _dialogGotoPage(context, Thememodel themes) => PopupMenuItem(
        child: Text(
          'Go To Page',
          style: TextStyle(color: themes.text),
        ),
        onTap: () => showDialog(
          useSafeArea: true,
          context: context,
          builder: (context) => AlertDialog(
            title:
                Text('Go To Page Number', style: TextStyle(color: themes.text)),
            backgroundColor: themes.background,
            content: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themes.widget, width: 1.5)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: themes.widget, width: 1.5))),
              style: TextStyle(color: themes.text),
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
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Number page not found")));
                    }

                    Navigator.pop(context);
                  },
                  child: Text('Go', style: TextStyle(color: themes.text)))
            ],
          ),
        ),
      );
}

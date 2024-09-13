// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfrx/pdfrx.dart';

import 'package:simplereader/bloc/pdf/pdf_bloc.dart';

class AppBarSearch extends StatelessWidget {
  final TextEditingController textEditingController;
  final PdfTextSearcher pdfTextSearcher;

  int nextSearch = 0;
  AppBarSearch({
    super.key,
    required this.textEditingController,
    required this.pdfTextSearcher,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              context.read<PdfBloc>().add(OnPdfCloseSearch());
              textEditingController.clear();
              pdfTextSearcher.resetTextSearch();
            },
            icon: Image.asset(
              'assets/icons/left-arrow.png',
            )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: SizedBox(
              height: 50,
              width: 50,
              child: BlocListener<PdfBloc, PdfState>(
                listener: (context, state) {
                  if (state is PdfSearchingText) {
                    pdfTextSearcher.startTextSearch(state.text.toString(),
                        caseInsensitive: true, goToFirstMatch: true);
                    if (state.text!.isEmpty) {
                      pdfTextSearcher.resetTextSearch();
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: textEditingController,
                    onChanged: (value) {
                      context.read<PdfBloc>().add(OnPdfSearchingText(value));
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              pdfTextSearcher.goToMatchOfIndex(nextSearch);
              nextSearch--;
              if (nextSearch < 0) nextSearch = 0;
            },
            icon: Image.asset('assets/icons/up-arrow.png')),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(
              onPressed: () {
                pdfTextSearcher.goToMatchOfIndex(nextSearch);
                nextSearch++;
                if (nextSearch > pdfTextSearcher.matches.length) {
                  nextSearch = 0;
                }
              },
              icon: Image.asset('assets/icons/down_arrow.png')),
        ),
      ],
    ));
  }
}

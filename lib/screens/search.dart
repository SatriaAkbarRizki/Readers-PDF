import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:simplereader/bloc/pdf/pdf_bloc.dart';
import 'package:simplereader/model/thememodel.dart';
import 'package:simplereader/screens/empty.dart';
import 'package:simplereader/type/empty_type.dart';

import '../widget/dialog_doc.dart';
import 'readingpdf.dart';

class SearchScreen extends StatelessWidget {
  final Thememodel themes;
  SearchScreen(this.themes, {super.key});

  static String routeName = '/SearchScreen';
  final TextEditingController searchPDFController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () async {
                context.pop();
              },
              icon: Image.asset(
                'assets/icons/left-arrow.png',
                color: themes.widget,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextFormField(
                controller: searchPDFController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: themes.widget,
                          width: 1.5,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: themes.widget,
                          width: 1.5,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                style: TextStyle(color: themes.text),
                onChanged: (value) {
                  context
                      .read<PdfBloc>()
                      .add(OnPDFSearchFile(searchPDFController.text));
                },
              ),
            )),
        body: BlocConsumer<PdfBloc, PdfState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is PdfSearchFile) {
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: state.pdf.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => context.push(ReadPDFScreens.routeName,
                      extra: state.pdf[index]),
                  onLongPress: () => showDialog(
                    useSafeArea: true,
                    context: context,
                    builder: (context) => DialogDoc(
                      pdf: state.pdf[index],
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 150,
                        margin: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: PdfDocumentViewBuilder.file(
                            state.pdf[index].path,
                            builder: (context, document) => ListView.builder(
                              itemCount: 1,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return PdfPageView(
                                  document: document,
                                  pageNumber: index + 1,
                                  alignment: Alignment.center,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Text(
                            state.pdf[index].name,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: themes.text),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return EmptyScreens(type: TypeEmpty.emptyPdf);
          },
        ));
  }
}


//  EmptyScreens(type: TypeEmpty.emptyPdf),
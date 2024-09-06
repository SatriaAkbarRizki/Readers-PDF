
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/bloc/pdf/pdf_bloc.dart';
import 'package:simplereader/screens/empty.dart';
import 'package:simplereader/screens/readingpdf.dart';
import 'package:simplereader/type/empty_type.dart';
import 'package:simplereader/widget/dialog_doc.dart';

class CurrentPDF extends StatelessWidget {
  const CurrentPDF({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final listPdf = context.watch<PdfBloc>().listPdf;
        if (listPdf.isNotEmpty) {
          return CustomScrollView(
            slivers: [
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 2),
                delegate: SliverChildBuilderDelegate(
                  childCount: listPdf.length,
                  (context, index) => GestureDetector(
                    onTap: () => context.go(ReadPDFScreens.routeName,
                        extra: listPdf[index]),

                    onLongPress: () => showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (context) =>  DialogDoc(pdf: listPdf[index],),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            bottom: 10,
                          ),
                          height: 220,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/image/sample-book.jpg'),
                                  fit: BoxFit.cover),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 10,
                            ),
                            child: Text(
                              listPdf[index].name,
                              style: Theme.of(context).textTheme.labelSmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return const EmptyScreens(type: TypeEmpty.emptyPdf);
        }
      },
    );
  }
}

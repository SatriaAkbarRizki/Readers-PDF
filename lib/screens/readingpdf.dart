import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:simplereader/bloc/pdf_bloc.dart';

class ReadPDFScreens extends StatefulWidget {
  const ReadPDFScreens({super.key});

  @override
  State<ReadPDFScreens> createState() => _ReadPDFScreensState();
}

class _ReadPDFScreensState extends State<ReadPDFScreens> {
  TextEditingController textEditingController = TextEditingController();
  PdfViewerController pdfViewerController = PdfViewerController();
  int nextSearch = 0;
  late final PdfTextSearcher pdfTextSearcher;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<PdfBloc>().add(OnPdfCloseSearch()));
    pdfTextSearcher = PdfTextSearcher(pdfViewerController);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    pdfViewerController;
    pdfTextSearcher.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFDFCFA),
        title: Visibility(
            visible:
                context.watch<PdfBloc>().state is PdfOpenSearch ? false : true,
            child: const Text('Read PDF')),
        leading: Visibility(
            visible:
                context.watch<PdfBloc>().state is PdfCloseSearch ? true : false,
            child: IconButton(
                onPressed: () {
                  pdfTextSearcher.goToNextMatch();
                },
                icon: const Icon(Icons.arrow_back))),
        actions: [
          BlocBuilder<PdfBloc, PdfState>(
            buildWhen: (previous, current) =>
                (previous is PdfInitial) && (current is PdfCloseSearch) ||
                (previous is PdfCloseSearch) && (current is PdfOpenSearch) ||
                (previous is PdfOpenSearch) && (current is PdfCloseSearch) ||
                (previous is PdfSearchingText) && (current is PdfCloseSearch),
            builder: (context, state) {
              if (state is PdfCloseSearch) {
                return Row(
                  children: [
                    IconButton(
                        onPressed: () => {
                              context.read<PdfBloc>().add(OnPdfOpenSearch()),
                            },
                        icon: const Icon(Icons.search)),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(child: Text('Rename Pdf 1')),
                        const PopupMenuItem(child: Text('Go To Page')),
                        const PopupMenuItem(child: Text('Dark Mode')),
                      ],
                    )
                  ],
                );
              } else if (state is PdfOpenSearch) {
                return Expanded(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context.read<PdfBloc>().add(OnPdfCloseSearch());

                            textEditingController.clear();
                            pdfTextSearcher.resetTextSearch();
                          },
                          icon: const Icon(Icons.arrow_back)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 20),
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: TextFormField(
                                controller: textEditingController,
                                onChanged: (value) {
                                  context
                                      .read<PdfBloc>()
                                      .add(OnPdfSearchingText(value));

                                  final myState = context.read<PdfBloc>().state;
                                  if (myState is PdfSearchingText) {
                                    if (value.isNotEmpty) {
                                      pdfTextSearcher.startTextSearch(
                                          myState.text.toString(),
                                          caseInsensitive: true,
                                          goToFirstMatch: true);
                                    } else {
                                      pdfTextSearcher.resetTextSearch();
                                    }
                                  }
                                },
                              )),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            pdfTextSearcher.goToMatchOfIndex(nextSearch);
                            nextSearch--;
                          },
                          icon: Icon(Icons.next_plan)),
                      IconButton(
                          onPressed: () {
                            pdfTextSearcher.goToMatchOfIndex(nextSearch);
                            nextSearch++;
                          },
                          icon: Icon(Icons.next_plan))
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
      body: PdfViewer.asset(
        'assets/example.pdf',
        controller: pdfViewerController,
        params: PdfViewerParams(
            enableTextSelection: true,
            backgroundColor: Color.fromARGB(255, 253, 252, 250),
            viewerOverlayBuilder: (context, size) => [
                  PdfViewerScrollThumb(
                    controller: pdfViewerController,
                    thumbBuilder:
                        (context, thumbSize, pageNumber, controller) =>
                            Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black54),
                    ),
                  ),
                ],
            loadingBannerBuilder: (context, bytesDownloaded, totalBytes) =>
                const Center(
                  child: CircularProgressIndicator(),
                ),
            onPageChanged: (pageNumber) => Center(
                  child: Text(pageNumber.toString()),
                ),
            pagePaintCallbacks: [pdfTextSearcher.pageTextMatchPaintCallback]),
      ),
    );
  }
}

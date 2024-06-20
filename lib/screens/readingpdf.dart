import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:simplereader/bloc/pdf_bloc.dart';
import 'package:simplereader/cubit/search_cubit.dart';

class ReadPDFScreens extends StatefulWidget {
  const ReadPDFScreens({super.key});

  @override
  State<ReadPDFScreens> createState() => _ReadPDFScreensState();
}

class _ReadPDFScreensState extends State<ReadPDFScreens> {
  TextEditingController textEditingController = TextEditingController();
  PdfViewerController pdfViewerController = PdfViewerController();
  late final PdfTextSearcher pdfTextSearcher;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<PdfBloc>().add(OnUnPdfSearch()));
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
            visible: context.watch<PdfBloc>().state is PdfSearch ? false : true,
            child: const Text('Read PDF')),
        leading: Visibility(
            visible: context.watch<PdfBloc>().state is PdfSearch ? false : true,
            child: IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_back))),
        actions: [
          BlocBuilder<PdfBloc, PdfState>(
            builder: (context, state) {
              if (state is PdfNotSearch) {
                return Row(
                  children: [
                    IconButton(
                        onPressed: () => {
                              context.read<PdfBloc>().add(OnPdfSearch()),
                              // log('Open Search: ${context.read<PdfBloc>().state}'),
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
              } else if (state is PdfSearch) {
                return Expanded(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context.read<PdfBloc>().add(OnUnPdfSearch());

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
                                      .read<SearchCubit>()
                                      .searchingText(value);

                                  if (value.isNotEmpty) {
                                    pdfTextSearcher.startTextSearch(context
                                        .read<SearchCubit>()
                                        .state
                                        .toString());
                                  } else {
                                    pdfTextSearcher.resetTextSearch();
                                  }
                                },
                              )),
                        ),
                      ),
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
            backgroundColor: const Color(0xffFDFCFA),
            loadingBannerBuilder: (context, bytesDownloaded, totalBytes) =>
                const Center(
                  child: CircularProgressIndicator(),
                ),
            pagePaintCallbacks: [pdfTextSearcher.pageTextMatchPaintCallback]),
      ),
    );
  }
}

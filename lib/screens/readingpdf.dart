// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfrx/pdfrx.dart';

import 'package:simplereader/bloc/pdf/pdf_bloc.dart';
import 'package:simplereader/bloc/switch_mode/switch_mode_bloc.dart';
import 'package:simplereader/cubit/theme_cubit.dart';
import 'package:simplereader/model/pdfmodel.dart';
import 'package:simplereader/widget/appbar_pdf.dart';
import 'package:simplereader/widget/appbar_search.dart';

class ReadPDFScreens extends StatefulWidget {
  final Pdfmodel pdf;
  static String routeName = '/ScreenPDF';
  const ReadPDFScreens({
    super.key,
    required this.pdf,
  });

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
    // pdfViewerController.;
    pdfTextSearcher.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.pdf.toString());
    final themes = context.read<ThemeCubit>().state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themes.background,
        title: Visibility(
            visible: context.watch<PdfBloc>().state is PdfOpenSearch ||
                    context.watch<PdfBloc>().state is PdfSearchingText
                ? false
                : true,
            child: Text(
              widget.pdf.name,
              style: TextStyle(color: themes.text, fontSize: 18),
            )),
        leading: Visibility(
            visible:
                context.watch<PdfBloc>().state is PdfCloseSearch ? true : false,
            child: IconButton(
              onPressed: () async {
                GoRouter.of(context).go("/");
                ;
              },
              icon: Image.asset(
                'assets/icons/left-arrow.png',
                color: themes.widget,
              ),
            )),
        actions: [
          Builder(
            builder: (context) {
              final status = context.watch<PdfBloc>();
              if (!status.isOpen) {
                return AppBarPDF(
                  pdf: widget.pdf,
                  pdfViewerController: pdfViewerController,
                );
              } else if (status.isOpen) {
                return AppBarSearch(
                    pdfTextSearcher: pdfTextSearcher,
                    textEditingController: textEditingController);
              }
              return const SizedBox();
            },
          )
        ],
      ),
      body: PdfViewer.file(
        File(widget.pdf.path).path,
        controller: pdfViewerController,
        params: PdfViewerParams(
            textSelectionParams: PdfTextSelectionParams(enabled: true),
            backgroundColor: const Color.fromARGB(255, 253, 252, 250),
            errorBannerBuilder: (context, error, stackTrace, documentRef) =>
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("Sorry Unexpected Error: ${error.toString()}"),
                )),
            viewerOverlayBuilder: (context, size, handleLinkTap) => [
                  PdfViewerScrollThumb(
                    controller: pdfViewerController,
                    thumbBuilder:
                        (context, thumbSize, pageNumber, controller) =>
                            Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black54),
                    ),
                  )
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
      // body: BlocBuilder<SwitchModeBloc, SwitchModeState>(
      //   builder: (context, state) {
      //     return ColorFiltered(
      //       colorFilter: ColorFilter.mode(Colors.grey,
      //           state is ReaderMode ? BlendMode.saturation : BlendMode.dst),
      //       child: PdfViewer.file(
      //         File(widget.pdf.path).path,
      //         controller: pdfViewerController,
      //         params: PdfViewerParams(
      //             textSelectionParams: PdfTextSelectionParams(enabled: true),
      //             backgroundColor: const Color.fromARGB(255, 253, 252, 250),
      //             errorBannerBuilder: (context, error, stackTrace,
      //                     documentRef) =>
      //                 Center(
      //                     child: Padding(
      //                   padding: const EdgeInsets.all(20),
      //                   child:
      //                       Text("Sorry Unexpected Error: ${error.toString()}"),
      //                 )),
      //             viewerOverlayBuilder: (context, size, handleLinkTap) => [
      //                   PdfViewerScrollThumb(
      //                     controller: pdfViewerController,
      //                     thumbBuilder:
      //                         (context, thumbSize, pageNumber, controller) =>
      //                             Container(
      //                       decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(10),
      //                           color: Colors.black54),
      //                     ),
      //                   )
      //                 ],
      //             loadingBannerBuilder:
      //                 (context, bytesDownloaded, totalBytes) => const Center(
      //                       child: CircularProgressIndicator(),
      //                     ),
      //             onPageChanged: (pageNumber) => Center(
      //                   child: Text(pageNumber.toString()),
      //                 ),
      //             pagePaintCallbacks: [
      //               pdfTextSearcher.pageTextMatchPaintCallback
      //             ]),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

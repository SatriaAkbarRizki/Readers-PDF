import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:simplereader/bloc/tools_pdf/cubit/channel_merge_cubit.dart';
import 'package:simplereader/bloc/tools_pdf/tools_pdf_bloc.dart';
import 'package:simplereader/widget/form_dialog.dart';
import 'package:simplereader/widget/preview_merge.dart';
import 'package:simplereader/widget/scaffold_messeger.dart';

import '../../cubit/theme_cubit.dart';
import '../../model/pdfmodel.dart';

class MergeScreen extends StatelessWidget {
  static String routeName = '/MergePDF';
  List<Pdfmodel> pdfs = [];

  MergeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themes = context.read<ThemeCubit>().state;

    return BlocProvider(
      create: (context) => ChannelMergeCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: themes.background,
          title: Text(
            'Merge PDF',
            style: TextStyle(color: themes.text),
          ),
          leading: IconButton(
            onPressed: () async {
              context.pop();
            },
            icon: Image.asset(
              'assets/icons/left-arrow.png',
              color: themes.widget,
            ),
          ),
        ),
        body: Stack(
          children: [
            BlocConsumer<ChannelMergeCubit, bool>(
              listener: (context, state) {},
              builder: (context, stateMerge) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BlocProvider(
                          create: (context) => ToolsPdfBloc(),
                          child: BlocBuilder<ToolsPdfBloc, ToolsPdfState>(
                            builder: (context, state) {
                              if (stateMerge) {
                                pdfs.clear();
                                context
                                    .read<ToolsPdfBloc>()
                                    .add(OnCancelMerge(context, 0));
                                context
                                    .read<ChannelMergeCubit>()
                                    .changeStatus(false);
                              }
                              if (state is ToolsPickPdfMerge) {
                                if (state.pdf != null) {
                                  pdfs.add(state.pdf!);
                                  return Expanded(
                                      child: Stack(
                                    children: [
                                      PreviewMerge(themes, state.pdf!.name,
                                          state.pdf!.path),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton.filled(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            onPressed: () {
                                              context.read<ToolsPdfBloc>().add(
                                                  OnCancelMerge(context, 0));
                                              pdfs.removeAt(0);
                                            },
                                            icon: SvgPicture.asset(
                                              'assets/icons/Delete.svg',
                                              height: 30,
                                              colorFilter: ColorFilter.mode(
                                                  themes.text, BlendMode.srcIn),
                                            )),
                                      )
                                    ],
                                  ));
                                }
                              }

                              return Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      context
                                          .read<ToolsPdfBloc>()
                                          .add(OnPickPDFMerge(context));
                                    },
                                    child: PreviewMerge(themes, null, null)),
                              );
                            },
                          ),
                        ),
                        BlocProvider(
                          create: (context) => ToolsPdfBloc(),
                          child: BlocBuilder<ToolsPdfBloc, ToolsPdfState>(
                            builder: (context, state) {
                              if (stateMerge) {
                                pdfs.clear();
                                context
                                    .read<ToolsPdfBloc>()
                                    .add(OnCancelMerge(context, 1));
                                context
                                    .read<ChannelMergeCubit>()
                                    .changeStatus(false);
                              }
                              if (state is ToolsPickPdfMerge) {
                                if (state.pdf != null) {
                                  pdfs.add(state.pdf!);
                                  return Expanded(
                                      child: Stack(
                                    children: [
                                      PreviewMerge(themes, state.pdf!.name,
                                          state.pdf!.path),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton.filled(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            onPressed: () {
                                              context.read<ToolsPdfBloc>().add(
                                                  OnCancelMerge(context, 1));
                                              pdfs.removeAt(1);
                                            },
                                            icon: SvgPicture.asset(
                                              'assets/icons/Delete.svg',
                                              height: 30,
                                              colorFilter: ColorFilter.mode(
                                                  themes.text, BlendMode.srcIn),
                                            )),
                                      )
                                    ],
                                  ));
                                }
                              }
                              return Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      context
                                          .read<ToolsPdfBloc>()
                                          .add(OnPickPDFMerge(context));
                                    },
                                    child: PreviewMerge(themes, null, null)),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
            BlocProvider(
              create: (context) => ToolsPdfBloc(),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: BlocConsumer<ToolsPdfBloc, ToolsPdfState>(
                  listener: (context, state) {
                    if (state is ToolsSucces) {
                      log('length pdf: ${pdfs.length}');
                      pdfs.clear();
                      context.read<ChannelMergeCubit>().changeStatus(true);
                      ShowSnackBar(context, 'Succes Merge PDF')
                          .showSnackBar(colors: const Color(0xff4fc63b));
                    }
                  },
                  builder: (context, state) {
                    final toolsPdfBloc = context.read<ToolsPdfBloc>();
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: TextButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: themes.widget,
                              foregroundColor: themes.text,
                              minimumSize: const Size(double.infinity, 50),
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            if (pdfs.length < 2) {
                              ShowSnackBar(context, 'Please select with 2 file')
                                  .showSnackBar();
                            } else {
                              FormDialog(context).formMerge(pdfs, toolsPdfBloc);
                            }
                          },
                          child: BlocBuilder<ToolsPdfBloc, ToolsPdfState>(
                            builder: (context, state) {
                              if (state is ToolsRunning) {
                                return CircularProgressIndicator(
                                    color: themes.text);
                              }
                              return const Text('Merge Pdf');
                            },
                          )),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

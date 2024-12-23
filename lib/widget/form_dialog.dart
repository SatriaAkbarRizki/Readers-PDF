
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/bloc/tools_pdf/tools_pdf_bloc.dart';
import 'package:simplereader/cubit/theme_cubit.dart';
import 'package:simplereader/widget/scaffold_messeger.dart';

import '../model/pdfmodel.dart';
import '../model/thememodel.dart';

class FormDialog {
  FocusNode focusNode = FocusNode();
  final nameFileController = TextEditingController();
  BuildContext context;
  FormDialog(this.context);

  Thememodel get themes => context.read<ThemeCubit>().state;

  void formMerge(List<Pdfmodel> pdfs, ToolsPdfBloc toolsPdfBloc) => showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) => BlocProvider.value(
          value: toolsPdfBloc,
          child: BlocBuilder<ToolsPdfBloc, ToolsPdfState>(
            builder: (context, state) {
              return AlertDialog(
                title: Text(
                  'Rename Pdf Merge',
                  style: TextStyle(color: themes.text),
                ),
                backgroundColor: themes.widget,
                content: TextFormField(
                  controller: nameFileController,
                  focusNode: focusNode,
                  style: TextStyle(color: themes.text),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themes.text,
                            width: 1.5,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themes.text,
                            width: 1.5,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (nameFileController.text.isNotEmpty) {
                          focusNode.unfocus();

                          context.read<ToolsPdfBloc>().add(OnPDFMerge(
                              nameFileController.text, pdfs, context));
                        } else {
                          ShowSnackBar(context, 'Please give name file merge')
                              .showSnackBar();
                        }
                        context.pop();
                      },
                      child: Text(
                        'Merge',
                        style: TextStyle(color: themes.text),
                      ))
                ],
              );
            },
          ),
        ),
      );

  void formDelete(
          List<int> pageNumbers, String pdfPath, ToolsPdfBloc toolsPdfBloc) =>
      showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) => BlocProvider.value(
          value: toolsPdfBloc,
          child: BlocBuilder<ToolsPdfBloc, ToolsPdfState>(
            builder: (context, state) {
              return AlertDialog(
                title: Text(
                  'Delete Page Pdf',
                  style: TextStyle(color: themes.text),
                ),
                backgroundColor: themes.widget,
                content: TextFormField(
                  controller: nameFileController,
                  focusNode: focusNode,
                  style: TextStyle(color: themes.text),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themes.text,
                            width: 1.5,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themes.text,
                            width: 1.5,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (nameFileController.text.isNotEmpty) {
                          focusNode.unfocus();
                          pageNumbers.sort();
                          List<int> incrementValue = pageNumbers
                              .map(
                                (e) => e + 1,
                              )
                              .toList();
                          context.read<ToolsPdfBloc>().add(OnPDFDeletingPage(
                              nameFileController.text,
                              pdfPath,
                              incrementValue,
                              context));
                        } else {
                          ShowSnackBar(context, 'Please give name file pdf')
                              .showSnackBar();
                        }
                        context.pop();
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(color: themes.text),
                      ))
                ],
              );
            },
          ),
        ),
      );

  void formCompress(String path, double valueQuality, double valueScale,
          ToolsPdfBloc toolsPdfBloc) =>
      showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) => BlocProvider.value(
          value: toolsPdfBloc,
          child: BlocBuilder<ToolsPdfBloc, ToolsPdfState>(
            builder: (context, state) {
              return AlertDialog(
                title: Text(
                  'Compress Pdf',
                  style: TextStyle(color: themes.text),
                ),
                backgroundColor: themes.widget,
                content: TextFormField(
                  controller: nameFileController,
                  focusNode: focusNode,
                  style: TextStyle(color: themes.text),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themes.text,
                            width: 1.5,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themes.text,
                            width: 1.5,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (nameFileController.text.isNotEmpty) {
                          focusNode.unfocus();
                          context.read<ToolsPdfBloc>().add(OnPDFComprerssing(
                              nameFileController.text,
                              path,
                              valueQuality,
                              valueScale,
                              context));
                        } else {
                          ShowSnackBar(
                                  context, 'Please give name for compress pdf')
                              .showSnackBar();
                        }
                        context.pop();
                      },
                      child: Text(
                        'Compress',
                        style: TextStyle(color: themes.text),
                      ))
                ],
              );
            },
          ),
        ),
      );
      
  void formWatermark(
          String nameWatermark,
          String fontSize,
          double rotate,
          Alignment postionWatermark,
          Color colors,
          double valueOpacity,
          String path,
          ToolsPdfBloc toolsPdfBloc) =>
      showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) => BlocProvider.value(
          value: toolsPdfBloc,
          child: BlocBuilder<ToolsPdfBloc, ToolsPdfState>(
            builder: (context, state) {
              
              return AlertDialog(
                title: Text(
                  'Watermark Pdf',
                  style: TextStyle(color: themes.text),
                ),
                backgroundColor: themes.widget,
                content: TextFormField(
                  controller: nameFileController,
                  focusNode: focusNode,
                  style: TextStyle(color: themes.text),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themes.text,
                            width: 1.5,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themes.text,
                            width: 1.5,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (nameFileController.text.isNotEmpty) {
                          focusNode.unfocus();
                          context.read<ToolsPdfBloc>().add(OnPDFWatermark(
                              nameFileController.text,
                              nameWatermark,
                              path,
                              fontSize,
                              rotate,
                              postionWatermark,
                              colors,
                              valueOpacity,
                              context));
                        } else {
                          ShowSnackBar(
                                  context, 'Please give name for compress pdf')
                              .showSnackBar();
                        }
                        context.pop();
                      },
                      child: Text(
                        'Watermark',
                        style: TextStyle(color: themes.text),
                      ))
                ],
              );
            },
          ),
        ),
      );
}

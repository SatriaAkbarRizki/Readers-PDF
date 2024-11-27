
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/widget/preview_pdf_grid.dart';

import '../../bloc/tools_pdf/tools_pdf_bloc.dart';
import '../../cubit/click_delete.dart';
import '../../cubit/theme_cubit.dart';
import '../../widget/form_dialog.dart';
import '../../widget/preview_pdf.dart';
import '../../widget/scaffold_messeger.dart';

class DeleteScreen extends StatelessWidget {
  static String routeName = '/delete-page';
  String? pdfPath;

  DeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themes = context.read<ThemeCubit>().state;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Delete Page PDF',
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
          )),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ToolsPdfBloc(),
          ),
          BlocProvider(
            create: (context) => ClickOrderDelete(),
          ),
        ],
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocConsumer<ToolsPdfBloc, ToolsPdfState>(
                    listener: (context, state) {
                      if (state is ToolsSucces) {
                        context.read<ClickOrderDelete>().clear();
                      }
                    },
                    builder: (context, state) {
                      if (state is ToolsPickPdfTools) {
                        if (state.pdf != null) {
                          pdfPath = state.pdf!.path;
                          return Stack(
                            children: [
                              PreviewPDFGrid(
                                  themes, state.pdf!.name, state.pdf!.path),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton.filled(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    onPressed: () {
                                      context
                                          .read<ToolsPdfBloc>()
                                          .add(OnCancelMerge(context, 0));

                                      context.read<ClickOrderDelete>().clear();
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/Delete.svg',
                                      height: 30,
                                      colorFilter: ColorFilter.mode(
                                          themes.text, BlendMode.srcIn),
                                    )),
                              )
                            ],
                          );
                        }
                      }

                      return GestureDetector(
                          onTap: () {
                            context
                                .read<ToolsPdfBloc>()
                                .add(OnPickPDFMerge(context));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: PreviewPDF(themes, 'Click Here..', null),
                          ));
                    },
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocConsumer<ToolsPdfBloc, ToolsPdfState>(
                listener: (context, state) {
                  if (state is ToolsSucces) {
                    ShowSnackBar(context, 'Succes Delete PDF')
                        .showSnackBar(colors: const Color(0xff4fc63b));
                  }
                },
                builder: (context, state) {
                  final toolsPdfBloc = context.read<ToolsPdfBloc>();
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: themes.widget,
                            foregroundColor: themes.text,
                            minimumSize: const Size(double.infinity, 50),
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () {
                          if (toolsPdfBloc.state is ToolsPickPdfTools) {
                            final dataOrder = context
                                .read<ClickOrderDelete>()
                                .listOrderDelete;
                            FormDialog(context)
                                .formDelete(dataOrder, pdfPath!, toolsPdfBloc);
                          } else {
                            ShowSnackBar(context, 'Please Pick PDF')
                                .showSnackBar();
                          }
                        },
                        child: BlocBuilder<ToolsPdfBloc, ToolsPdfState>(
                          builder: (context, state) {
                            if (state is ToolsRunning) {
                              return CircularProgressIndicator(
                                  color: themes.text);
                            }
                            return const Text('Delete Pages Pdf');
                          },
                        )),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

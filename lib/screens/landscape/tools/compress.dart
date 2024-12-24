import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/cubit/slider_level.dart';
import 'package:simplereader/screens/landscape/preview_pdf.dart';

import '../../../bloc/tools_pdf/tools_pdf_bloc.dart';
import '../../../cubit/click_delete.dart';
import '../../../cubit/theme_cubit.dart';
import '../../../widget/form_dialog.dart';
import '../../../widget/preview_pdf.dart';
import '../../../widget/scaffold_messeger.dart';

class CompressScreenLandScape extends StatelessWidget {
  static String routeName = '/compress-screen';
  String? pdfPath;
  CompressScreenLandScape({super.key});

  @override
  Widget build(BuildContext context) {
    final themes = context.read<ThemeCubit>().state;

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Compresss PDF',
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
          BlocProvider(
            create: (context) => SliderCubit(0.0),
          )
        ],
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocConsumer<ToolsPdfBloc, ToolsPdfState>(
                    listener: (context, state) {
                      if (state is ToolsSucces) {
                        context.read<ClickOrderDelete>().clear();
                        context.read<SliderCubit>().reset();
                      }
                    },
                    builder: (context, state) {
                      final _value = context.watch<SliderCubit>();
                      if (state is ToolsPickPdfTools) {
                        if (state.pdf != null) {
                          pdfPath = state.pdf!.path;
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    PreviewPDFLandScape(themes, state.pdf!.name,
                                        state.pdf!.path),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton.filled(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () {
                                            context
                                                .read<ToolsPdfBloc>()
                                                .add(OnCancelMerge(context, 0));

                                            context
                                                .read<ClickOrderDelete>()
                                                .clear();

                                            context.read<SliderCubit>().reset();
                                          },
                                          icon: SvgPicture.asset(
                                            'assets/icons/Delete.svg',
                                            height: 30,
                                            colorFilter: ColorFilter.mode(
                                                themes.text, BlendMode.srcIn),
                                          )),
                                    )
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Quality Compress',
                                    style: TextStyle(color: themes.text),
                                  ),
                                ),
                                Slider(
                                  min: 0.0,
                                  max: 100.0,
                                  value: _value.valueQuality,
                                  label: '${_value.valueQuality.round()}',
                                  divisions: 20,
                                  onChanged: (value) {
                                    _value.changeValueQuality(value);
                                  },
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Image Scale',
                                    style: TextStyle(color: themes.text),
                                  ),
                                ),
                                Slider(
                                  min: 0.0,
                                  max: 5.0,
                                  value: _value.valueScale,
                                  label: '${_value.valueScale.round()}',
                                  divisions: 5,
                                  onChanged: (value) {
                                    _value.changeValueScale(value);
                                  },
                                ),
                                SizedBox(
                                  height: 100,
                                )
                              ],
                            ),
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
                            child: PreviewPDFLandScape(
                                themes, 'Click Here..', null),
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
                    ShowSnackBar(context, 'Succes Compress PDF')
                        .showSnackBar(colors: const Color(0xff4fc63b));
                  }
                },
                builder: (context, state) {
                  final toolsPdfBloc = context.read<ToolsPdfBloc>();
                  final slider = context.watch<SliderCubit>();
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
                            FormDialog(context).formCompress(
                                pdfPath!,
                                slider.valueQuality,
                                slider.valueScale,
                                toolsPdfBloc);
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
                            return const Text('Compress Pages Pdf');
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

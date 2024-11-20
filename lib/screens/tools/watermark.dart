import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/cubit/color_picker.dart';
import 'package:simplereader/cubit/slider_level.dart';

import '../../bloc/tools_pdf/tools_pdf_bloc.dart';
import '../../cubit/click_delete.dart';
import '../../cubit/theme_cubit.dart';
import '../../widget/form_dialog.dart';
import '../../widget/preview_pdf.dart';

import '../../widget/scaffold_messeger.dart';

class WatermarkScreen extends StatelessWidget {
  static String routeName = '/watermark-screen';
  String? pdfPath;
  WatermarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themes = context.read<ThemeCubit>().state;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
            'Watermark PDF',
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
          ),
          BlocProvider(
            create: (context) => ColorPickerCubit(),
          ),
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
                      final colors = context.watch<ColorPickerCubit>();
                      if (state is ToolsPickPdfTools) {
                        if (state.pdf != null) {
                          pdfPath = state.pdf!.path;
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    PreviewPDF(themes, state.pdf!.name,
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
                                    'Name Watermark',
                                    style: TextStyle(color: themes.text),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          style: TextStyle(
                                              color: themes.text, fontSize: 12),
                                          decoration: InputDecoration(
                                              hintText: 'Click To Edit',
                                              hintStyle:
                                                  TextStyle(color: themes.text),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: themes.widget),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: themes.widget),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        height: 50,
                                        margin: EdgeInsets.only(left: 10),
                                        child: Center(
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: themes.text,
                                                fontSize: 12),
                                            decoration: InputDecoration(
                                                hintText: '12',
                                                hintStyle: TextStyle(
                                                    color: themes.text),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: themes.widget),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                themes.widget),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Position Watermark',
                                    style: TextStyle(color: themes.text),
                                  ),
                                ),
                                GridView.builder(
                                  itemCount: 9,
                                  padding: const EdgeInsets.all(20),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1.5,
                                          crossAxisCount: 3),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Container(
                                    width: 50,
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: index == 4
                                            ? Colors.red
                                            : themes.widget),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Opacity',
                                    style: TextStyle(color: themes.text),
                                  ),
                                ),
                                SliderTheme(
                                    data: const SliderThemeData(
                                        showValueIndicator:
                                            ShowValueIndicator.always),
                                    child: Slider(
                                      value: _value.valueOpacity,
                                      label: _value.valueOpacity
                                          .toStringAsFixed(1),
                                      onChanged: (value) {
                                        _value.changeValueOpacity(value);
                                      },
                                    )),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Color Watermark',
                                    style: TextStyle(color: themes.text),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: ColorPicker(
                                    pickerColor: colors.pickerColor,
                                    onColorChanged: (value) =>
                                        colors.changeColor(value),
                                  ),
                                ),
                                const SizedBox(
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
                    ShowSnackBar(context, 'Succes Watermark PDF')
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
                            return const Text('Watermark Pages Pdf');
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

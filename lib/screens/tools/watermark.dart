import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/cubit/color_picker.dart';
import 'package:simplereader/cubit/edit_watermark.dart';
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
          BlocProvider(
            create: (context) => EditWatermark(),
          ),
        ],
        child: Builder(builder: (context) {
          final _value = context.watch<SliderCubit>();
          final colors = context.watch<ColorPickerCubit>();
          final watermark = context.watch<EditWatermark>();
          return Stack(
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
                          context.read<EditWatermark>().resetWatermark();
                        }
                      },
                      builder: (context, state) {
                        if (state is ToolsPickPdfTools) {
                          if (state.pdf != null) {
                            pdfPath = state.pdf!.path;
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      PreviewPDF(themes, state.pdf!.name,
                                          state.pdf!.path),
                                      Container(
                                        height: 260,
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 12),
                                        alignment: watermark.postionWatermark,
                                        child: Transform.rotate(
                                          angle: watermark.rotateValue,
                                          child: Text(
                                            watermark.nameWatermark,
                                            style: TextStyle(
                                                color: colors.pickerColor,
                                                fontSize: double.parse(
                                                    watermark.fontSize)),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton.filled(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            onPressed: () async {
                                              context.read<ToolsPdfBloc>().add(
                                                  OnCancelMerge(context, 0));

                                              context
                                                  .read<ClickOrderDelete>()
                                                  .clear();

                                              context
                                                  .read<SliderCubit>()
                                                  .reset();
                                              context
                                                  .read<EditWatermark>()
                                                  .resetWatermark();
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
                                            controller: watermark
                                                .watermarkNameController,
                                            onEditingComplete: () {
                                              watermark.changeWatermark(
                                                  watermark
                                                      .watermarkNameController
                                                      .text);

                                              FocusScope.of(context).unfocus();
                                            },
                                            style: TextStyle(
                                                color: themes.text,
                                                fontSize: 12),
                                            decoration: InputDecoration(
                                                hintText: 'Click To Edit',
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
                                        Container(
                                          width: 80,
                                          height: 50,
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: Center(
                                            child: TextFormField(
                                              controller:
                                                  watermark.fontSizeController,
                                              keyboardType:
                                                  TextInputType.number,
                                              onEditingComplete: () {
                                                watermark.changeFontSize(
                                                    watermark.fontSizeController
                                                        .text);

                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: themes.text,
                                                  fontSize: 12),
                                              decoration: InputDecoration(
                                                  hintText: '24',
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
                                                              color: themes
                                                                  .widget),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20))),
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
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () =>
                                          watermark.changePosition(index),
                                      child: Container(
                                        width: 50,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color:
                                                index == watermark.indexPosition
                                                    ? Colors.red
                                                    : themes.widget),
                                      ),
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
                                      'Rotate',
                                      style: TextStyle(color: themes.text),
                                    ),
                                  ),
                                  DropdownButtonFormField(
                                    value: watermark.rotateValue,
                                    items: watermark.dropMenuItem,
                                    onChanged: (value) =>
                                        watermark.changeRotate(value!),
                                    decoration: InputDecoration(
                                        enabled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: themes.widget,
                                                width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: themes.widget))),
                                    dropdownColor: themes.widget,
                                    style: TextStyle(color: themes.text),
                                  ),
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
                            if (toolsPdfBloc.state is ToolsPickPdfTools) {
                              FormDialog(context).formWatermark(
                                  watermark.nameWatermark,
                                  watermark.fontSize,
                                  watermark.rotateValue,
                                  watermark.postionWatermark,
                                  colors.pickerColor,
                                  _value.valueOpacity,
                                  pdfPath!,
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
          );
        }),
      ),
    );
  }
}

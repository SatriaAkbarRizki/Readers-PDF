import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/bloc/pdf/pdf_bloc.dart';
import 'package:simplereader/cubit/status_permission.dart';
import 'package:simplereader/screens/empty.dart';
import 'package:simplereader/screens/search.dart';
import 'package:simplereader/type/empty_type.dart';
import 'package:simplereader/screens/landscape/widget/listpdf.dart';
import 'package:simplereader/widget/listpdf.dart';
import 'package:simplereader/widget/bottomsheet.dart';

import '../cubit/theme_cubit.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  static const _methodChannel = MethodChannel("com.satriadevz.simplereader");
  String? dataShared;

  Future<void> getSharedData() async {
    try {
      final sharedData = await _methodChannel.invokeMethod('getSharedText');
      if (sharedData != null && mounted) {
        final results = Uri.parse(sharedData);
        if (results.scheme == 'file') {
          final filePath = results.path;
          context
              .read<PdfBloc>()
              .add(OnPdfOpenFileIntent(path: filePath, context: context));
        } else {
          final file = File.fromUri(results);

          context
              .read<PdfBloc>()
              .add(OnPdfOpenFileIntent(path: file.path, context: context));
        }
      }
    } catch (e) {
      log("Error fetching shared data: $e");
    }
  }

  @override
  void initState() {
    if (context.mounted) {
      getSharedData();
    }
    context.read<StatusPermissionCubit>().listenStatusPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themes = context.watch<ThemeCubit>().state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themes.background,
        forceMaterialTransparency: true,
        title: Text(
          'Simple Reader',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: themes.text),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                context.push(SearchScreen.routeName, extra: themes),
            icon: const Icon(Icons.search),
            color: themes.widget,
          )
        ],
      ),
      body: BlocConsumer<StatusPermissionCubit, bool>(
        listener: (context, state) {
          // log("here");
          // if (state == false) {
          //   // Future.delayed(
          //   //   Duration(seconds: 10),
          //   //   () => {
          //   //     if (context.mounted)
          //   //       {showBottomSheetPermission(context, themes)}
          //   //   },
          //   // );
          // }
        },
        builder: (context, state) {
          if (state == true) {
            return LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return const ListPDFLandScape();
              } else {
                return const ListPDF();
              }
            });
          } else {
            return const EmptyScreens(
              type: TypeEmpty.noPermission,
            );
          }
        },
      ),
    );
  }
}

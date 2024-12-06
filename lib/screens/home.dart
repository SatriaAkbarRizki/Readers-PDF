import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/bloc/pdf/pdf_bloc.dart';
import 'package:simplereader/cubit/status_permission.dart';
import 'package:simplereader/database/theme.dart';
import 'package:simplereader/screens/empty.dart';
import 'package:simplereader/screens/search.dart';
import 'package:simplereader/type/empty_type.dart';
import 'package:simplereader/widget/listpdf.dart';
import 'package:simplereader/widget/bottomsheet.dart';

import '../cubit/theme_cubit.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  static const _methodChannel = MethodChannel("com.example.simplereader");
  String? dataShared;

  Future<void> getSharedData() async {
    try {
      final sharedData = await _methodChannel.invokeMethod('getSharedText');
      if (sharedData is String) {
          if (mounted){
                context
            .read<PdfBloc>()
            .add(OnPdfOpenFileIntent(path: sharedData, context: context));
          }
      }
    } catch (e) {
      print("Error fetching shared data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedData();
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
          if (state == false) {
            log("Not have permission");
            Future.delayed(
              Duration.zero,
              () => showBottomSheetPermission(context, themes),
            );
          }
        },
        builder: (context, state) {
          if (state == true) {
            return const ListPDF();
          } else {
            return EmptyScreens(
              type: TypeEmpty.noPermission,
            );
          }
        },
      ),
    );
  }
}

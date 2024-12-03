import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplereader/cubit/status_permission.dart';
import 'package:simplereader/screens/empty.dart';
import 'package:simplereader/type/empty_type.dart';
import 'package:simplereader/widget/listpdf.dart';
import 'package:simplereader/widget/bottomsheet.dart';

import '../cubit/theme_cubit.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

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
            onPressed: () => showBottomSheetPermission(context, themes),
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

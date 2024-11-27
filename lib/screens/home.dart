import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplereader/widget/listpdf.dart';

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
      ),
      body: const ListPDF(),
    );
  }
}

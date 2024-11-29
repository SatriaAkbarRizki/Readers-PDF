import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/screens/search.dart';
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
        actions: [
          IconButton(
            onPressed: () =>
                context.push(SearchScreen.routeName, extra: themes),
            icon: const Icon(Icons.search),
            color: themes.widget,
          )
        ],
      ),
      body: const ListPDF(),
    );
  }
}

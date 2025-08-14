import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplereader/cubit/theme_cubit.dart';
import 'package:simplereader/model/thememodel.dart';

class TitleProfile extends StatelessWidget {
  final String title;

  double? sizeFont;
  TitleProfile({super.key, required this.title, this.sizeFont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, Thememodel>(
      builder: (context, state) {
        return Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: sizeFont ?? 18, color: state.text),
        );
      },
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simplereader/cubit/theme_cubit.dart';
import 'package:simplereader/model/thememodel.dart';

import 'package:simplereader/type/empty_type.dart';

class EmptyScreens extends StatelessWidget {
  final TypeEmpty type;

  const EmptyScreens({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: switch (type) {
          TypeEmpty.emptyPdf =>
            emptyWidget('No Pdf Here', 'assets/image/documentempty.svg'),
          TypeEmpty.emptyAudio =>
            emptyWidget('No Audio Here', 'assets/image/audioempty.svg'),
        },
      ),
    );
  }

  Widget emptyWidget(String name, String path) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          path,
          height: 200,
          width: 200,
        ),
        const SizedBox(
          height: 15,
        ),
        BlocBuilder<ThemeCubit, Thememodel>(
          builder: (context, state) {
            return Text(
              name,
              style: TextStyle(color: state.text),
            );
          },
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../model/thememodel.dart';

class TitleTools extends StatelessWidget {
  final String title, path;
  final Thememodel themes;
  const TitleTools(this.title, this.path, this.themes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: themes.widget, borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: themes.text == Colors.white
                      ? themes.background
                      : themes.text),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                path,
              ),
            )
          ],
        ),
      ),
    );
  }
}

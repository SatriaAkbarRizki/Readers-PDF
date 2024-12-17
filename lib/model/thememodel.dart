import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'thememodel.g.dart';

@HiveType(typeId: 1)
class Thememodel {
  @HiveField(0)
  int indexTheme;

  @HiveField(1)
  Color background;

  @HiveField(2)
  Color widget;

  @HiveField(3)
  Color text;

  Thememodel(
    this.indexTheme,
    this.background,
    this.widget,
    this.text,
  );
}

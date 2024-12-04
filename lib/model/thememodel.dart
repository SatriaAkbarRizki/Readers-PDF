import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'thememodel.g.dart';

@HiveType(typeId: 1)
class Thememodel {
  @HiveField(0)
  Color background; 

  @HiveField(1)
  Color widget; 

  @HiveField(2)
  Color text; 

  Thememodel(
    this.background,
    this.widget,
    this.text,
  );
}

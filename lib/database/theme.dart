
import 'package:hive_flutter/hive_flutter.dart';

import '../model/thememodel.dart';

class DatabasesTheme {
  static late Box<Thememodel> box;


  static Future<void> createBox() async {
    box = await Hive.openBox<Thememodel>("themeBox");
  }

  static Future<Thememodel?> getHiveTheme() async {
    await createBox();

    final value = box.get(1);
    return value;
  }

  static Future<void> putHiveTheme(Thememodel theme) async {
    await createBox();
    box.put(1, theme);
  }
}

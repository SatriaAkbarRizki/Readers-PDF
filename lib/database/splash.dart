
import 'package:hive_flutter/hive_flutter.dart';

class DatabasesSplash {
  static late Box<bool> boxSplash;

  static Future createBoxSplash() async {
    boxSplash = await Hive.openBox("splashBox");
  }

  static Future<bool?> getSplashHive() async {
    await createBoxSplash();
    final value = boxSplash.get(1);
    return value;
  }

  static Future putSplashHive(bool value) async {
    await createBoxSplash();
    boxSplash.put(1, value);
  }
}

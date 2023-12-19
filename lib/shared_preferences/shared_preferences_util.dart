import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static Future<void> dump() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getKeys().forEach(
      (key) {
        debugPrint('key=$key, value=${prefs.get(key)}');
      },
    );
  }
}

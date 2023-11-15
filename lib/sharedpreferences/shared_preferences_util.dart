import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> dumpSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.getKeys().forEach(
    (key) {
      debugPrint('SharedPreferences key = $key, value = ${prefs.get(key)}');
    },
  );
}

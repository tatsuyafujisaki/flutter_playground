import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> get prefs async => SharedPreferences.getInstance();

extension SharedPreferencesExtension on SharedPreferences {
  int get keyCount => getKeys().length;

  void dump() {
    getKeys().forEach(
      (key) => debugPrint('key=$key, value=${get(key)}'),
    );
  }
}

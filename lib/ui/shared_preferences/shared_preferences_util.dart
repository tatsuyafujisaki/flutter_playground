import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> get prefs async => SharedPreferences.getInstance();

extension SharedPreferencesExtension on SharedPreferences {
  int get keyCount => getKeys().length;

  void dump() {
    getKeys().forEach((key) => developer.log('key=$key, value=${get(key)}'));
  }
}

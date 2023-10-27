import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static int? getInt(String key) => _prefs.getInt(key);
  static bool? getBool(String key) => _prefs.getBool(key);
  static double? getDouble(String key) => _prefs.getDouble(key);
  static String getString(String key) => _prefs.getString(key) ?? '';
  static List<String> getStringList(String key) =>
      _prefs.getStringList(key) ?? [];

  static Future<bool> setInt(String key, int value) =>
      _prefs.setInt(key, value);
  static Future<bool> setBool(String key, bool value) async =>
      _prefs.setBool(key, value);
  static Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);
  static Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);
  static Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);
}

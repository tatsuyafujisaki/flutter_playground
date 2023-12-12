import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static int? getInt(String key) => _prefs.getInt(key);
  static Future<bool> setInt(String key, int value) =>
      _prefs.setInt(key, value);

  static bool? getBool(String key) => _prefs.getBool(key);
  static Future<bool> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  static double? getDouble(String key) => _prefs.getDouble(key);
  static Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  static String getString(String key) => _prefs.getString(key) ?? '';
  static Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  static List<String> getStringList(String key) =>
      _prefs.getStringList(key) ?? [];
  static Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  static Future<void> remove(String key) => _prefs.remove(key);
  static Future<void> clear() => _prefs.clear();
}

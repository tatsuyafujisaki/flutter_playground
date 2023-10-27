import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper {
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static late SharedPreferences _prefs;

  static Future<int?> getInt(String key) async => _prefs.getInt(key);
  static Future<bool?> getBool(String key) async => _prefs.getBool(key);
  static Future<double?> getDouble(String key) async => _prefs.getDouble(key);
  static Future<String> getString(String key) async =>
      _prefs.getString(key) ?? '';
  static Future<List<String>> getStringList(String key) async =>
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

import 'package:flutter/widgets.dart';
import 'package:flutter_playground/util/encryptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EncryptedSharedPreferences {
  static late final SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getString(String key) =>
      Encryptor.decrypt(_prefs.getString(key) ?? '');
  static Future<bool> setString(String key, String value) =>
      _prefs.setString(key, Encryptor.encrypt(value));

  static List<String> getStringList(String key) =>
      (_prefs.getStringList(key) ?? []).map(Encryptor.decrypt).toList();
  static Future<bool> setStringList(String key, Iterable<String> value) =>
      _prefs.setStringList(key, value.map(Encryptor.encrypt).toList());
  static Future<bool> addToStringList(String key, String value) =>
      setStringList(key, getStringList(key)..add(value));

  static Future<void> remove(String key) => _prefs.remove(key);
  static Future<void> clear() => _prefs.clear();

  static void dump() {
    _prefs.getKeys().forEach(
          (key) => debugPrint('key=$key, value=${_prefs.get(key)}'),
        );
  }
}

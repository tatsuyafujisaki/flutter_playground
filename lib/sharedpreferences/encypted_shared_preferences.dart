import 'package:flutter_playground/util/encryptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EncryptedSharedPreferences {
  static late final SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getString(String key) =>
      Encryptor.decrypt(_prefs.getString(key) ?? '');

  static List<String> getStringList(String key) =>
      (_prefs.getStringList(key) ?? []).map(Encryptor.decrypt).toList();

  static Future<bool> setString(String key, String value) => value.isEmpty
      ? Future.value(false)
      : _prefs.setString(key, Encryptor.encrypt(value));

  static Future<bool> setStringList(String key, List<String> value) =>
      value.isEmpty
          ? Future.value(false)
          : _prefs.setStringList(key, value.map(Encryptor.encrypt).toList());
}

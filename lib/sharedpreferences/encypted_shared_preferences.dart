import 'package:flutter_playground/util/encryptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EncryptedSharedPreferences {
  static late final SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getString(String key) {
    final encrypted = _prefs.getString(key) ?? '';
    if (encrypted.isEmpty) {
      return '';
    } else {
      return Encryptor.decrypt(encrypted);
    }
  }

  static Future<bool> setString(String key, String value) {
    if (value.isEmpty) {
      return Future.value(false);
    } else {
      return _prefs.setString(key, Encryptor.encrypt(value));
    }
  }
}

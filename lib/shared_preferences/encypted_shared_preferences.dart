import 'package:flutter/widgets.dart';
import 'package:flutter_playground/util/encryptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EncryptedSharedPreferences {
  static late final SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getString(String key) => decrypt(_prefs.getString(key) ?? '');

  @visibleForTesting
  static String getEncryptedString(String key) => _prefs.getString(key) ?? '';

  static List<String> getStringList(String key) =>
      (_prefs.getStringList(key) ?? []).map(decrypt).toList();

  static Future<void> setString(String key, String value) =>
      _prefs.setString(key, encrypt(value));

  static Future<void> setStringList(String key, Iterable<String> value) =>
      _prefs.setStringList(key, value.map(encrypt).toList());

  static Future<void> addToStringList(String key, String value) =>
      _prefs.setStringList(key, getStringList(key)..add(value));

  static Future<void> addToStringListIfAbsent(
    String key,
    String value, [
    Future<void> Function()? onAvoidDuplicateValue,
  ]) async {
    final encryptedList = _prefs.getStringList(key) ?? [];
    final encryptedValue = encrypt(value);
    if (encryptedList.contains(encryptedValue)) {
      await onAvoidDuplicateValue?.call();
    } else {
      await _prefs.setStringList(key, [...encryptedList, encryptedValue]);
    }
  }

  static Future<void> remove(String key) => _prefs.remove(key);
  static Future<void> clear() => _prefs.clear();

  static void dump() {
    _prefs.getKeys().forEach(
          (key) => debugPrint('key=$key, value=${_prefs.get(key)}'),
        );
  }

  static void dumpCount() {
    debugPrint('length=${_prefs.getKeys().length}');
  }
}

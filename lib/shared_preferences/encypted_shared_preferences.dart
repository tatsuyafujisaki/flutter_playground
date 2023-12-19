import 'package:flutter/widgets.dart';
import 'package:flutter_playground/util/encryptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EncryptedSharedPreferences {
  static late final SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String getString(String key) =>
      Encryptor.decrypt(_prefs.getString(key) ?? '');

  List<String> getStringList(String key) =>
      (_prefs.getStringList(key) ?? []).map(Encryptor.decrypt).toList();

  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, Encryptor.encrypt(value));

  Future<bool> setStringList(String key, Iterable<String> value) =>
      _prefs.setStringList(key, value.map(Encryptor.encrypt).toList());

  Future<bool> addToStringList(String key, String value) =>
      _prefs.setStringList(key, getStringList(key)..add(value));

  Future<bool> addToStringListIfAbsent(
    String key,
    String value,
    Future<void> Function() onAvoidDuplicateValue,
  ) async {
    final encryptedList = _prefs.getStringList(key) ?? [];
    final encryptedValue = Encryptor.encrypt(value);
    if (encryptedList.contains(encryptedValue)) {
      await onAvoidDuplicateValue();
      return Future.value(false);
    } else {
      return _prefs.setStringList(key, [...encryptedList, encryptedValue]);
    }
  }

  Future<void> remove(String key) => _prefs.remove(key);
  Future<void> clear() => _prefs.clear();

  void dump() {
    _prefs.getKeys().forEach(
          (key) => debugPrint('key=$key, value=${_prefs.get(key)}'),
        );
  }

  void dumpCount() {
    debugPrint('length=${_prefs.getKeys().length}');
  }
}

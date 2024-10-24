import 'package:flutter/widgets.dart';
import 'package:flutter_playground/util/encryptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EncryptedSharedPreferences {
  factory EncryptedSharedPreferences() => _singleton;
  EncryptedSharedPreferences._();
  static final _singleton = EncryptedSharedPreferences._();
  late final SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String getString(String key) => decrypt(_prefs.getString(key) ?? '');

  @visibleForTesting
  String getEncryptedString(String key) => _prefs.getString(key) ?? '';

  List<String> getStringList(String key) =>
      (_prefs.getStringList(key) ?? []).map(decrypt).toList();

  @visibleForTesting
  List<String> getEncryptedStringList(String key) =>
      (_prefs.getStringList(key) ?? []).toList();

  Future<void> setString(String key, String value) =>
      _prefs.setString(key, encrypt(value));

  Future<void> setStringList(String key, Iterable<String> value) =>
      _prefs.setStringList(key, value.map(encrypt).toList());

  Future<void> addToStringList(String key, String value) =>
      _prefs.setStringList(key, getStringList(key)..add(value));

  Future<void> addToStringListIfAbsent(
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

  Future<void> remove(String key) => _prefs.remove(key);
  Future<void> clear() => _prefs.clear();

  void dump() {
    _prefs.getKeys().forEach(
          (key) => debugPrint('key=$key, value=${_prefs.get(key)}'),
        );
  }

  int get dumpCount => _prefs.getKeys().length;
}

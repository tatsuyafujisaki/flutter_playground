import 'package:shared_preferences/shared_preferences.dart';

class _SharedPreferencesHoldingClass {
  _SharedPreferencesHoldingClass._privateConstructor();
  late final SharedPreferences prefs;

  Future<void> _initializeSharePreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<_SharedPreferencesHoldingClass> get instance async {
    final myClass = _SharedPreferencesHoldingClass._privateConstructor();
    await myClass._initializeSharePreferences();
    return myClass;
  }
}

void main() async {
  final sharedPreferencesHoldingClass =
      await _SharedPreferencesHoldingClass.instance;
}

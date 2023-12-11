import 'package:shared_preferences/shared_preferences.dart';

class _SharedPreferencesHoldingClass {
  _SharedPreferencesHoldingClass._();
  late final SharedPreferences prefs;

  Future<void> _initializeSharePreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<_SharedPreferencesHoldingClass> get instance async {
    final myClass = _SharedPreferencesHoldingClass._();
    await myClass._initializeSharePreferences();
    return myClass;
  }
}

void main() async {
  final myClass = await _SharedPreferencesHoldingClass.instance;
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHoldingClass {
  SharedPreferencesHoldingClass._();
  late final SharedPreferences prefs;

  Future<void> _initializeSharePreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<SharedPreferencesHoldingClass> getInstance() async {
    final myClass = SharedPreferencesHoldingClass._();
    await myClass._initializeSharePreferences();
    return myClass;
  }
}

void main() async {
  final myClass = await SharedPreferencesHoldingClass.getInstance();
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper2 {
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static late SharedPreferences prefs;
}

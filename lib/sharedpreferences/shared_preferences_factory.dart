import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesFactory {
  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  static late SharedPreferences instance;
}

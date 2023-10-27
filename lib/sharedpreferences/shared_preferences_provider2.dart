import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider2 {
  static late SharedPreferences instance;

  static Future<void> initialize() async {
    instance = await SharedPreferences.getInstance();
  }
}

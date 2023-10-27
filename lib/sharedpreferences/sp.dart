import 'package:shared_preferences/shared_preferences.dart';

class SP {
  static late SharedPreferences instance;

  static Future<void> initialize() async {
    instance = await SharedPreferences.getInstance();
  }
}

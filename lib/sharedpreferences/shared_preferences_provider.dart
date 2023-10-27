import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  SharedPreferencesProvider._(SharedPreferences sharedPreferences)
      : instance = sharedPreferences;
  static SharedPreferencesProvider? _instance;
  final SharedPreferences instance;

  static Future<SharedPreferencesProvider> getInstance() async {
    _instance ??=
        SharedPreferencesProvider._(await SharedPreferences.getInstance());
    return _instance!;
  }
}

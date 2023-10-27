import 'package:shared_preferences/shared_preferences.dart';

/// The implementation is complex, but requires no initialization.
class SharedPreferencesProvider1 {
  SharedPreferencesProvider1._(SharedPreferences sharedPreferences)
      : instance = sharedPreferences;
  static SharedPreferencesProvider1? _instance;
  final SharedPreferences instance;

  static Future<SharedPreferencesProvider1> getInstance() async {
    _instance ??=
        SharedPreferencesProvider1._(await SharedPreferences.getInstance());
    return _instance!;
  }
}

/// The implementation is simple, but requires the following initialization.
///
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await SharedPreferencesProvider2.initialize();
///   runApp(child: const MyApp());
/// }
class SharedPreferencesProvider2 {
  static late SharedPreferences instance;

  static Future<void> initialize() async {
    instance = await SharedPreferences.getInstance();
  }
}

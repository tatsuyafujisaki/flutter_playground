import 'package:shared_preferences/shared_preferences.dart';

/// The implementation is complex, but requires no initialization.
class SharedPreferencesProvider1 {
  SharedPreferencesProvider1._(SharedPreferences sharedPreferences)
      : _prefs = sharedPreferences;
  static SharedPreferencesProvider1? _instance;
  final SharedPreferences _prefs;

  static Future<SharedPreferences> get prefs async {
    _instance ??=
        SharedPreferencesProvider1._(await SharedPreferences.getInstance());
    return _instance!._prefs;
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
  static late final SharedPreferences prefs;

  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
  }
}

void main() async {
  final prefs1 = SharedPreferencesProvider1.prefs;

  await SharedPreferencesProvider2.initialize();
  final prefs2 = SharedPreferencesProvider2.prefs;
}

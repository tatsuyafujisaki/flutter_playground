import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _key = 'key';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _showBoolExamples();
  await _showDoubleExamples();
  await _showIntExamples();
  await _showStringExamples();
  await _showStringListExamples();

  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

Future<void> _showBoolExamples() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_key, true);
  debugPrint('$_key: ${prefs.getBool(_key)}'); // true
  await prefs.remove(_key);
  debugPrint('$_key: ${prefs.getBool(_key)}'); // null
}

Future<void> _showDoubleExamples() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble(_key, 3.14);
  debugPrint('$_key: ${prefs.getDouble(_key)}'); // 3.14
  await prefs.remove(_key);
  debugPrint('$_key: ${prefs.getBool(_key)}'); // null
}

Future<void> _showIntExamples() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(_key, 42);
  debugPrint('$_key: ${prefs.getInt(_key)}'); // 42
  await prefs.remove(_key);
  debugPrint('$_key: ${prefs.getInt(_key)}'); // null
}

Future<void> _showStringExamples() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_key, '🍎');
  debugPrint('$_key: ${prefs.getString(_key)}'); // 🍎
  await prefs.remove(_key);
  debugPrint('$_key: ${prefs.getString(_key)}'); // null
}

Future<void> _showStringListExamples() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(_key, <String>['🍎', '🍊']);
  debugPrint('$_key: ${prefs.getStringList(_key)}'); // [🍎, 🍊]
  await prefs.remove(_key);
  debugPrint('$_key: ${prefs.getStringList(_key)}'); // null
}

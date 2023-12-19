import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test(
    'Can get a prepopulated string from SharedPreferences',
    () async {
      const name = 'John';
      SharedPreferences.setMockInitialValues({'name': name});
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('name'), name);
    },
  );

  test(
    'Can set a string to and get a string from SharedPreferences',
    () async {
      final prefs = await SharedPreferences.getInstance();
      const name = 'John';
      await prefs.setString('name', name);
      expect(prefs.getString('name'), name);
    },
  );
}

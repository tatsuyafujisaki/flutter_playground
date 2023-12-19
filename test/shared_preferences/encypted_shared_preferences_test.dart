import 'package:flutter_playground/shared_preferences/encypted_shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(
    () async {
      // SharedPreferences.setMockInitialValues() must be called
      // before SharedPreferences.getInstance()
      // because setMockInitialValues() replaces the instance
      // with a test instance.
      // https://github.com/flutter/flutter/issues/106514#issuecomment-1164771569
      SharedPreferences.setMockInitialValues({});
      await EncryptedSharedPreferences.initialize();
    },
  );

  test(
    'Can set a string to and get a string from EncryptedSharedPreferences',
    () async {
      const name = 'John';
      await EncryptedSharedPreferences.setString('name', name);
      expect(EncryptedSharedPreferences.getString('name'), name);
    },
  );
}

import 'package:flutter_playground/shared_preferences/encypted_shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const key = 'myKey';

  setUpAll(() async {
    // SharedPreferences.setMockInitialValues() must be called
    // before SharedPreferences.getInstance()
    // because setMockInitialValues() replaces the instance
    // with a test instance.
    // https://github.com/flutter/flutter/issues/106514#issuecomment-1164771569
    SharedPreferences.setMockInitialValues({});
    await EncryptedSharedPreferences().initialize();
  });

  tearDown(() async {
    await EncryptedSharedPreferences().clear();
  });

  test('Can set, encrypt, and get a string', () async {
    const value = 'value';
    await EncryptedSharedPreferences().setString(key, value);
    expect(
      EncryptedSharedPreferences().getEncryptedString(key),
      isNot(EncryptedSharedPreferences().getString(key)),
    );
    expect(EncryptedSharedPreferences().getString(key), value);
  });

  test('Can set, encrypt, and get a string list', () async {
    final xs = ['value1', 'value2'];
    await EncryptedSharedPreferences().setStringList(key, xs);
    expect(EncryptedSharedPreferences().getEncryptedStringList(key), isNot(xs));
    expect(EncryptedSharedPreferences().getStringList(key), xs);
  });

  test('Can add a string to a string list', () async {
    await EncryptedSharedPreferences().setStringList(key, ['value1']);
    await EncryptedSharedPreferences().addToStringListIfAbsent(key, 'value2');
    expect(EncryptedSharedPreferences().getStringList(key), [
      'value1',
      'value2',
    ]);
  });

  test('Cannot add a duplicate string', () async {
    const value = 'value';
    await EncryptedSharedPreferences().addToStringListIfAbsent(key, value);

    await EncryptedSharedPreferences().addToStringListIfAbsent(key, value);

    expect(EncryptedSharedPreferences().getStringList(key), [value]);
  });

  test(
    'A given callback is invoked when you try to add a duplicate string',
    () async {
      var onAvoidDuplicateValueCalled = false;

      Future<void> onAvoidDuplicateValue() async {
        onAvoidDuplicateValueCalled = true;
      }

      await EncryptedSharedPreferences().addToStringListIfAbsent(key, 'value');

      await EncryptedSharedPreferences().addToStringListIfAbsent(
        key,
        'value',
        onAvoidDuplicateValue,
      );

      expect(onAvoidDuplicateValueCalled, isTrue);
    },
  );
}

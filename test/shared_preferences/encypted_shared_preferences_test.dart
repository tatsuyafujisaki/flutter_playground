import 'package:flutter_playground/shared_preferences/encypted_shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const key = 'myKey';

  setUpAll(
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

  tearDown(
    () async {
      await EncryptedSharedPreferences.clear();
    },
  );

  test('EncryptedSharedPreferences encrypts a string', () async {
    const myValue = 'myValue';
    await EncryptedSharedPreferences.setString(key, myValue);

    expect(
      EncryptedSharedPreferences.getEncryptedString(key),
      isNot(EncryptedSharedPreferences.getString(key)),
    );
  });

  test(
    'Can set a string to and get a string',
    () async {
      const myValue = 'myValue';
      await EncryptedSharedPreferences.setString(key, myValue);
      expect(EncryptedSharedPreferences.getString(key), myValue);
    },
  );

  test(
    'Can set a string list at once to and get a string list',
    () async {
      final xs = ['myValue1', 'myValue2'];
      await EncryptedSharedPreferences.setStringList(
        key,
        xs,
      );
      expect(
        EncryptedSharedPreferences.getStringList(key),
        xs,
      );
    },
  );

  test(
    'Can add multiple strings one after the other and get a string list',
    () async {
      await EncryptedSharedPreferences.addToStringListIfAbsent(
        key,
        'myValue1',
      );
      await EncryptedSharedPreferences.addToStringListIfAbsent(
        key,
        'myValue2',
      );
      expect(
        EncryptedSharedPreferences.getStringList(key),
        ['myValue1', 'myValue2'],
      );
    },
  );

  test(
    'Cannot add a duplicate string',
    () async {
      await EncryptedSharedPreferences.addToStringListIfAbsent(
        key,
        'myValue',
      );

      await EncryptedSharedPreferences.addToStringListIfAbsent(
        key,
        'myValue',
      );

      expect(
        EncryptedSharedPreferences.getStringList(key),
        ['myValue'],
      );
    },
  );

  test(
    'A given callback is invoked when you try to add a duplicate string',
    () async {
      var onAvoidDuplicateValueCalled = false;

      Future<void> onAvoidDuplicateValue() async {
        onAvoidDuplicateValueCalled = true;
      }

      await EncryptedSharedPreferences.addToStringListIfAbsent(
        key,
        'myValue',
      );

      await EncryptedSharedPreferences.addToStringListIfAbsent(
        key,
        'myValue',
        onAvoidDuplicateValue,
      );

      expect(onAvoidDuplicateValueCalled, isTrue);
    },
  );
}

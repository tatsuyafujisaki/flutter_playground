import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const String _sharedPreferencesUserIdKey = 'userId';

Future<String> getOrCreateUserId() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final existingUserId = prefs.getString(_sharedPreferencesUserIdKey);

    if (existingUserId != null) {
      return existingUserId;
    }

    final userId = const Uuid().v4();
    await prefs.setString(_sharedPreferencesUserIdKey, userId);
    return userId;
  } on Exception catch (error, stackTrace) {
    developer.log('', error: error, stackTrace: stackTrace);
    rethrow;
  }
}

import 'dart:developer' as developer;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const String _sharedPreferencesUserIdKey = 'userId';

Future<String> getOrCreateUserId() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final existingUserId = prefs.getString(_sharedPreferencesUserIdKey);

    final userId = existingUserId ?? const Uuid().v4();
    if (existingUserId == null) {
      await prefs.setString(_sharedPreferencesUserIdKey, userId);
    }
    await FirebaseAnalytics.instance.setUserId(id: userId);
    return userId;
  } on Exception catch (error, stackTrace) {
    developer.log('', error: error, stackTrace: stackTrace);
    rethrow;
  }
}

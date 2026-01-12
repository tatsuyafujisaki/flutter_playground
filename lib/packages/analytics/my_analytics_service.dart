import 'dart:developer' as developer;

import 'package:firebase_analytics/firebase_analytics.dart';

class MyAnalyticsService {
  MyAnalyticsService() {
    _analytics = FirebaseAnalytics.instance;
  }

  late final FirebaseAnalytics _analytics;

  FirebaseAnalytics get analytics => _analytics;

  Future<void> logAppOpen() async {
    try {
      await _analytics.logAppOpen();
    } on Exception catch (error, stackTrace) {
      developer.log('', error: error, stackTrace: stackTrace);
    }
  }

  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
      );
    } on Exception catch (error, stackTrace) {
      developer.log('', error: error, stackTrace: stackTrace);
    }
  }

  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics.logEvent(name: name, parameters: parameters);
    } on Exception catch (error, stackTrace) {
      developer.log('', error: error, stackTrace: stackTrace);
    }
  }

  Future<void> setUserProperty({required String name, String? value}) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } on Exception catch (error, stackTrace) {
      developer.log('', error: error, stackTrace: stackTrace);
    }
  }

  Future<void> setUserId(String? userId) async {
    try {
      await _analytics.setUserId(id: userId);
    } on Exception catch (error, stackTrace) {
      developer.log('', error: error, stackTrace: stackTrace);
    }
  }
}

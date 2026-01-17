import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class IntlUtils {
  void printLocales() {
    developer.log('👀Intl.defaultLocale: ${Intl.defaultLocale}');
    developer.log('👀Intl.systemLocale: ${Intl.systemLocale}');
    developer.log('👀Intl.getCurrentLocale(): ${Intl.getCurrentLocale()}');

    final locale = PlatformDispatcher.instance.locale;
    developer.log('👀Locale: $locale');
    developer.log('👀Locale.countryCode: ${locale.countryCode}');
    developer.log('👀Locale.languageCode: ${locale.languageCode}');
  }
}

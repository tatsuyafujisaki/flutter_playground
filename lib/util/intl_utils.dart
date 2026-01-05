import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

void printLocales() {
  debugPrint('👀Intl.defaultLocale: ${Intl.defaultLocale}');
  debugPrint('👀Intl.systemLocale: ${Intl.systemLocale}');
  debugPrint('👀Intl.getCurrentLocale(): ${Intl.getCurrentLocale()}');

  final locale = PlatformDispatcher.instance.locale;
  debugPrint('👀Locale: $locale');
  debugPrint('👀Locale.countryCode: ${locale.countryCode}');
  debugPrint('👀Locale.languageCode: ${locale.languageCode}');
}

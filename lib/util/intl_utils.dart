import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void printLocales(BuildContext? context) {
  debugPrint('👀Intl.defaultLocale: ${Intl.defaultLocale}');
  debugPrint('👀Intl.systemLocale: ${Intl.systemLocale}');
  debugPrint('👀Intl.getCurrentLocale(): ${Intl.getCurrentLocale()}');

  if (context != null) {
    final locale = Localizations.localeOf(context);
    debugPrint('👀Locale: $locale');
    debugPrint('👀Locale.countryCode: ${locale.countryCode}');
    debugPrint('👀Locale.languageCode: ${locale.languageCode}');
  }
}

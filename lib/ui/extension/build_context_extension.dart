import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../data/enum/language.dart';
import '../../l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;
  bool isCurrentLocale(Language language) =>
      PlatformDispatcher.instance.locale.languageCode == language.code;
}

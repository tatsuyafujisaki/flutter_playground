import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_playground/enum/language.dart';

extension L10nExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  Locale get locale => Localizations.localeOf(this);
  bool isCurrentLocale(Language language) =>
      Localizations.localeOf(this).languageCode == language.code;
  bool get isJapanese => Localizations.localeOf(this).languageCode == 'ja';
}

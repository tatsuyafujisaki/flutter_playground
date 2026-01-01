# How to create `.gitignore`

1. Follow the instructions in
   https://github.com/tatsuyafujisaki/dotfiles/blob/main/git/README.md.
2. Add the lines below to `.gitignore`.

```gitignore
#
# Not from https://github.com/github/gitignore
#

ios/Runner/GoogleService-Info.plist
lib/firebase_options.dart

# > don't include most of the files that your IDE or code editor, the pub tool, and other tools generate.
# > In many source code repositories, the common practice is not to commit generated files, at all.
# https://dart.dev/tools/pub/private-files
*.freezed.dart
*.g.dart

# https://docs.flutter.dev/ui/internationalization
lib/l10n/app_localizations.dart
# e.g. app_localizations_en.dart and app_localizations_ja.dart
lib/l10n/app_localizations_*.dart
lib/l10n/untranslated.txt

# https://fvm.app
.fvm/
.fvmrc
```

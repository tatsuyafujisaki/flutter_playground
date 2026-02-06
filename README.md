# How to create `.gitignore`

1. Follow the instructions in
   https://github.com/tatsuyafujisaki/dotfiles/blob/main/git/README.md.
2. Add the lines below to `.gitignore`.

```gitignore
#
# Not from https://github.com/github/gitignore
#

ios/Runner/GoogleService-Info.plist

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

# API keys
dart_defines.json
lib/firebase_options*.dart

# API keys (in case you want to build the app using Xcode, which does not recognize dart_defines.json.)
ios/Flutter/Secrets.xcconfig
```

# How to use API keys

1. Create `ios/Flutter/Secrets.xcconfig`, but do not commit it.
1. Enter API keys in `ios/Flutter/Secrets.xcconfig`.
   ```
   API1=KEK1
   API2=KEY2
   ```
1. Add the following to `ios/Flutter/{Debug, Profile, Release}.config`,
   respectively.
   ```
   #include "Secrets.xcconfig"
   ```

# Preparation

## Update AGENTS.md

Download the Flutter and Dart rules template for your editor from
https://docs.flutter.dev/ai/ai-rules.

## Create `.gitignore`

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

# Firebase
lib/firebase_options*.dart

# API keys
dart_defines.json
```

# How to distribute an iOS app

```shell
rm -r build/ios # ensures *.ipa matches only the newly built file

fvm flutter build ipa --export-method ad-hoc

# https://firebase.google.com/docs/app-distribution/ios/distribute-cli
firebase appdistribution:distribute \
  build/ios/ipa/*.ipa \
  --app <FIREBASE_APP_ID> \
  --release-notes-file release-notes.txt \
  --groups 'group1,group2'
```

# How to distribute an Android app

```shell
rm -r build/app

fvm flutter build apk # --release is the default, so no need to specify it.

# https://firebase.google.com/docs/app-distribution/android/distribute-cli
firebase appdistribution:distribute \
  build/app/outputs/flutter-apk/app-release.apk \
  --app <FIREBASE_APP_ID> \
  --release-notes-file release-notes.txt \
  --groups 'group1,group2'
```

# How to create `.gitignore`

```shell
rm -f .gitignore

for type in Android Dart Firebase Flutter Gradle Kotlin Swift
do
  {
    echo "#"
    echo "# https://github.com/github/gitignore/blob/main/$type.gitignore"
    echo "#"
    echo ""
    curl --location --silent "https://raw.githubusercontent.com/github/gitignore/main/$type.gitignore"
    echo ""
  } >> .gitignore
done

cat >> .gitignore << 'EOF'

# https://developer.android.com/studio/publish/app-signing
# keystore.properties

# google-services.json is already included in https://raw.githubusercontent.com/github/gitignore/refs/heads/main/Android.gitignore but GoogleService-Info.plist is not.
# GoogleService-Info.plist

# Excludes the service credentials file used for Firebase App Distribution.
# *.json

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

EOF
```

Files that are required for a Flutter project to use Firebase

- android/app/google-services.json
- ios/Runner/GoogleService-Info.plist
- lib/firebase_options.dart
- (optional) firebase.json

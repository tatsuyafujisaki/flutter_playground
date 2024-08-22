# Hot reload verus Hot restart versus Full restart
&nbsp;|Hot reload|Hot restart|Full restart
--|--|--|--
Skip `main()` or `initState()`, and preserve the app state?|Yes|No|No
Skip recompiling the Kotlin or Swift code?|Yes|Yes|No

https://docs.flutter.dev/tools/hot-reload#how-to-perform-a-hot-reload

# Bottom sheet
[bottom_sheet.md](markdown/bottom_sheet.md)

# SharedPreferences
[shared_preferences.md](markdown/shared_preferences.md)

# Packages
[packages](markdown/packages)

# How to show a dialog when opening a screen
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  Future.delayed(
    Duration.zero,
    () => showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Text('Hello!'),
      ),
    ),
  );

  return Scaffold(...);
```

# Model-View-ViewModel (MVVM)
[mvvm.md](markdown/mvvm.md)

# Best practices
[best_practices.md](markdown/best_practices.md)

# Troubleshooting
[toubleshooting.md](markdown/troubleshooting.md)
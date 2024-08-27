# Hot reload verus Hot restart versus Full restart
&nbsp;|Hot reload|Hot restart|Full restart
--|--|--|--
Skip `main()` or `initState()`, and preserve the app state?|Yes|No|No
Skip recompiling the Kotlin or Swift code?|Yes|Yes|No

https://docs.flutter.dev/tools/hot-reload#how-to-perform-a-hot-reload

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

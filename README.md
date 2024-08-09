# Hot reload verus Hot restart versus Full restart
&nbsp;|Hot reload|Hot restart|Full restart
--|--|--|--
Skip `main()` or `initState()`, and preserve the app state?|Yes|No|No
Skip recompiling the Kotlin or Swift code?|Yes|Yes|No

https://docs.flutter.dev/tools/hot-reload#how-to-perform-a-hot-reload

# SharedPreferences
[shared_preferences.md](markdown/shared_preferences.md)

# Riverpod
[riverpod.md](markdown/riverpod.md)

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

# How to set the height of [showModalBottomSheet](https://api.flutter.dev/flutter/material/showModalBottomSheet.html)
1. If you want the bottom sheet to occupy almost half of the screen height, no special setting is required.
2. If you want the bottom sheet to occupy the screen height except for the status bar, write as follows.
    ```dart
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => ...,
      // stretches the bottom sheet to full height.
      isScrollControlled: true,
      // from overlapping the status bar.
      useSafeArea: true,
    ),
    ```
3. If you want the bottom sheet to occupy a certain percentage of the screen height, write as follows.
    ```dart
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.8, // 80% of the screen height
        child: ...,
      ),
      // stretches the bottom sheet to full height.
      isScrollControlled: true,
      // avoids the bottom sheet of full height
      // from overlapping the status bar.
      useSafeArea: true,
    )
    ```

## Official reference's recommendations
### "Whenever possible, prefer using ref.watch over ref.read or ref.listen to implement a feature."
https://docs-v2.riverpod.dev/docs/concepts/reading#using-ref-to-interact-with-providers

### "Prefer using NotifierProvider instead."
https://docs-v2.riverpod.dev/docs/providers/state_notifier_provider

### Relationship between `ref.listen()` and `ref.watch()`
https://youtu.be/BJtQ0dfI-RA?t=4302

## Google's recommendations
### "Choosing between text and elevated buttons"
https://codelabs.developers.google.com/codelabs/mdc-101-flutter#4

# Best practices
[best_practices.md](markdown/best_practices.md)

# Troubleshooting
[toubleshooting.md](markdown/troubleshooting.md)


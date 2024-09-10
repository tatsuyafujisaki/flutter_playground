# How to invoke an `async` function in a non-`async` function
## Option 1
Use [WidgetsBinding.instance.addPostFrameCallback](https://api.flutter.dev/flutter/scheduler/SchedulerBinding/addPostFrameCallback.html).
```dart
WidgetsBinding.instance.addPostFrameCallback(
  (_) async => myAsyncFunction(),
);
```

## Option 2
Use [Future.delayed](https://api.dart.dev/stable/dart-async/Future/Future.delayed.html).
```dart
Future.delayed(
  Duration.zero,
  () async => myAsyncFunction(),
);
```

# How to create [Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html) from [Future](https://api.dart.dev/stable/dart-async/Future-class.html) or [Stream](https://api.flutter.dev/flutter/dart-async/Stream-class.html)
- Use [FutureBuilder](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html).
- Use [StreamBuilder](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html)

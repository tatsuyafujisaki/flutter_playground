# How to invoke an `async` function in a non-`async` function
## Option 1
Use [WidgetsBinding.instance.addPostFrameCallback](https://api.flutter.dev/flutter/scheduler/SchedulerBinding/addPostFrameCallback.html).
```dart
WidgetsBinding.instance.addPostFrameCallback(
  (_) async =>  myAsyncFunction(),
);
```

## Option 2
Use [Future.delayed](https://api.dart.dev/stable/dart-async/Future/Future.delayed.html).
```dart
Future.delayed(
  Duration.zero,
  () async => await myAsyncFunction(),
);
```

# How to use [Future](https://api.dart.dev/stable/dart-async/Future-class.html) in a non-`async` function
Use [FutureBuilder](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html).
```dart
FutureBuilder<T>(
  future: myFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      debugPrint(snapshot.error.toString());
      debugPrintStack(stackTrace: snapshot.stackTrace);
      return const FlutterLogo();
    }
    if (snapshot.hasData) {
      return Image.memory(snapshot.data!);
    }
    return const SizedBox.shrink();
  },
)
```

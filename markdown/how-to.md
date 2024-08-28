# How do I use `await` inside `setState()` in a [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)?
You can't. The workaround is to call `setState()` after calling your async function, as shown below.

```dart
class MyStatefulWidgetState extends State<MyStatefulsWidget> {
  final _myState = MyState();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await _myState.myAsyncFunction();
        setState(() {});
      },
    );
  }

  // ...
}
```

# try-catch template
```dart
try {
  // ...
} on Exception catch (e, s) {
  debugPrint(e.toString());
  debugPrintStack(stackTrace: s);
}
```

# [material library (material.dart)](https://api.flutter.dev/flutter/material/material-library.html)
> Choosing between text and elevated buttons

https://codelabs.developers.google.com/codelabs/mdc-101-flutter#4

> To create a divider between ListTile items, consider using ListTile.divideTiles, which is optimized for this case.

https://api.flutter.dev/flutter/material/Divider-class.html

Don't use the title property of the MaterialApp class because it is meaningless not only on iOS, but also on Android 10 or later

https://stackoverflow.com/questions/78871904/flutter-is-the-title-property-of-the-materialapps-class-not-used-on-android-10

# [widgets library (widgets.dart)](https://api.flutter.dev/flutter/widgets/widgets-library.html)
- https://docs.flutter.dev/ui/navigation
  - > We don’t recommend using named routes for most applications.
  - > Flutter also doesn’t support the browser forward button for applications using named routes. For these reasons, we don’t recommend using named routes in most applications.

- > When you have a list of children and do not require cross-axis shrink-wrapping behavior, for example a scrolling list that is always the width of the screen, consider ListView, which is vastly more efficient than a SingleChildScrollView containing a ListBody or Column with many children.
  - https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html
- > You could consider ListView as an optimisation to the combination of SingleChildScrollView + Column.
  - https://stackoverflow.com/a/62147092
- > The SafeArea widget can be used within the scaffold's body to avoid areas like display notches.
  - https://api.flutter.dev/flutter/material/Scaffold-class.html
  - https://youtu.be/lkF0TQJO0bA?t=35

## Navigation
> Named routes are no longer recommended for most applications

https://docs.flutter.dev/cookbook/navigation/named-routes

> Named routes are no longer recommended for most applications.

https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments

# Package
## [firebase_messaging](https://pub.dev/packages/firebase_messaging)
> You shouldn't request a token during app startup,

https://firebase.google.com/codelabs/firebase-fcm-flutter#3

## [go_router](https://pub.dev/packages/go_router)
Use the syntactic sugar of [GoRouterHelper](https://pub.dev/documentation/go_router/latest/go_router/GoRouterHelper.html) instead of `GoRouter.of`.

For example ...
> `context.go('/users/123')` is shorthand for calling calling `GoRouter.of(context).go('/users/123)`.

https://pub.dev/documentation/go_router/latest/topics/Navigation-topic.html

## [riverpod](https://pub.dev/packages/riverpod)
> Whenever possible, prefer using `ref.watch` over `ref.read` or `ref.listen` to implement a feature.

https://docs-v2.riverpod.dev/docs/concepts/reading#using-ref-to-interact-with-providers

> Prefer using NotifierProvider instead.

https://docs-v2.riverpod.dev/docs/providers/state_notifier_provider

> Relationship between `ref.listen()` and `ref.watch()`

https://youtu.be/BJtQ0dfI-RA?t=4302

# Use A rather than B for simplicity or better UIUX
A|B|Note
--|--|--
[TimeOfDay.now](https://api.flutter.dev/flutter/material/TimeOfDay/TimeOfDay.now.html)|[DateTime.now](https://api.dart.dev/stable/3.5.1/dart-core/DateTime/DateTime.now.html)|if what you want is only hours and minutes.
[InputBorder.none](https://api.flutter.dev/flutter/material/InputBorder/none-constant.html)|[BorderSide.none](https://api.flutter.dev/flutter/painting/BorderSide/none-constant.html)|Only if your TextField is not rounded.
[BorderSide.none](https://api.flutter.dev/flutter/painting/BorderSide/none-constant.html)|[BorderSide(width: 0, style: BorderStyle.none)](https://api.flutter.dev/flutter/painting/BorderStyle.html)|> none constant<br>> Implementation<br>> static const BorderSide none = BorderSide(width: 0.0, style: BorderStyle.none);
[InkWell](https://api.flutter.dev/flutter/material/InkWell-class.html)|[GestureDetector](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html)
[context.go](https://pub.dev/documentation/go_router/latest/go_router/GoRouterHelper/go.html)|[GoRouter.of(context).go](https://pub.dev/documentation/go_router/latest/go_router/GoRouter/go.html)
[context.watch\<T>(...)](https://pub.dev/documentation/provider/latest/provider/WatchContext/watch.html)|[Consumer](https://pub.dev/documentation/provider/latest/provider/Consumer-class.html)|https://stackoverflow.com/a/77087227

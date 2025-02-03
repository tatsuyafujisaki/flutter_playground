# Terminology
> Terminology<br>
> In Flutter, screens and pages are called routes. The remainder of this recipe refers to routes.

https://docs.flutter.dev/cookbook/navigation/navigation-basics

# Differences among hot reload, hot restart, and full restart
&nbsp;|Hot reload|Hot restart|Full restart
--|--|--|--
Skip `main()` or `initState()`, and preserve the app state?|Yes|No|No
Skip recompiling the Kotlin or Swift code?|Yes|Yes|No

https://docs.flutter.dev/tools/hot-reload#how-to-perform-a-hot-reload

# Differences between `flutter clean` and `flutter pub cache clean`
## `flutter clean`
> Delete the build/ and .dart_tool/ directories.

https://docs.flutter.dev/reference/flutter-cli#:~:text=Delete%20the%20build/%20and%20.dart_tool/%20directories.

## `flutter pub cache clean`
> You can empty the entire system cache to reclaim extra disk space or remove problematic packages:

https://dart.dev/tools/pub/cmd/pub-cache#:~:text=You%20can%20empty%20the%20entire%20system%20cache%20to%20reclaim%20extra%20disk%20space%20or%20remove%20problematic%20packages:

# widgets library (widget.dart)
## [Container](https://api.flutter.dev/flutter/widgets/Container-class.html) class
> Containers with no children try to be as big as possible unless the incoming constraints are unbounded, in which case they try to be as small as possible. Containers with children size themselves to their children. The width, height, and constraints arguments to the constructor override this.

https://api.flutter.dev/flutter/widgets/Container-class.html

# Firebase Cloud Messaging (FCM)
## Foreground messages
> Notification messages which arrive while the application is in the foreground will not display a visible notification by default

https://firebase.google.com/docs/cloud-messaging/flutter/receive#foreground_and_notification_messages

## Background messages
> There are a few things to keep in mind about your background message handler:

1. > It must not be an anonymous function.
2. > It must be a top-level function (e.g. not a class method which requires initialization).
3. > When using Flutter version 3.3.0 or higher, the message handler must be annotated with @pragma('vm:entry-point') right above the function declaration (otherwise it may be removed during tree shaking for release mode).

https://firebase.google.com/docs/cloud-messaging/flutter/receive#apple_platforms_and_android

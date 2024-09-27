# Terminology
> Terminology<br>
> In Flutter, screens and pages are called routes. The remainder of this recipe refers to routes.

https://docs.flutter.dev/cookbook/navigation/navigation-basics

# Hot reload / Hot restart / Full restart
&nbsp;|Hot reload|Hot restart|Full restart
--|--|--|--
Skip `main()` or `initState()`, and preserve the app state?|Yes|No|No
Skip recompiling the Kotlin or Swift code?|Yes|Yes|No

https://docs.flutter.dev/tools/hot-reload#how-to-perform-a-hot-reload

# widgets library (widget.dart)
## [Container](https://api.flutter.dev/flutter/widgets/Container-class.html) class
> Containers with no children try to be as big as possible unless the incoming constraints are unbounded, in which case they try to be as small as possible. Containers with children size themselves to their children. The width, height, and constraints arguments to the constructor override this.

https://api.flutter.dev/flutter/widgets/Container-class.html

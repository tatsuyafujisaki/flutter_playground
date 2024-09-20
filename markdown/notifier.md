# When to use which: [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html), [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html), or [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)?
1. Do you want to have a state in a plain class or in a [Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html)?
2. If you want to have a state in a plain class:
    1. If your state is a single value in a plain class, use `ValueNotifier`.
    2. If your state is a set of values, use `ChangeNotifier`.
3. If you want to have a state in a `Widget`, use `StatefulWidget`

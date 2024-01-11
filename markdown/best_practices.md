- https://docs.flutter.dev/ui/navigation
  - > We don’t recommend using named routes for most applications.
  - > Flutter also doesn’t support the browser forward button for applications using named routes. For these reasons, we don’t recommend using named routes in most applications.

- Use [ListView](https://api.flutter.dev/flutter/widgets/ListView-class.html) rather than [SingleChildScrollView](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html) + [Column](https://api.flutter.dev/flutter/widgets/Column-class.html).
  - https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html
    - > When you have a list of children and do not require cross-axis shrink-wrapping behavior, for example a scrolling list that is always the width of the screen, consider ListView, which is vastly more efficient than a SingleChildScrollView containing a ListBody or Column with many children.
  - https://stackoverflow.com/a/62147092
    - > You could consider ListView as an optimisation to the combination of SingleChildScrollView + Column.

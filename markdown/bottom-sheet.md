# How to set the height of [showModalBottomSheet](https://api.flutter.dev/flutter/material/showModalBottomSheet.html)
1. If you want to stretch the bottom sheet to almost half the top of the screen except, no special setting is required.
1. If you want to stretch the bottom sheet to the top of the screen except for the status bar, write the following
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
1. If you want to stretch the bottom sheet to a certain percentage of the screen height, write the following.
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

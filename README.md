# Riverpod
## `WigetRef.watch()` does not react to the update of an item in a collection.
When the state of the `StateProvider` is a collection, `WigetRef.watch()` reacts to the update of the collection, but does not react to the update of an item in a collection.

<details>
<summary>Example</summary>

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myStateProvider = StateProvider.autoDispose((_) => <String>{'Hello!'});

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greets = ref.watch(myStateProvider);

    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          ref
              .read(myStateProvider.notifier)
              .update((state) => {...state, 'Bye!'});
          // `WigetRef.watch()` does not react to the following.
          // .update((state) {
          //    state.add('Bye!');
          //    return state;
          //  })
        },
        child: Text(greets.toString()),
      ),
    );
  }
}
```
</details>

# Troubleshooting
## flutter doctor
Q. How to troubleshoot `Unable to find bundled Java version.` about Android Studio.
```
[!] Android Studio
    ✗ Unable to find bundled Java version.
```

A. Run the following in Terminal
```shell
cd /Applications/Android Studio.app/Contents
ln -s jbr jre
```

## Trying to run an app in iOS, `Error: DT_TOOLCHAIN_DIR cannot be used to evaluate LIBRARY_SEARCH_PATHS, use TOOLCHAIN_DIR instead` appears.
Upgrade Cocoapods to 1.13.0 or later.

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

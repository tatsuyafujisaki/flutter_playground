# flutter doctor
## `flutter doctor` shows `Unable to find bundled Java version.` about Android Studio as follows.
```
[!] Android Studio
    ✗ Unable to find bundled Java version.
```

### Solution
Run the following in Terminal.
```shell
cd '/Applications/Android Studio.app/Contents'
sudo ln -s jbr jre
```

#### What is JBR?

> The JetBrains Runtime (JBR)  is an enhanced JDK

https://developer.android.com/build/jdks#jdk-android-studio

> jbr directory (JetBrains Runtime), in the Android Studio distribution. Recommended.

https://developer.android.com/build/jdks#jdk-android-studio

# iOS
## Building an iOS app shows `Error: DT_TOOLCHAIN_DIR cannot be used to evaluate LIBRARY_SEARCH_PATHS, use TOOLCHAIN_DIR instead`.
### Solution
1. Upgrade CocoaPods to 1.13.0 or later.
2. Run the following.
   ```shell
   cd <your-flutter-projector-folder>/ios
   pod install
   cd ..
   flutter run
   ```

## Building an iOS app shows `Xcode build failed due to concurrent builds, will retry in 2 seconds.`
### Solution
Stop `XCBbuildService` using Activity Monitor.

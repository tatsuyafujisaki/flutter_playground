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

## What if `pod install` shows the following warning.
```
[!] CocoaPods did not set the base configuration of your project because your project already has a custom config set. In order for CocoaPods integration to work at all, please either set the base configurations of the target `Runner` to `Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig` or include the `Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig` in your build configuration (`Flutter/Release.xcconfig`).
```
### Solution
1. Open the workspace.
    ```shell
    ios/Runner.xcworkspace
    ```
2. Select `Runner` in the leftmost column (`Navigators` > `Project`)
3. Select `Runner` in `PROJECT` in the second leftmost column.
3. Select the `Info` tab.
4. Select the following in `Conigurations`.
    - `Debug` > `Runner` > `Pods-Runner.debug`
    - `Release` > `Runner` > `Pods-Runner.release`
    - `Profile` > `Runner` > `Pods-Runner.profile`
    - `Debug`/`Release`/`Profile` > `Runner` > (nested inner) `Runner` > `None`
    - `Debug`/`Release`/`Profile` > `Runner` > `RunnerTests` > `None`

## What if building an iOS app shows `Error: DT_TOOLCHAIN_DIR cannot be used to evaluate LIBRARY_SEARCH_PATHS, use TOOLCHAIN_DIR instead`.
### Solution
1. Upgrade CocoaPods to 1.13.0 or later.
2. Run the following.
   ```shell
   cd <your-flutter-projector-folder>/ios
   pod install
   cd ..
   flutter run
   ```

## What if building an iOS app shows `Xcode build failed due to concurrent builds, will retry in 2 seconds.`
### Solution
Stop `XCBbuildService` using Activity Monitor.

## iOS troubleshooting not specific to Flutter
https://github.com/tatsuyafujisaki/xcode-playground/blob/main/README.md

## How to find your Flutter app's default minSdk

```shell
grep --line-number minSdk .fvm/flutter_sdk/packages/flutter_tools/gradle/src/main/kotlin/FlutterExtension.kt
```

## How to find your Flutter app's actual minSdk

```shell
grep --line-number minSdk build/app/intermediates/merged_manifests/devDebug/processDevDebugManifest/AndroidManifest.xml
```

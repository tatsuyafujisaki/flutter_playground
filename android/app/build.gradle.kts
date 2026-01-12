plugins {
    id("com.android.application")
    id("dev.flutter.flutter-gradle-plugin")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
}

android {
    namespace = "com.example.flutterplayground"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion
    // https://developer.android.com/build/jdks#toolchain
    // https://kotlinlang.org/docs/gradle-configure-project.html#gradle-java-toolchains-support
    java.toolchain.languageVersion = JavaLanguageVersion.of(21)

    compileOptions {
        // Required by the flutter_local_notifications package
        // https://pub.dev/packages/flutter_local_notifications#gradle-setup
        isCoreLibraryDesugaringEnabled = true
    }

    defaultConfig {
        applicationId = "com.example.flutterplayground"
        minSdk = 26
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // Read Google Maps API key from environment variable
        val googleMapsApiKey = System.getenv("GOOGLE_MAPS_PLATFORM_API_KEY") ?: ""
        manifestPlaceholders["GOOGLE_MAPS_PLATFORM_API_KEY"] = googleMapsApiKey
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Required by the flutter_local_notifications package
    // https://pub.dev/packages/flutter_local_notifications#gradle-setup
    // https://maven.google.com/web/index.html?q=com.android.tools#com.android.tools:desugar_jdk_libs
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}

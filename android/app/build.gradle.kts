import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("dev.flutter.flutter-gradle-plugin")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.tatsuyafujisaki.flutterplayground"
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
        applicationId = "com.tatsuyafujisaki.flutterplayground"
        minSdk = 26
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // Read Google Maps API key from environment variable
        val googleMapsApiKey = System.getenv("GOOGLE_MAPS_PLATFORM_API_KEY") ?: ""
        manifestPlaceholders["GOOGLE_MAPS_PLATFORM_API_KEY"] = googleMapsApiKey
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
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

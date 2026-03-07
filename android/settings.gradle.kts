pluginManagement {
    val flutterSdkPath: String by settings.extra {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }

    plugins {
        id("dev.flutter.flutter-gradle-plugin") version "1.0.0" apply false
    }
}

plugins {
    id("com.android.application") version "9.0.0" apply false
    id("com.google.firebase.crashlytics") version "3.0.6" apply false
    id("com.google.gms.google-services") version "4.4.4" apply false
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("org.gradle.toolchains.foojay-resolver-convention") version "1.0.0"
    id("org.jetbrains.kotlin.android") version "2.3.10" apply false
}

include(":app")

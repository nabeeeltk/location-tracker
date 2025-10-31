pluginManagement {
    val flutterSdkPath =
        run {
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

        // ✅ Add Transistorsoft Maven repository (needed for background_fetch)
        maven { url = uri("https://maven.transistorsoft.com") }
    }
}

plugins {
    // ✅ Flutter plugin loader (required)
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"

    // ✅ Android and Kotlin Gradle plugin versions
    id("com.android.application") version "8.9.1" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false

    // ✅ Do NOT specify google-services version here, it’s applied automatically by FlutterFire
    // (Removed com.google.gms.google-services version line)
}

include(":app")

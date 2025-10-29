plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // ✅ updated plugin ID for Kotlin
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // ✅ required for Firebase
}

android {
    namespace = "com.example.location_tracker"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.location_tracker"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    // ✅ Firebase BoM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:34.4.0"))

    // ✅ Firebase Analytics
    implementation("com.google.firebase:firebase-analytics")

    // ✅ Add more Firebase SDKs as needed:
    // implementation("com.google.firebase:firebase-auth")
    // implementation("com.google.firebase:firebase-firestore")
}

flutter {
    source = "../.."
}

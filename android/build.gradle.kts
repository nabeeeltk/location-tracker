// Top-level build file

plugins {
    id("dev.flutter.flutter-gradle-plugin") apply false
}

buildscript {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://transistorsoft.bintray.com/maven") } // ← add this line
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.5.0")
        classpath("com.google.gms:google-services:4.4.2") // ✅ Added Google Services plugin classpath
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://transistorsoft.bintray.com/maven") } // ← add this line
    }
}

// build dir override (optional)
val newBuildDir: Directory = rootProject.layout.buildDirectory
    .dir("../../build")
    .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

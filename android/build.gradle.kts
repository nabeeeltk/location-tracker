plugins {
    // Flutter and Android Gradle plugin get applied automatically via Flutter’s tooling
    // ✅ Add Google Services plugin here, but do NOT apply globally
    id("com.google.gms.google-services") version "4.4.4" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ This custom build directory configuration is fine
val newBuildDir: Directory = rootProject.layout.buildDirectory
    .dir("../../build")
    .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// ✅ Clean task (standard)
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

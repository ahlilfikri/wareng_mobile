allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

android {
    // Use '=' for assignment in Kotlin DSL
    compileSdkVersion = 33

    defaultConfig {
        // Use parentheses for function calls like buildConfigField
        buildConfigField("boolean", "ENABLE_CUSTOM_CONFIG", "true")
    }

    buildFeatures {
        // Use '=' for assignment in Kotlin DSL
        buildConfig = true
    }
}
plugins {
    id("com.android.application")
    kotlin("android") // Often needed for Kotlin Android projects
}

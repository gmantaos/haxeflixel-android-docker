![](https://raw.githubusercontent.com/gmantaos/haxeflixel-android-docker/master/logo.png)

[![](https://img.shields.io/docker/pulls/gmantaos/haxeflixel-android.svg)](https://hub.docker.com/r/gmantaos/haxeflixel-android)
[![](https://images.microbadger.com/badges/image/gmantaos/haxeflixel-android.svg)](https://hub.docker.com/r/gmantaos/haxeflixel-android)
[![](https://images.microbadger.com/badges/version/gmantaos/haxeflixel-android.svg)](https://hub.docker.com/r/gmantaos/haxeflixel-android)
==========

Tags are versioned after the included [flixel](https://lib.haxe.org/p/flixel/) version.
The rest of the libs present like [Lime](https://lib.haxe.org/p/lime/) and [OpenFL](https://lib.haxe.org/p/openfl/), are generally at their latest available versions that work with HaxeFlixel at the time of building.

## Includes

- Full [HaxeFlixel build environment](https://github.com/gmantaos/haxeflixel-docker).
- Java JDK 8
- Android SDK
- Android Support Libraries
- Android NDK

## Usage

The image is generally meant to be used as a build environment, such as for CI builds.

```bash
$ docker pull gmantaos/haxeflixel-android:4.6
```

The correct SDK version must be set in `Project.xml`.

```xml
<project>

    ...

    <android target-sdk-version="25" />

</project>
```

Lime is already configured with the correct paths, so building for android should work right away.

```bash
$ lime build android
```

## Env

| Variable | Description | Value |
| -------- | ----------- | ----- |
| LIME_VERSION | The installed Lime version. | `7.2.1` |
| OPENFL_VERSION | The installed OpenFL version. | `8.8.0` |
| FLIXEL_VERSION | The installed HaxeFlixel version. | `4.6.0` |
| JAVA_HOME | Java JDK installation path. | `/usr/lib/jvm/java-8-openjdk-amd64/` |
| ANDROID_SDK_VERSION | The installed Android SDK version. | `25.2.4` |
| ANDROID_HOME | Android SDK installation path. | `/opt/android-sdk` |
| ANDROID_NDK_VERSION | The installaed Android NDK version. | `r13b` |
| ANDROID_NDK_HOME | Android NDK installation path. | `/opt/android-ndk` |

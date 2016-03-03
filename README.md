# FFTS [![Build Status](https://travis-ci.org/billthefarmer/ffts-android.svg?branch=master)](https://travis-ci.org/billthefarmer/ffts-android)

This is a fork of the [FFST project](https://github.com/anthonix/ffts)
for Android. I was unable to get this to build using the android build
script provided, and rather than waste time and effort investigating
the arcane autoconf/automake build system, moved the folders about so
that it can be built with the Android NDK build script.

The [app](https://github.com/billthefarmer/scope) that I want to use
it for is on [FDroid](https://f-droid.org), so it should be buildable
with the standard Android tools. Apps on this free app store are built
and signed by themselves using their Android based build system.

I have set up Android.mk to build a vfp version as the 'armeabi-v7a'
ABI does not guarantee NEON support. The following code snippet from
the NDK docs
([CPU ARM Neon](http://www.kandroid.org/ndk/docs/CPU-ARM-NEON.html))
shows how to test:

    #include <cpu-features.h>
    ...
    ...
    if (android_getCpuFamily() == ANDROID_CPU_FAMILY_ARM &&
        (android_getCpuFeatures() & ANDROID_CPU_ARM_FEATURE_NEON) != 0)
    {
        // use NEON-optimized routines
        ...
    }
    else
    {
        // use non-NEON fallback routines instead
        ...
    }

However, the code structure is built around the autoconf/automake
premise that you build your library for your proposed use, rather than
build it to cope with different ARM processors. I've got around this
by building two libraries and determining which to load at run
time. This reuires a third library just to check the processor.

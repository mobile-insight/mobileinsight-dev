#!/bin/sh
# Android cross-compile environment setup script
# Author  : Zengwen Yuan
# Date    : 2017-11-15
# Version : 2.2

# All the built binaries, libs and their header will be installed here
export PREFIX=${HOME}/androidcc

# Don't mix up .pc files from your host and build target
export PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig

# GCC for Android version to use
# 4.9 is the only available version since NDK r11!
export GCC_VER=4.9

# The building system we are using (Linux x86_64)
export BUILD_SYS=x86_64-linux-gnu

# Set Android target API level
export ANDROID_API=26

# Set Android target arch
export ANDROID_ARCH=arm

# Set Android target name, according to Table 2 in
# https://developer.android.com/ndk/guides/standalone_toolchain.html
export ANDROID_TARGET=armv7-none-linux-androideabi

# The cross-compile toolchain we use
export TOOLCHAIN=arm-linux-androideabi

# This is a symlink pointing to the real Android NDK r15c
export NDK=${HOME}/android-ndk-r15c

# The path of standalone NDK toolchain
# Refer to https://developer.android.com/ndk/guides/standalone_toolchain.html
export NDK_TOOLCHAIN=${HOME}/android-ndk-toolchain

# Set Android sysroot according to API and arch
export SYSROOT=${NDK_TOOLCHAIN}/sysroot

# Binutils path
export CROSS_PREFIX=${NDK_TOOLCHAIN}/bin/${TOOLCHAIN}

# Non-exhaustive lists of compiler + binutils
export AR=${CROSS_PREFIX}-ar
export AS=${CROSS_PREFIX}-as
export LD=${CROSS_PREFIX}-ld
export NM=${CROSS_PREFIX}-nm
export CC=${CROSS_PREFIX}-gcc
export CXX=${CROSS_PREFIX}-g++
export CPP=${CROSS_PREFIX}-cpp
export CXXCPP=${CROSS_PREFIX}-cpp
export STRIP=${CROSS_PREFIX}-strip
export RANLIB=${CROSS_PREFIX}-ranlib
export STRINGS=${CROSS_PREFIX}-strings

# Set build flags
# Refer to https://developer.android.com/ndk/guides/standalone_toolchain.html
# Put the Android ${PREFIX}/bin before the $PATH to let libgcrypt find the installed libgpg-error
export PATH=${PREFIX}/bin:${PREFIX}/lib:$PATH
export CFLAGS="--sysroot=${SYSROOT} -I${SYSROOT}/usr/include -I${PREFIX}/include -fPIE -DANDROID -Wno-multichar"
export CXXFLAGS=${CFLAGS}
export CPPFLAGS="--sysroot=${SYSROOT} -I${SYSROOT}/usr/include -I${NDK_TOOLCHAIN}/include/c++/ -DANDROID -DNO_XMALLOC -mandroid"
export LIBS="-lc"
export LDFLAGS="-Wl,-rpath-link=-I${SYSROOT}/usr/lib -L${SYSROOT}/usr/lib -L${PREFIX}/lib -L${NDK_TOOLCHAIN}/lib"

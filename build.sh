#!/bin/bash

DEBUG=0
if [[ "$1" == "d" || "$1" == "-d" ]]; then
	DEBUG=1
fi

PROD_FLAGS="-O2 -s"
DEV_FLAGS="-g -ggdb"
CFLAGS="-Wall -Wextra -Wimplicit -Wpedantic -Wno-unused-function -std=c99"

if [ $DEBUG -eq 1 ]; then
	CFLAGS="$CFLAGS $DEV_FLAGS -DDEBUG -D_DEBUG"
	RAYLIB_BUILD_MODE="DEBUG"
	echo "Building in debug mode"
else
	CFLAGS="$CFLAGS $PROD_FLAGS"
	RAYLIB_BUILD_MODE="RELEASE"
	echo "Building in release mode"
fi

LIB_PATHS="-L./libs"
INCLUDES="-I./deps/raylib/src"
RAYLIB_DEP="-l:libraylib.a -lm -lpthread"
DEPS="$INCLUDES $LIB_PATHS $RAYLIB_DEP"

if [ -d "./libs" ]; then
	rm -rf "./libs"
fi
mkdir "./libs"

# Build raylib
cd deps/raylib/src
make PLATFORM=PLATFORM_DESKTOP RAYLIB_LIBTYPE=STATIC RAYLIB_RELEASE_PATH=../../../libs RAYLIB_BUILD_MODE=$RAYLIB_BUILD_MODE >/dev/null 2>&1
cd ../../..

# Build executable
if [ -f "./libs/main" ]; then
	rm -f "./libs/main"
fi

gcc $CFLAGS -o main src/main.c $DEPS
echo "Build complete"
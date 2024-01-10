@echo off

set DEBUG=0
if "%~1"=="d"  set DEBUG=1
if "%~1"=="-d" set DEBUG=1

:: -mwindows : Compile a Windows executable, no cmd window
set PROD_FLAGS=-O2 -mwindows -s
set DEV_FLAGS=-g -ggdb
set CFLAGS=-Wall -Wextra -Wimplicit -Wpedantic -Wno-unused-function -std=c99

if %DEBUG%==1 (
	set CFLAGS=%CFLAGS% %DEV_FLAGS% -DDEBUG -D_DEBUG
	set RAYLIB_BUILD_MODE=DEBUG
	echo Building in debug mode
) else (
	set CFLAGS=%CFLAGS% %PROD_FLAGS%
	set RAYLIB_BUILD_MODE=RELEASE
	echo Building in release mode
)

:: Compiler-Options to include dependencies
set LIB_PATHS=-L./libs
set INCLUDES=-I./deps/raylib/src -I./deps/ail
set RAYLIB_DEP=-l:libraylib.a -lopengl32 -lgdi32 -lwinmm -lpthread
set DEPS=%INCLUDES% %LIB_PATHS% %RAYLIB_DEP%

:: Build raylib
if not exist libs mkdir libs
cd deps/raylib/src
make PLATFORM=PLATFORM_DESKTOP RAYLIB_LIBTYPE=STATIC RAYLIB_RELEASE_PATH=../../../libs RAYLIB_BUILD_MODE=%RAYLIB_BUILD_MODE% > NUL
cd ../../..


:: Build executable
cmd /c if exist main.exe del /F main.exe
gcc %CFLAGS% -o main.exe src/main.c %DEPS%
echo Build complete
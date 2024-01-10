# Raylib Template

My personal template for creating raylib templates.

Only creates desktop applications at the moment.

Raylib's own template with its very long and complicated Makefile was too cumbersome for me.
Instead, this template provides you simply two shell scripts for building the project. These are easy to understand and edit.

The general way they work is by statically building raylib into a folder named `libs/` and linking the project against that static library.

By default the scripts build a release version. On windows this also includes having no terminal anymore.
To build in debug mode, with debg symbols and the `DEBUG` and `_DEBUG` symbols being defined, run `./build.sh -d` or `build.bat -d`.

This template uses `gcc` to compile the C-files. It also requires `make`, to call raylib's Makefile for building its static library.
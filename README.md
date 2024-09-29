
NOTE:
* Static or global data of any kind is not yet supported. For this Zig needs the ability to compile arm/thumb targets with relocatable code (supporting a global offset table.). This project is current the use case for adding that functionality to Zig.



* TODO test non-data sections
* TODO passing in a bytearray
* TODO passing in an array32
* TODO passing back a bytearray
* TODO passing back an array32
* TODO passing back debug strings / printing things?
* TODO support data sections with elf modifications and including an init3egsafvweds method.

![MicroPython](https://avatars1.githubusercontent.com/u/6298560?s=280)+![Zig](https://ziglang.org/zero.svg)

This is a template project for building MicroPython Native (.mpy) modules written in Zig.

# Guide

* Ensure you have the following requirements:
  * Zig 0.13.0
  * CPython3
  * GNU make
  * A C compiler for the target architecture (e.g: arm-none-eabi-newlib)
* Setup dependencies:
```
git submodule update --init
pip install mpremote pyelftools
```
* Connect your device via USB.
* Then build and run:
```
make V=1
uploadrun
```

# Tests

Run the test suite with:
```
zig build test
```

# Notes

* See https://docs.micropython.org/en/latest/develop/natmod.html#supported-features-and-limitations for notes on limitations.
* Micropython is loaded via a git submodule at version 1.23.0. You may want to update this.
* The architecture is set to build for an rp2350, and was tested on a Thumby Color Dev Kit. This can be changed in build.zig and Makefile.


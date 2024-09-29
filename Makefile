
build: all
CLEAN_EXTRA = root.mpy

# Location of top-level MicroPython directory
MPY_DIR = micropython

# Name of module
MOD = root

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# This should be changed to your target architecture.
# It is currently set for the rp2350.
# Architecture to build for (x86, x64, armv6m, armv7m, xtensa, xtensawin)
# NOTE: you will also have change build.zig to switch targets.
ARCH = armv7emsp

# Source files
SRC = src/bridge.c

# Zig output linking.
CFLAGS += -Isrc
SRC_O += build/lib/root.o

# Compile the zig component
build/lib/root.o: src/root.zig build.zig
	zig build --prefix build --cache-dir build/zig-cache

# Include to get the rules for compiling and linking the module
include $(MPY_DIR)/py/dynruntime.mk

#!/bin/bash
qemu-system-i386 -drive format=raw,file=plan8.iso -m 256 -vga std -name plan8 -sdl -gdb tcp:127.0.0.1:1234 -S &
disown
gdb kernel/build/bootimg

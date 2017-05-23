# Makefile for OS project
# To build, first `make dep`, them `make`. Everything should be automatic.
# Will compile all *.c and *.S files in the current directory.

INCDIR := ../include
SRCDIR := ../kernel

VPATH := $(INCDIR) $(SRCDIR)

# Flags to use when compiling, preprocessing, assembling, and linking
CFLAGS+=-Wall -fno-builtin -fno-stack-protector -nostdlib
ASFLAGS+=
LDFLAGS+=-nostdlib -static
CC=i686-elf-gcc

#If you have any .h files in another directory, add -I<dir> to this line
CPPFLAGS+=-nostdinc -g -I$(INCDIR)

# This generates the list of source files
SRC=$(wildcard $(SRCDIR)/*.S) $(wildcard $(SRCDIR)/*.c)

# This generates the list of .o files. The order matters, boot.o must be first
OBJS=boot.o
OBJS+=$(filter-out boot.o,$(patsubst $(SRCDIR)/%.S,%.o,$(filter %.S,$(SRC))))
OBJS+=$(patsubst $(SRCDIR)/%.c,%.o,$(filter %.c,$(SRC)))

bootimg: Makefile $(OBJS)
	rm -f bootimg
	$(CC) $(LDFLAGS) $(OBJS) -Ttext=0x400000 -o bootimg

print-%:
	@echo '$*=$($*)'

dep: Makefile.dep

Makefile.dep: $(SRC)
	$(CC) -MM $(CPPFLAGS) $(SRC) > $@

.PHONY: clean
clean:
	rm -f *.o Makefile.dep

ifneq ($(MAKECMDGOALS),dep)
ifneq ($(MAKECMDGOALS),clean)
include Makefile.dep
endif
endif

CFLAGS += -Wall -nostdlib -ffreestanding
LDFLAGS += -nostdlib -ffreestanding
CC = i686-elf-gcc

all: cat.exe grep.exe hello.exe ls.exe pingpong.exe counter.exe shell.exe sigtest.exe testprint.exe syserr.exe loadkeys.exe

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.S
	$(CC) $(CFLAGS) -c -Wall -o $@ $<

%.x: %.o syscall.o support.o
	$(CC) $(LDFLAGS) -o $@ $^

%.exe: %.x
	../elfconvert $< &> /dev/null
	mv $<.converted ../fsdir/$@

clean:
	rm -f *.o

clear: clean
	rm -f *.converted
	rm -f *.exe

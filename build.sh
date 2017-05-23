cd kernel/build
make
cd ../../
cp kernel/build/bootimg iso/boot
grub2-mkrescue -o plan8.iso iso

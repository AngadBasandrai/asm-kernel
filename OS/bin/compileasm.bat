@ECHO off

nasm ../src/asm/bootloader.asm -f bin -o bootloader.bin
nasm ../src/asm/kernel.asm -f bin -o kernel.bin
nasm ../src/asm/fileTable.asm -f bin -o fileTable.bin

cat bootloader.bin kernel.bin fileTable.bin > temp.bin

dd if=/dev/zero of=OS.bin bs=512 count=2800

dd if=temp.bin of=OS.bin conv=notrunc

echo "FLP file created successfully"

start bochsrc.bxrc

echo "Started your OS in BOCHS"

pause
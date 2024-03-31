all: mare 
	qemu-system-i386 -drive format=raw,file=mare 
mare:
	nasm mare.nasm -o mare
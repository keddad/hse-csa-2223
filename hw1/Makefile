main: main.c
	gcc -O2 -o main main.c

main_asm.o: main.asm
	nasm -f elf64 main.asm -o main_asm.o

main_asm: main_asm.o
	ld main_asm.o -o main_asm

readable_asm: main.c
	gcc -O0 -fverbose-asm -S main.c -o main_readable.A

optimized_asm: main.c
	gcc -O3 -S main.c -o main_optimized.A

unoptimized_main: main.c
	gcc -O0 -g -o main_unoptimized main.c

objdumped_asm: unoptimized_main
	objdump -S --disassemble main_unoptimized > main_objdumped.A

all: main readable_asm optimized_asm objdumped_asm main_asm
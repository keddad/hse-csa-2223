.PHONY: all

ref.S: ref.c
	gcc -S -O0 -masm=intel -fno-asynchronous-unwind-tables -fcf-protection=none ref.c -o ref.S

ref.o: ref.S
	gcc -c ref.S -o ref.o

ref: ref.o
	gcc ref.o -o ref

ref_commented.o: ref_commented.S
	gcc -c ref_commented.S -o ref_commented.o

ref_commented: ref_commented.o
	gcc ref_commented.o -o ref_commented

all: ref ref_commented
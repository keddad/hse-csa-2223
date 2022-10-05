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

ref_regopt.o: ref_regopt.S
	gcc -c ref_regopt.S -o ref_regopt.o

ref_regopt: ref_regopt.o
	gcc ref_regopt.o -o ref_regopt

manyfiles_a.o: manyfiles_a.S
	gcc -c manyfiles_a.S -o manyfiles_a.o

manyfiles_b.o: manyfiles_b.S
	gcc -c manyfiles_b.S -o manyfiles_b.o

manyfiles: manyfiles_a.o manyfiles_b.o
	gcc manyfiles_a.o manyfiles_b.o -o manyfiles

test: ref ref_commented ref_regopt manyfiles
	python test_asm.py

all: ref ref_commented ref_regopt manyfiles
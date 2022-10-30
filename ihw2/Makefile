.PHONY: all test

ref_speed: ref.c
	gcc -O3 ref.c -o ref_speed

ref_size: ref.c
	gcc -Os ref.c -o ref_size

ref.S: ref.c
	gcc -S -O0 -masm=intel -fno-asynchronous-unwind-tables -fcf-protection=none ref.c -o ref.S

%.o: %.S
	gcc -c $< -o $@

%: %.o
	gcc $< -o $@

manyfiles: manyfiles_a.o manyfiles_b.o
	gcc manyfiles_a.o manyfiles_b.o -o manyfiles

test: ref ref_commented ref_regopt
	python test_asm.py

bench: ref ref_commented ref_regopt
	python bench.py

all: ref ref_commented ref_regopt
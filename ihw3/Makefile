.PHONY: all test

%.o: %.S
	gcc -c -lm $< -o $@

%: %.o
	gcc -lm $< -o $@

%: %.c # Makefiles are weird
%: %.S

ref.S: ref.c
	gcc -S -O0 -masm=intel -lm -fno-asynchronous-unwind-tables -fcf-protection=none ref.c -o ref.S

manyfiles: manyfiles_a.o manyfiles_b.o
	gcc manyfiles_a.o manyfiles_b.o -o manyfiles

all: ref ref_commented ref_regopt manyfiles

test: ref ref_commented ref_regopt manyfiles
	python test_asm.py

bench: ref ref_commented ref_regopt manyfiles
	python bench.py
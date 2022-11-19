	.file	"ref.c"
	.intel_syntax noprefix
	.text
	.globl	SPEEDTEST_N
	.section	.rodata
	.align 4
	.type	SPEEDTEST_N, @object
	.size	SPEEDTEST_N, 4
SPEEDTEST_N:
	.long	100000000
	.globl	MAX_ABS_X
	.align 8
	.type	MAX_ABS_X, @object
	.size	MAX_ABS_X, 8
MAX_ABS_X:
	.long	858993459
	.long	1071854387
	.text
	.globl	calc
	.type	calc, @function
calc:
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR [rbp-40], xmm0 # x - double
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR [rbp-8], xmm0
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR [rbp-16], xmm0
	mov	DWORD PTR [rbp-20], 0
	jmp	.L2
.L3:
	movsd	xmm0, QWORD PTR [rbp-16] # Основной цикл умножения-сложения.
	mulsd	xmm0, QWORD PTR [rbp-40]
	movsd	QWORD PTR [rbp-16], xmm0
	movsd	xmm0, QWORD PTR [rbp-8]
	addsd	xmm0, QWORD PTR [rbp-16]
	movsd	QWORD PTR [rbp-8], xmm0
	add	DWORD PTR [rbp-20], 1
.L2:
	cmp	DWORD PTR [rbp-20], 7
	jle	.L3
	movsd	xmm0, QWORD PTR [rbp-8]
	movq	rax, xmm0
	movq	xmm0, rax
	pop	rbp
	ret
	.size	calc, .-calc
	.section	.rodata
.LC1:
	.string	"%lf"
	.text
	.globl	read_double
	.type	read_double, @function
read_double:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	lea	rdx, [rbp-8]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, OFFSET FLAT:.LC1
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf
	movsd	xmm0, QWORD PTR [rbp-8]
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	read_double, .-read_double
	.globl	rand_double
	.type	rand_double, @function
rand_double:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	edi, 0
	call	time
	mov	edi, eax
	call	srand
	call	rand
	cmp	eax, 1073741823
	jle	.L8
	movsd	xmm0, QWORD PTR .LC2[rip]
	jmp	.L9
.L8:
	movsd	xmm0, QWORD PTR .LC0[rip]
.L9:
	movsd	xmm1, QWORD PTR .LC3[rip]
	movsd	xmm2, QWORD PTR .LC4[rip]
	divsd	xmm1, xmm2
	mulsd	xmm0, xmm1
	movsd	QWORD PTR [rbp-8], xmm0
	call	rand
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	mulsd	xmm0, QWORD PTR [rbp-8]
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	rand_double, .-rand_double
	.section	.rodata
.LC5:
	.string	"Not enough arguments!"
.LC6:
	.string	"Generated x: %lf\n"
.LC7:
	.string	"r"
.LC8:
	.string	"w"
	.align 8
.LC9:
	.string	"Input type argument not recognised!"
	.align 8
.LC11:
	.string	"X is too far from 0; delta will be huge"
.LC13:
	.string	"Time spent: %f\n"
.LC14:
	.string	"%lf\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	DWORD PTR [rbp-68], edi
	mov	QWORD PTR [rbp-80], rsi
	cmp	DWORD PTR [rbp-68], 1
	jg	.L12
	mov	edi, OFFSET FLAT:.LC5
	mov	eax, 0
	call	printf
	mov	eax, 1
	jmp	.L13
.L12:
	mov	rax, QWORD PTR [rbp-80]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rbp-21], al
	mov	rax, QWORD PTR stdout[rip]
	mov	QWORD PTR [rbp-16], rax
	cmp	BYTE PTR [rbp-21], 99
	jne	.L14
	mov	rax, QWORD PTR stdin[rip]
	mov	rdi, rax
	call	read_double
	movq	rax, xmm0 # Переменная переезжает в 64-битный регистр? Не уверен почему так. Или почему она просто не передается в нем...
	mov	QWORD PTR [rbp-8], rax
	jmp	.L15
.L14:
	cmp	BYTE PTR [rbp-21], 114
	je	.L16
	cmp	BYTE PTR [rbp-21], 115
	jne	.L17
.L16:
	mov	eax, 0
	call	rand_double
	movq	rax, xmm0 # Аналогичный странный блок кода
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	movq	xmm0, rax
	mov	edi, OFFSET FLAT:.LC6
	mov	eax, 1
	call	printf
	jmp	.L15
.L17:
	cmp	BYTE PTR [rbp-21], 102
	jne	.L18
	cmp	DWORD PTR [rbp-68], 3
	jg	.L19
	mov	edi, OFFSET FLAT:.LC5
	mov	eax, 0
	call	printf
	mov	eax, 1
	jmp	.L13
.L19:
	mov	rax, QWORD PTR [rbp-80]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	esi, OFFSET FLAT:.LC7
	mov	rdi, rax
	call	fopen
	mov	QWORD PTR [rbp-32], rax
	mov	rax, QWORD PTR [rbp-80]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	esi, OFFSET FLAT:.LC8
	mov	rdi, rax
	call	fopen
	mov	QWORD PTR [rbp-16], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	read_double
	movq	rax, xmm0
	mov	QWORD PTR [rbp-8], rax
	jmp	.L15
.L18:
	mov	edi, OFFSET FLAT:.LC9
	mov	eax, 0
	call	printf
	mov	eax, 1
	jmp	.L13
.L15:
	movsd	xmm0, QWORD PTR .LC10[rip]
	comisd	xmm0, QWORD PTR [rbp-8]
	ja	.L20
	movsd	xmm0, QWORD PTR [rbp-8]
	comisd	xmm0, QWORD PTR .LC3[rip]
	jbe	.L21
.L20:
	mov	rax, QWORD PTR stderr[rip]
	mov	rcx, rax
	mov	edx, 39
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC11
	call	fwrite
.L21:
	cmp	BYTE PTR [rbp-21], 115
	jne	.L23
	call	clock
	mov	QWORD PTR [rbp-48], rax
	mov	DWORD PTR [rbp-20], 0
	jmp	.L24
.L25:
	mov	rax, QWORD PTR [rbp-8]
	movq	xmm0, rax
	call	calc
	movq	rax, xmm0
	mov	QWORD PTR [rbp-40], rax
	add	DWORD PTR [rbp-20], 1
.L24:
	mov	eax, 100000000
	cmp	DWORD PTR [rbp-20], eax
	jl	.L25
	call	clock
	mov	QWORD PTR [rbp-56], rax
	mov	rax, QWORD PTR [rbp-56]
	sub	rax, QWORD PTR [rbp-48]
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax # аналогичная регистерная магия. Спасибо что не f87
	movsd	xmm1, QWORD PTR .LC12[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR [rbp-64], xmm0
	mov	rax, QWORD PTR [rbp-64]
	movq	xmm0, rax
	mov	edi, OFFSET FLAT:.LC13
	mov	eax, 1
	call	printf
	jmp	.L26
.L23:
	mov	rax, QWORD PTR [rbp-8]
	movq	xmm0, rax
	call	calc
	movq	rax, xmm0
	mov	QWORD PTR [rbp-40], rax
	mov	rdx, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rbp-16]
	movq	xmm0, rdx
	mov	esi, OFFSET FLAT:.LC14
	mov	rdi, rax
	mov	eax, 1
	call	fprintf
.L26:
	mov	rax, QWORD PTR [rbp-16]
	mov	rdi, rax
	call	fclose
	mov	eax, 0
.L13:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC2:
	.long	0
	.long	-1074790400
	.align 8
.LC3:
	.long	858993459
	.long	1071854387
	.align 8
.LC4:
	.long	-4194304
	.long	1105199103
	.align 8
.LC10:
	.long	858993459
	.long	-1075629261
	.align 8
.LC12:
	.long	0
	.long	1093567616
	.ident	"GCC: (GNU) 12.2.1 20220819 (Red Hat 12.2.1-2)"
	.section	.note.GNU-stack,"",@progbits

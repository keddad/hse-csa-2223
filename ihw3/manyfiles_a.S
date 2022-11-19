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
    .section	.rodata
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC1:
	.string	"%lf"
	.text
	.globl	read_double
	.type	read_double, @function
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
	.text
	.globl	calc
	.type	calc, @function
calc:
    movapd  xmm2, xmm0
    mov     eax, 8
    movsd   xmm1, QWORD PTR .LC0[rip]
    movapd  xmm0, xmm1
.L2:
    mulsd   xmm1, xmm2
    addsd   xmm0, xmm1
    sub     eax, 1
    jne     .L2
    
    ret
	.size	calc, .-calc
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
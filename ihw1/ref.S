	.file	"ref.c"
	.intel_syntax noprefix
	.text
	.globl	SPEEDTEST_N
	.section	.rodata
	.align 4
	.type	SPEEDTEST_N, @object
	.size	SPEEDTEST_N, 4
SPEEDTEST_N:
	.long	100000
.LC0:
	.string	"%d"
	.text
	.globl	read_arr
	.type	read_arr, @function
read_arr:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR [rbp-20], edi
	mov	QWORD PTR [rbp-32], rsi
	mov	QWORD PTR [rbp-40], rdx
	mov	DWORD PTR [rbp-4], 0
	jmp	.L2
.L3:
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rdx, rax
	mov	rax, QWORD PTR [rbp-40]
	mov	esi, OFFSET FLAT:.LC0
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf
	add	DWORD PTR [rbp-4], 1
.L2:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-20]
	jl	.L3
	nop
	nop
	leave
	ret
	.size	read_arr, .-read_arr
	.section	.rodata
.LC1:
	.string	"%d "
	.text
	.globl	write_arr
	.type	write_arr, @function
write_arr:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR [rbp-20], edi
	mov	QWORD PTR [rbp-32], rsi
	mov	QWORD PTR [rbp-40], rdx
	mov	DWORD PTR [rbp-4], 0
	jmp	.L5
.L6:
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	esi, OFFSET FLAT:.LC1
	mov	rdi, rax
	mov	eax, 0
	call	fprintf
	add	DWORD PTR [rbp-4], 1
.L5:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-20]
	jl	.L6
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, rax
	mov	edi, 10
	call	fputc
	nop
	leave
	ret
	.size	write_arr, .-write_arr
	.globl	generate_arr
	.type	generate_arr, @function
generate_arr:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 40
	mov	DWORD PTR [rbp-36], edi
	mov	QWORD PTR [rbp-48], rsi
	mov	edi, 0
	call	time
	mov	edi, eax
	call	srand
	mov	DWORD PTR [rbp-20], 0
	jmp	.L8
.L10:
	mov	eax, DWORD PTR [rbp-20]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-48]
	lea	rbx, [rdx+rax]
	call	rand
	mov	DWORD PTR [rbx], eax
	call	rand
	and	eax, 1
	test	eax, eax
	je	.L9
	mov	eax, DWORD PTR [rbp-20]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-48]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-20]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-48]
	add	rax, rcx
	neg	edx
	mov	DWORD PTR [rax], edx
.L9:
	add	DWORD PTR [rbp-20], 1
.L8:
	mov	eax, DWORD PTR [rbp-20]
	cmp	eax, DWORD PTR [rbp-36]
	jl	.L10
	nop
	nop
	mov	rbx, QWORD PTR [rbp-8]
	leave
	ret
	.size	generate_arr, .-generate_arr
	.globl	process
	.type	process, @function
process:
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR [rbp-20], edi
	mov	QWORD PTR [rbp-32], rsi
	mov	QWORD PTR [rbp-40], rdx
	mov	DWORD PTR [rbp-4], 0
	jmp	.L12
.L15:
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jle	.L13
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-40]
	add	rax, rdx
	mov	DWORD PTR [rax], 2
	jmp	.L14
.L13:
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jns	.L14
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-40]
	add	rax, rcx
	add	edx, 5
	mov	DWORD PTR [rax], edx
.L14:
	add	DWORD PTR [rbp-4], 1
.L12:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-20]
	jl	.L15
	nop
	nop
	pop	rbp
	ret
	.size	process, .-process
	.section	.rodata
.LC2:
	.string	"Not enough arguments!"
.LC3:
	.string	"Generated array: "
.LC4:
	.string	"r"
.LC5:
	.string	"w"
	.align 8
.LC6:
	.string	"Input type argument not recognised!"
.LC8:
	.string	"Time spent: %f\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 96
	mov	DWORD PTR [rbp-84], edi
	mov	QWORD PTR [rbp-96], rsi
	cmp	DWORD PTR [rbp-84], 2
	jg	.L17
	mov	edi, OFFSET FLAT:.LC2
	mov	eax, 0
	call	printf
	mov	eax, 1
	jmp	.L18
.L17:
	mov	rax, QWORD PTR [rbp-96]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rbp-13], al
	mov	rax, QWORD PTR [rbp-96]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi
	mov	DWORD PTR [rbp-20], eax
	mov	rax, QWORD PTR stdout[rip]
	mov	QWORD PTR [rbp-8], rax
	mov	eax, DWORD PTR [rbp-20]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	eax, DWORD PTR [rbp-20]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc
	mov	QWORD PTR [rbp-40], rax
	cmp	BYTE PTR [rbp-13], 99
	jne	.L19
	mov	rdx, QWORD PTR stdin[rip]
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-20]
	mov	rsi, rcx
	mov	edi, eax
	call	read_arr
	jmp	.L20
.L19:
	cmp	BYTE PTR [rbp-13], 114
	je	.L21
	cmp	BYTE PTR [rbp-13], 115
	jne	.L22
.L21:
	mov	rdx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-20]
	mov	rsi, rdx
	mov	edi, eax
	call	generate_arr
	mov	edi, OFFSET FLAT:.LC3
	mov	eax, 0
	call	printf
	mov	rdx, QWORD PTR [rbp-8]
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-20]
	mov	rsi, rcx
	mov	edi, eax
	call	write_arr
	jmp	.L20
.L22:
	cmp	BYTE PTR [rbp-13], 102
	jne	.L23
	cmp	DWORD PTR [rbp-84], 4
	jg	.L24
	mov	edi, OFFSET FLAT:.LC2
	mov	eax, 0
	call	printf
	mov	eax, 1
	jmp	.L18
.L24:
	mov	rax, QWORD PTR [rbp-96]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	esi, OFFSET FLAT:.LC4
	mov	rdi, rax
	call	fopen
	mov	QWORD PTR [rbp-48], rax
	mov	rax, QWORD PTR [rbp-96]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	mov	esi, OFFSET FLAT:.LC5
	mov	rdi, rax
	call	fopen
	mov	QWORD PTR [rbp-8], rax
	mov	rdx, QWORD PTR [rbp-48]
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-20]
	mov	rsi, rcx
	mov	edi, eax
	call	read_arr
	mov	rax, QWORD PTR [rbp-48]
	mov	rdi, rax
	call	fclose
	jmp	.L20
.L23:
	mov	edi, OFFSET FLAT:.LC6
	mov	eax, 0
	call	printf
	mov	eax, 1
	jmp	.L18
.L20:
	cmp	BYTE PTR [rbp-13], 115
	jne	.L25
	call	clock
	mov	QWORD PTR [rbp-56], rax
	mov	DWORD PTR [rbp-12], 0
	jmp	.L26
.L27:
	mov	rdx, QWORD PTR [rbp-40]
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-20]
	mov	rsi, rcx
	mov	edi, eax
	call	process
	add	DWORD PTR [rbp-12], 1
.L26:
	mov	eax, 100000
	cmp	DWORD PTR [rbp-12], eax
	jl	.L27
	call	clock
	mov	QWORD PTR [rbp-64], rax
	mov	rax, QWORD PTR [rbp-64]
	sub	rax, QWORD PTR [rbp-56]
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	movsd	xmm1, QWORD PTR .LC7[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR [rbp-72], xmm0
	mov	rax, QWORD PTR [rbp-72]
	movq	xmm0, rax
	mov	edi, OFFSET FLAT:.LC8
	mov	eax, 1
	call	printf
	jmp	.L28
.L25:
	mov	rdx, QWORD PTR [rbp-40]
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-20]
	mov	rsi, rcx
	mov	edi, eax
	call	process
	mov	rdx, QWORD PTR [rbp-8]
	mov	rcx, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rbp-20]
	mov	rsi, rcx
	mov	edi, eax
	call	write_arr
.L28:
	mov	rax, QWORD PTR [rbp-8]
	mov	rdi, rax
	call	fclose
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-40]
	mov	rdi, rax
	call	free
	mov	eax, 0
.L18:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC7:
	.long	0
	.long	1093567616
	.ident	"GCC: (GNU) 12.2.1 20220819 (Red Hat 12.2.1-2)"
	.section	.note.GNU-stack,"",@progbits

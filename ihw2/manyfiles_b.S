.intel_syntax noprefix
    .text
    .align 4
    .globl read_strings
read_strings:
    push    rbp
    mov rbp, rsp
    sub rsp, 32
    mov QWORD PTR [rbp-8], rdi # a
    mov QWORD PTR [rbp-16], rsi # b
    mov QWORD PTR [rbp-24], rdx # file*
    mov ecx, 1048576
    mov rdx, QWORD PTR [rbp-24]
    mov rax, QWORD PTR [rbp-8]
    mov esi, ecx
    mov rdi, rax
    call    fgets
    mov ecx, 1048576
    mov rdx, QWORD PTR [rbp-24]
    mov rax, QWORD PTR [rbp-16]
    mov esi, ecx
    mov rdi, rax
    call    fgets
    nop
    leave
    ret
    .size   read_strings, .-read_strings
    .globl  write_arr
    .type   write_arr, @function
write_arr:
    push    rbp
    mov rbp, rsp
    sub rsp, 16
    mov QWORD PTR [rbp-8], rdi # a
    mov QWORD PTR [rbp-16], rsi # file
    mov rdx, QWORD PTR [rbp-16]
    mov rax, QWORD PTR [rbp-8]
    mov rsi, rdx
    mov rdi, rax
    call    fputs
    mov rax, QWORD PTR [rbp-16]
    mov rsi, rax
    mov edi, 10
    call    fputc
    nop
    leave
    ret
    .size   write_arr, .-write_arr
    .globl  generate_arr
    .type   generate_arr, @function
generate_arr:
    push    rbp
    mov rbp, rsp
    sub rsp, 32
    mov QWORD PTR [rbp-24], rdi # a
    mov DWORD PTR [rbp-28], esi # a size
    mov edi, 0
    call    time
    mov edx, eax
    mov rax, QWORD PTR [rbp-24]
    add eax, edx
    mov edi, eax
    call    srand
    mov DWORD PTR [rbp-4], 0
    jmp .L4
.L5:
    call    rand
    mov ecx, 127
    cdq
    idiv    ecx
    mov ecx, edx
    mov eax, DWORD PTR [rbp-4]
    movsx   rdx, eax
    mov rax, QWORD PTR [rbp-24]
    add rax, rdx
    mov edx, ecx
    mov BYTE PTR [rax], dl
    add DWORD PTR [rbp-4], 1
.L4:
    mov eax, DWORD PTR [rbp-4]
    cmp eax, DWORD PTR [rbp-28]
    jl  .L5
    nop
    nop
    leave
    ret
    .size   generate_arr, .-generate_arr
    .globl  fill_chararr
    .type   fill_chararr, @function
fill_chararr:
    push    rbp
    mov rbp, rsp
    sub rsp, 32
    mov rax, rdi # s
    mov r13, rsi # corresponding chararr
    mov r12, rax
    mov eax, 127
    movsx   rdx, eax
    mov rax, r13
    mov esi, 0
    mov rdi, rax
    call    memset
    jmp .L7
.L8:
    mov rax, r12
    movzx   eax, BYTE PTR [rax]
    movsx   eax, al
    mov ecx, 127
    cdq
    idiv    ecx
    mov eax, edx
    movsx   rdx, eax
    mov rax, r13
    add rax, rdx
    mov BYTE PTR [rax], 1
    add r12, 1
.L7:
    mov rax, r12
    movzx   eax, BYTE PTR [rax]
    test    al, al
    jne .L8
    nop
    nop
    leave
    ret
    .size   fill_chararr, .-fill_chararr
    .globl  gen_answer
    .type   gen_answer, @function
gen_answer:
    push    rbp
    mov rbp, rsp
    sub rsp, 64
    mov r12, rdi # charset1
    mov r13, rsi # charset2
    mov r14, rdx # diff1
    mov r15, rcx # diff2
    mov eax, 127
    add eax, 1
    movsx   rdx, eax
    mov rax, r14
    mov esi, 0
    mov rdi, rax
    call    memset
    mov eax, 127
    add eax, 1
    movsx   rdx, eax
    mov rax, r15
    mov esi, 0
    mov rdi, rax
    call    memset
    mov rax, r14
    mov QWORD PTR [rbp-8], rax
    mov rax, r15
    mov QWORD PTR [rbp-16], rax
    mov DWORD PTR [rbp-20], 0
    jmp .L10
.L13:
    mov eax, DWORD PTR [rbp-20]
    movsx   rdx, eax
    mov rax, r12
    add rax, rdx
    movzx   eax, BYTE PTR [rax]
    test    al, al
    je  .L11
    mov eax, DWORD PTR [rbp-20]
    movsx   rdx, eax
    mov rax, r13
    add rax, rdx
    movzx   eax, BYTE PTR [rax]
    test    al, al
    jne .L11
    mov eax, DWORD PTR [rbp-20]
    mov edx, eax
    mov rax, QWORD PTR [rbp-8]
    mov BYTE PTR [rax], dl
    add QWORD PTR [rbp-8], 1
.L11:
    mov eax, DWORD PTR [rbp-20]
    movsx   rdx, eax
    mov rax, r12
    add rax, rdx
    movzx   eax, BYTE PTR [rax]
    test    al, al
    jne .L12
    mov eax, DWORD PTR [rbp-20]
    movsx   rdx, eax
    mov rax, r13
    add rax, rdx
    movzx   eax, BYTE PTR [rax]
    test    al, al
    je  .L12
    mov eax, DWORD PTR [rbp-20]
    mov edx, eax
    mov rax, QWORD PTR [rbp-16]
    mov BYTE PTR [rax], dl
    add QWORD PTR [rbp-16], 1
.L12:
    add DWORD PTR [rbp-20], 1
.L10:
    mov eax, 127
    cmp DWORD PTR [rbp-20], eax
    jl  .L13
    nop
    nop
    leave
    ret
    .file   "ref.c"
    .intel_syntax noprefix
    .text
    .globl  SPEEDTEST_N
    .section    .rodata
    .align 4
    .type   SPEEDTEST_N, @object
    .size   SPEEDTEST_N, 4
SPEEDTEST_N:
    .long   1000000
    .globl  MAX_STRING_SIZE
    .align 4
    .type   MAX_STRING_SIZE, @object
    .size   MAX_STRING_SIZE, 4
MAX_STRING_SIZE:
    .long   1048576
    .globl  ALPHABET_SIZE
    .align 4
    .type   ALPHABET_SIZE, @object
    .size   ALPHABET_SIZE, 4
ALPHABET_SIZE:
    .long   127
    .text
    .globl  read_strings
    .type   read_strings, @function
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
    .size   gen_answer, .-gen_answer
    .section    .rodata
.LC0:
    .string "Not enough arguments!"
.LC1:
    .string "Generated strings:"
.LC2:
    .string "r"
.LC3:
    .string "w"
    .align 8
.LC4:
    .string "Input type argument not recognised!"
.LC6:
    .string "Time spent: %f\n"
    .text
    .globl  main
    .type   main, @function
main:
    push    rbp
    mov rbp, rsp
    push    r14
    push    r13
    push    r12
    push    rbx
    sub rsp, 304 # that's a big stack!
    mov DWORD PTR [rbp-196], edi
    mov QWORD PTR [rbp-208], rsi
    mov rax, rsp
    mov r14, rax
    cmp DWORD PTR [rbp-196], 1
    jg  .L15
    mov edi, OFFSET FLAT:.LC0
    mov eax, 0
    call    printf
    mov eax, 1
    jmp .L16
.L15:
    mov eax, 1048576
    cdqe
    sub rax, 1
    mov QWORD PTR [rbp-56], rax
    mov eax, 1048576
    cdqe
    mov rcx, rax
    mov ebx, 0
    mov eax, 1048576
    cdqe
    mov r8, rax
    mov r9d, 0
    mov eax, 1048576
    movsx   rdx, eax
    mov eax, 16
    sub rax, 1
    add rax, rdx
    mov ebx, 16
    mov edx, 0
    div rbx
    imul    rax, rax, 16
    sub rsp, rax
    mov rax, rsp
    add rax, 0
    mov QWORD PTR [rbp-64], rax
    mov eax, 1048576
    cdqe
    sub rax, 1
    mov QWORD PTR [rbp-72], rax
    mov eax, 1048576
    cdqe
    mov r10, rax
    mov r11d, 0
    mov eax, 1048576
    cdqe
    mov r12, rax
    mov r13d, 0
    mov eax, 1048576
    movsx   rdx, eax
    mov eax, 16
    sub rax, 1
    add rax, rdx
    mov ebx, 16
    mov edx, 0
    div rbx
    imul    rax, rax, 16
    sub rsp, rax
    mov rax, rsp
    add rax, 0
    mov QWORD PTR [rbp-80], rax
    mov eax, 127
    cdqe
    sub rax, 1
    mov QWORD PTR [rbp-88], rax
    mov eax, 127
    cdqe
    mov QWORD PTR [rbp-224], rax
    mov QWORD PTR [rbp-216], 0
    mov eax, 127
    cdqe
    mov QWORD PTR [rbp-240], rax
    mov QWORD PTR [rbp-232], 0
    mov eax, 127
    movsx   rdx, eax
    mov eax, 16
    sub rax, 1
    add rax, rdx
    mov ebx, 16
    mov edx, 0
    div rbx
    imul    rax, rax, 16
    sub rsp, rax
    mov rax, rsp
    add rax, 0
    mov QWORD PTR [rbp-96], rax
    mov eax, 127
    cdqe
    sub rax, 1
    mov QWORD PTR [rbp-104], rax
    mov eax, 127
    cdqe
    mov QWORD PTR [rbp-256], rax
    mov QWORD PTR [rbp-248], 0
    mov eax, 127
    cdqe
    mov QWORD PTR [rbp-272], rax
    mov QWORD PTR [rbp-264], 0
    mov eax, 127
    cdqe
    mov edx, 16
    sub rdx, 1
    add rax, rdx
    mov ebx, 16
    mov edx, 0
    div rbx
    imul    rax, rax, 16
    sub rsp, rax
    mov rax, rsp
    add rax, 0
    mov QWORD PTR [rbp-112], rax
    mov eax, 127
    add eax, 1
    cdqe
    sub rax, 1
    mov QWORD PTR [rbp-120], rax
    mov eax, 127
    add eax, 1
    cdqe
    mov QWORD PTR [rbp-288], rax
    mov QWORD PTR [rbp-280], 0
    mov eax, 127
    add eax, 1
    cdqe
    mov QWORD PTR [rbp-304], rax
    mov QWORD PTR [rbp-296], 0
    mov eax, 127
    add eax, 1
    cdqe
    mov edx, 16
    sub rdx, 1
    add rax, rdx
    mov ebx, 16
    mov edx, 0
    div rbx
    imul    rax, rax, 16
    sub rsp, rax
    mov rax, rsp
    add rax, 0
    mov QWORD PTR [rbp-128], rax
    mov eax, 127
    add eax, 1
    cdqe
    sub rax, 1
    mov QWORD PTR [rbp-136], rax
    mov eax, 127
    add eax, 1
    cdqe
    mov QWORD PTR [rbp-320], rax
    mov QWORD PTR [rbp-312], 0
    mov eax, 127
    add eax, 1
    cdqe
    mov QWORD PTR [rbp-336], rax
    mov QWORD PTR [rbp-328], 0
    mov eax, 127
    add eax, 1
    cdqe
    mov edx, 16
    sub rdx, 1
    add rax, rdx
    mov ebx, 16
    mov edx, 0
    div rbx
    imul    rax, rax, 16
    sub rsp, rax
    mov rax, rsp
    add rax, 0
    mov QWORD PTR [rbp-144], rax
    mov rax, QWORD PTR [rbp-208]
    add rax, 8
    mov rax, QWORD PTR [rax]
    movzx   eax, BYTE PTR [rax]
    mov BYTE PTR [rbp-145], al
    mov rax, QWORD PTR stdout[rip]
    mov QWORD PTR [rbp-40], rax
    cmp BYTE PTR [rbp-145], 99
    jne .L17
    mov rdx, QWORD PTR stdin[rip]
    mov rcx, QWORD PTR [rbp-80]
    mov rax, QWORD PTR [rbp-64]
    mov rsi, rcx
    mov rdi, rax
    call    read_strings
    jmp .L18
.L17:
    cmp BYTE PTR [rbp-145], 114
    je  .L19
    cmp BYTE PTR [rbp-145], 115
    jne .L20
.L19:
    cmp DWORD PTR [rbp-196], 2
    jg  .L21
    mov edi, OFFSET FLAT:.LC0
    mov eax, 0
    call    printf
    mov eax, 1
    jmp .L16
.L21:
    mov rax, QWORD PTR [rbp-208]
    add rax, 16
    mov rax, QWORD PTR [rax]
    mov rdi, rax
    call    atoi
    mov DWORD PTR [rbp-164], eax
    mov edx, DWORD PTR [rbp-164]
    mov rax, QWORD PTR [rbp-64]
    mov esi, edx
    mov rdi, rax
    call    generate_arr
    mov edx, DWORD PTR [rbp-164]
    mov rax, QWORD PTR [rbp-80]
    mov esi, edx
    mov rdi, rax
    call    generate_arr
    mov edi, OFFSET FLAT:.LC1
    call    puts
    mov rdx, QWORD PTR stdout[rip]
    mov rax, QWORD PTR [rbp-64]
    mov rsi, rdx
    mov rdi, rax
    call    write_arr
    mov rdx, QWORD PTR stdout[rip]
    mov rax, QWORD PTR [rbp-80]
    mov rsi, rdx
    mov rdi, rax
    call    write_arr
    jmp .L18
.L20:
    cmp BYTE PTR [rbp-145], 102
    jne .L22
    cmp DWORD PTR [rbp-196], 3
    jg  .L23
    mov edi, OFFSET FLAT:.LC0
    mov eax, 0
    call    printf
    mov eax, 1
    jmp .L16
.L23:
    mov rax, QWORD PTR [rbp-208]
    add rax, 16
    mov rax, QWORD PTR [rax]
    mov esi, OFFSET FLAT:.LC2
    mov rdi, rax
    call    fopen
    mov QWORD PTR [rbp-160], rax
    mov rax, QWORD PTR [rbp-208]
    add rax, 24
    mov rax, QWORD PTR [rax]
    mov esi, OFFSET FLAT:.LC3
    mov rdi, rax
    call    fopen
    mov QWORD PTR [rbp-40], rax
    mov rdx, QWORD PTR [rbp-160]
    mov rcx, QWORD PTR [rbp-80]
    mov rax, QWORD PTR [rbp-64]
    mov rsi, rcx
    mov rdi, rax
    call    read_strings
    jmp .L18
.L22:
    mov edi, OFFSET FLAT:.LC4
    mov eax, 0
    call    printf
    mov eax, 1
    jmp .L16
.L18:
    cmp BYTE PTR [rbp-145], 115
    jne .L24
    call    clock
    mov QWORD PTR [rbp-176], rax
    mov DWORD PTR [rbp-44], 0
    jmp .L25
.L26:
    mov rdx, QWORD PTR [rbp-96]
    mov rax, QWORD PTR [rbp-64]
    mov rsi, rdx
    mov rdi, rax
    call    fill_chararr
    mov rdx, QWORD PTR [rbp-112]
    mov rax, QWORD PTR [rbp-80]
    mov rsi, rdx
    mov rdi, rax
    call    fill_chararr
    mov rcx, QWORD PTR [rbp-144]
    mov rdx, QWORD PTR [rbp-128]
    mov rsi, QWORD PTR [rbp-112]
    mov rax, QWORD PTR [rbp-96]
    mov rdi, rax
    call    gen_answer
    add DWORD PTR [rbp-44], 1
.L25:
    mov eax, 100000
    cmp DWORD PTR [rbp-44], eax
    jl  .L26
    call    clock
    mov QWORD PTR [rbp-184], rax
    mov rax, QWORD PTR [rbp-184]
    sub rax, QWORD PTR [rbp-176]
    pxor    xmm0, xmm0
    cvtsi2sd    xmm0, rax
    movsd   xmm1, QWORD PTR .LC5[rip]
    divsd   xmm0, xmm1
    movsd   QWORD PTR [rbp-192], xmm0
    mov rax, QWORD PTR [rbp-192]
    movq    xmm0, rax
    mov edi, OFFSET FLAT:.LC6
    mov eax, 1
    call    printf
    jmp .L27
.L24:
    mov rdx, QWORD PTR [rbp-96]
    mov rax, QWORD PTR [rbp-64]
    mov rsi, rdx
    mov rdi, rax
    call    fill_chararr
    mov rdx, QWORD PTR [rbp-112]
    mov rax, QWORD PTR [rbp-80]
    mov rsi, rdx
    mov rdi, rax
    call    fill_chararr
    mov rcx, QWORD PTR [rbp-144]
    mov rdx, QWORD PTR [rbp-128]
    mov rsi, QWORD PTR [rbp-112]
    mov rax, QWORD PTR [rbp-96]
    mov rdi, rax
    call    gen_answer
    mov rdx, QWORD PTR [rbp-40]
    mov rax, QWORD PTR [rbp-128]
    mov rsi, rdx
    mov rdi, rax
    call    write_arr
    mov rdx, QWORD PTR [rbp-40]
    mov rax, QWORD PTR [rbp-144]
    mov rsi, rdx
    mov rdi, rax
    call    write_arr
.L27:
    mov rax, QWORD PTR [rbp-40]
    mov rdi, rax
    call    fclose
    mov eax, 0
.L16:
    mov rsp, r14
    lea rsp, [rbp-32]
    pop rbx
    pop r12
    pop r13
    pop r14
    pop rbp
    ret
    .size   main, .-main
    .section    .rodata
    .align 8
.LC5:
    .long   0
    .long   1093567616
    .ident  "GCC: (GNU) 12.2.1 20220819 (Red Hat 12.2.1-2)"
    .section    .note.GNU-stack,"",@progbits

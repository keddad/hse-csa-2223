    .intel_syntax noprefix
    .text
    .globl  SPEEDTEST_N
    .section    .rodata
    .align 4
    .type   SPEEDTEST_N, @object
    .size   SPEEDTEST_N, 4
SPEEDTEST_N:
    .long   100000

    .section    .rodata
.LC2:
    .string "Not enough arguments!"
.LC3:
    .string "Generated array: "
.LC4:
    .string "r"
.LC5:
    .string "w"
    .align 8
.LC6:
    .string "Input type argument not recognised!"
.LC8:
    .string "Time spent: %f\n"
    .text
    .globl  main
    .type   main, @function
main:
    push    rbp
    mov rbp, rsp
    sub rsp, 96
    mov DWORD PTR [rbp-84], edi
    mov QWORD PTR [rbp-96], rsi
    cmp DWORD PTR [rbp-84], 2
    jg  .L17
    mov edi, OFFSET FLAT:.LC2
    mov eax, 0
    call    printf # Нехватка аргументов
    mov eax, 1
    jmp .L18
.L17:
    mov rax, QWORD PTR [rbp-96]
    add rax, 8
    mov rax, QWORD PTR [rax]
    movzx   eax, BYTE PTR [rax]
    mov BYTE PTR [rbp-13], al # input_type
    mov rax, QWORD PTR [rbp-96]
    add rax, 16
    mov rax, QWORD PTR [rax]
    mov rdi, rax
    call    atoi
    mov DWORD PTR [rbp-20], eax # input_size
    mov rax, QWORD PTR stdout[rip]
    mov QWORD PTR [rbp-8], rax
    mov eax, DWORD PTR [rbp-20]
    cdqe
    sal rax, 2
    mov rdi, rax
    call    malloc
    mov QWORD PTR [rbp-32], rax
    mov eax, DWORD PTR [rbp-20]
    cdqe
    sal rax, 2
    mov rdi, rax
    call    malloc
    mov QWORD PTR [rbp-40], rax # Выделили под все память
    cmp BYTE PTR [rbp-13], 99
    jne .L19
    mov rdx, QWORD PTR stdin[rip] # Ввод с консоли
    mov rcx, QWORD PTR [rbp-32]
    mov eax, DWORD PTR [rbp-20]
    mov rsi, rcx
    mov edi, eax
    call    read_arr
    jmp .L20
.L19:
    cmp BYTE PTR [rbp-13], 114
    je  .L21
    cmp BYTE PTR [rbp-13], 115
    jne .L22
.L21:
    mov rdx, QWORD PTR [rbp-32]
    mov eax, DWORD PTR [rbp-20]
    mov rsi, rdx
    mov edi, eax
    call    generate_arr # Случайная генерация чисел
    mov edi, OFFSET FLAT:.LC3
    mov eax, 0
    call    printf
    mov rdx, QWORD PTR [rbp-8]
    mov rcx, QWORD PTR [rbp-32]
    mov eax, DWORD PTR [rbp-20]
    mov rsi, rcx
    mov edi, eax
    call    write_arr # Печатаем
    jmp .L20
.L22:
    cmp BYTE PTR [rbp-13], 102
    jne .L23
    cmp DWORD PTR [rbp-84], 4
    jg  .L24
    mov edi, OFFSET FLAT:.LC2 # Недостаточно аргуемнтов для файлов
    mov eax, 0
    call    printf
    mov eax, 1
    jmp .L18
.L24:
    mov rax, QWORD PTR [rbp-96]
    add rax, 24
    mov rax, QWORD PTR [rax]
    mov esi, OFFSET FLAT:.LC4
    mov rdi, rax
    call    fopen # in_file
    mov QWORD PTR [rbp-48], rax
    mov rax, QWORD PTR [rbp-96]
    add rax, 32
    mov rax, QWORD PTR [rax]
    mov esi, OFFSET FLAT:.LC5
    mov rdi, rax
    call    fopen # out_file
    mov QWORD PTR [rbp-8], rax
    mov rdx, QWORD PTR [rbp-48]
    mov rcx, QWORD PTR [rbp-32]
    mov eax, DWORD PTR [rbp-20]
    mov rsi, rcx
    mov edi, eax
    call    read_arr # Читаем массивчик из файла
    mov rax, QWORD PTR [rbp-48]
    mov rdi, rax
    call    fclose # Закрываем in_file
    jmp .L20
.L23:
    mov edi, OFFSET FLAT:.LC6
    mov eax, 0
    call    printf # Выходим так как неправильный режим ввода
    mov eax, 1
    jmp .L18
.L20:
    cmp BYTE PTR [rbp-13], 115
    jne .L25
    call    clock # Бенчмарк
    mov QWORD PTR [rbp-56], rax
    mov DWORD PTR [rbp-12], 0
    jmp .L26
.L27:
    mov rdx, QWORD PTR [rbp-40]
    mov rcx, QWORD PTR [rbp-32]
    mov eax, DWORD PTR [rbp-20]
    mov rsi, rcx
    mov edi, eax
    call    process
    add DWORD PTR [rbp-12], 1
.L26:
    mov eax, 100000
    cmp DWORD PTR [rbp-12], eax
    jl  .L27
    call    clock # Конец бенчмарка
    mov QWORD PTR [rbp-64], rax
    mov rax, QWORD PTR [rbp-64]
    sub rax, QWORD PTR [rbp-56]
    pxor    xmm0, xmm0
    cvtsi2sd    xmm0, rax
    movsd   xmm1, QWORD PTR .LC7[rip]
    divsd   xmm0, xmm1
    movsd   QWORD PTR [rbp-72], xmm0 # Floating-point для получегия кол-ва секунд
    mov rax, QWORD PTR [rbp-72]
    movq    xmm0, rax
    mov edi, OFFSET FLAT:.LC8
    mov eax, 1
    call    printf
    jmp .L28
.L25:
    mov rdx, QWORD PTR [rbp-40]
    mov rcx, QWORD PTR [rbp-32]
    mov eax, DWORD PTR [rbp-20]
    mov rsi, rcx
    mov edi, eax
    call    process
    mov rdx, QWORD PTR [rbp-8]
    mov rcx, QWORD PTR [rbp-40]
    mov eax, DWORD PTR [rbp-20]
    mov rsi, rcx
    mov edi, eax
    call    write_arr # Бранч без бенчмаркинга
.L28:
    mov rax, QWORD PTR [rbp-8]
    mov rdi, rax
    call    fclose # Чистим память
    mov rax, QWORD PTR [rbp-32]
    mov rdi, rax
    call    free
    mov rax, QWORD PTR [rbp-40]
    mov rdi, rax
    call    free
    mov eax, 0
.L18:
    leave
    ret
    .size   main, .-main
    .section    .rodata
    .align 8
.LC7:
    .long   0
    .long   1093567616
    .ident  "GCC: (GNU) 12.2.1 20220819 (Red Hat 12.2.1-2)"
    .section    .note.GNU-stack,"",@progbits

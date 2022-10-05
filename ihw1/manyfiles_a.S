    .intel_syntax noprefix
    .text
    .globl  SPEEDTEST_N
    .section    .rodata
    .align 4
    .type   SPEEDTEST_N, @object
    .size   SPEEDTEST_N, 4

.LC0:
    .string "%d"
    .text
    .globl  read_arr
    .type   read_arr, @function
read_arr:
    push    rbp
    mov rbp, rsp
    sub rsp, 48 # Выделяем место на стеке под переменные
    mov r12d, edi  # size
    mov r13, rsi # *Arr
    mov r14, rdx # FILE*
    mov r15d, 0 # i
    jmp .L2
.L3:
    mov eax, r15d
    lea rdx, [0+eax*4]
    mov rax, r13
    add rdx, rax
    mov rax, r14
    mov esi, OFFSET FLAT:.LC0
    mov rdi, rax
    mov eax, 0
    call    __isoc99_fscanf # Положили параметры в регистры, вызвали fscanf
    add r15d, 1
.L2:
    mov eax, r15d
    cmp eax, r12d
    jl  .L3 # Проверка условия цикла
    nop
    nop
    leave
    ret
    .size   read_arr, .-read_arr
    .section    .rodata
.LC1:
    .string "%d "
    .text
    .globl  write_arr
    .type   write_arr, @function
write_arr:
    push    rbp
    mov rbp, rsp
    sub rsp, 48
    mov r14d, edi # size
    mov r12, rsi # *arr
    mov r13, rdx # FILE*
    mov r15d, 0 # Положили переменные на стек
    jmp .L5
.L6:
    mov eax, r15d
    cdqe
    lea rdx, [0+rax*4]
    mov rax, r12
    add rax, rdx
    mov edx, DWORD PTR [rax]
    mov rax, r13
    mov esi, OFFSET FLAT:.LC1 # OFFSET FLAT - нулевой сдвиг, странная мелочь
    mov rdi, rax
    mov eax, 0
    call    fprintf # Напечатали элемент массива
    add r15d, 1
.L5:
    mov eax, r15d
    cmp eax, r14d
    jl  .L6
    mov rax, r13
    mov rsi, rax
    mov edi, 10
    call    fputc # Вышли из цикла, напечатали перенос строки
    nop
    leave
    ret
    .size   write_arr, .-write_arr
    .globl  generate_arr
    .type   generate_arr, @function
generate_arr:
    push    rbp
    mov rbp, rsp
    push    rbx
    sub rsp, 40
    mov r13d, edi # size
    mov r12, rsi # *arr
    mov edi, 0
    call    time
    mov edi, eax
    call    srand # Инициализировали ГСЧ
    mov r14d, 0
    jmp .L8
.L10:
    mov eax, r14d
    cdqe
    lea rdx, [0+rax*4]
    mov rax, r12
    lea rbx, [rdx+rax]
    call    rand
    mov DWORD PTR [rbx], eax # Положили случайное число в массив
    call    rand
    and eax, 1
    test    eax, eax
    je  .L9
    mov eax, r14d # Огромная неоптимизированная портянка для реализации - элемента
    cdqe
    lea rdx, [0+rax*4]
    mov rax, r12
    add rax, rdx
    mov edx, DWORD PTR [rax]
    mov eax, r14d
    cdqe
    lea rcx, [0+rax*4]
    mov rax, r12
    add rax, rcx
    neg edx
    mov DWORD PTR [rax], edx
.L9:
    add r14d, 1
.L8:
    mov eax, r14d
    cmp eax, r13d
    jl  .L10
    nop
    nop
    mov rbx, QWORD PTR [rbp-8]
    leave
    ret
    .size   generate_arr, .-generate_arr
    .globl  process
    .type   process, @function
process:
    push    rbp
    mov rbp, rsp
    mov r14d, edi # size
    mov r12, rsi # in_arr
    mov r13, rdx # out_arr
    mov r15d, 0
    jmp .L12
.L15:
    mov eax, r15d
    cdqe
    lea rdx, [0+rax*4]
    mov rax, r12
    add rax, rdx
    mov eax, DWORD PTR [rax]
    test    eax, eax
    jle .L13
    mov eax, r15d # Замена на 2
    cdqe
    lea rdx, [0+rax*4]
    mov rax, r13
    add rax, rdx
    mov DWORD PTR [rax], 2 
    jmp .L14
.L13:
    mov eax, r15d
    cdqe
    lea rdx, [0+rax*4]
    mov rax, r12
    add rax, rdx
    mov eax, DWORD PTR [rax]
    test    eax, eax
    jns .L14
    mov eax, r15d # Добавление +5
    cdqe
    lea rdx, [0+rax*4]
    mov rax, r12
    add rax, rdx
    mov edx, DWORD PTR [rax]
    mov eax, r15d
    cdqe
    lea rcx, [0+rax*4]
    mov rax, r13
    add rax, rcx
    add edx, 5
    mov DWORD PTR [rax], edx
.L14:
    add r15d, 1
.L12:
    mov eax, r15d
    cmp eax, r14d
    jl  .L15
    nop
    nop
    pop rbp
    ret
.intel_syntax noprefix
.section .rodata
format_in:
    .string      "%u"
format_out:
    .string      "fibo(%u) = %lu\n"

.section .data
    n: .long 0


.text               # Code
.globl  main
.type   main, @function

fib:
        xor     eax, eax
        test    edi, edi
        je      .L1
        cmp     edi, 1
        jle     .L5
        add     edi, 1
        mov     edx, 2
        mov     eax, 1
        xor     ecx, ecx
.L3:
        mov     esi, eax
        add     edx, 1
        add     eax, ecx
        mov     ecx, esi
        cmp     edx, edi
        jne     .L3
        ret
.L5:
        mov     eax, 1
.L1:
        ret

main:
    push    rbp
    mov     rbp, rsp

    # Ввод числа n
    lea     rdi, format_in[rip]     # адрес формата числа
    lea     rsi, n[rip]             # адрес n
    mov     rax, 0                  # не действительные числа
    call    scanf@plt               # ввод целого

    mov edi, n[rip]
    dec edi
    call fib@PLT

    lea     rdi, format_out[rip]    # формат вывода
    mov     esi, n[rip]                # номер выводимого числа
    mov   edx, eax        # значение выводимого числа
    xor     eax, 0                  # вывод целых чисел
    call    printf@PLT

    mov	rax, 0
    pop	rbp
    ret

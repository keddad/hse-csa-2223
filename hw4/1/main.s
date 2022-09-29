# Команды для компиляции, компоновки и запуска в gdb
# as --gstabs -o asm-hello-world.o asm-hello-world.s
# gcc asm-hello-world.o -o asm-hello-world
# ./hello
#------------------------------------------------

    .intel_syntax noprefix
    .section .rodata
msg_in:
    .string      "n? "
format_in:
    .string      "%u"
format_out:
    .string      "fibo(%u) = %lu\n"

    .section .data
n:      .long   0

    .text               # Code
    .globl  main
    .type   main, @function
main:
    push    rbp
    mov     rbp, rsp

    # Реализация алгоритма
    xor     rax, rax                # x1
    mov     rbx, 1                  # x2
    mov     ecx, 2                  # индекс формируемого числа
    mov     edx, 0                  # 0
loop_start:
    mov     r11, rax                # сохранение для операции
    add     r11, rbx                # следующее число
    jc      loop_out                # выход по переполнению
    mov     rax, rbx
    mov     rbx, r11
    inc     ecx
    jmp     loop_start
loop_out:
    dec     ecx                     # коррекция i

    # Вывод результата
    lea     rdi, format_out[rip]    # формат вывода
    mov     esi, ecx                # номер выводимого числа
    mov     rdx, rbx        # значение выводимого числа
    xor     eax, 0                  # вывод целых чисел
    call    printf@PLT

    mov	eax, 0
    pop	rbp
    ret

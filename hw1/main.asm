section .data
	string:     db 'Hello world!\n', 0
	stringlen:  equ $-string  ; macro


section .text
global _start
_start:
	mov eax, 1 ; write
	mov rdi, 1 ; stdout
	mov rsi, string 
	mov rdx, stringlen 
	syscall

	
	mov eax, 60 ; exit
	mov rdi, 0
	syscall
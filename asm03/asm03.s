section .data
number db "1337"

section .text
global _start

_start:

    mov rsi, [rsp + 16]

    mov al, [rsi]
    cmp al, '4'
    jne erreur

    mov al, [rsi + 1]
    cmp al, '2'
    jne erreur

    mov rax, 1
    mov rdi, 1
    mov rsi, number
    mov rdx, 4
    syscall
    
    mov rax, 60
    mov rdi, 0
    syscall

erreur:
    mov rax, 60
    mov rdi, 1
    syscall
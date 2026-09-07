section .bss
    saisie_utilisateur resb 8

section .text
global _start

_start:

    mov rax, 0
    mov rdi, 0
    mov rsi, saisie_utilisateur
    mov rdx, 8
    syscall

    mov al, [rsi]
    cmp al, '1'
    jb  not_a_number
    cmp al, '9'
    ja  not_a_number

    mov al, [rsi]
    cmp al, '2'
    je even

    mov al, [rsi]
    cmp al, '4'
    je even

    mov al, [rsi]
    cmp al, '6'
    je even

    mov al, [rsi]
    cmp al, '8'
    je even

    mov al, [rsi]
    cmp al, '1'
    je odd

    mov al, [rsi]
    cmp al, '3'
    je odd

    mov al, [rsi]
    cmp al, '5'
    je odd

    mov al, [rsi]
    cmp al, '7'
    je odd

    mov al, [rsi]
    cmp al, '9'
    je odd
    
even:
    mov rax, 60
    mov rdi, 0
    syscall


odd:
    mov rax, 60
    mov rdi, 1
    syscall


not_a_number:
    mov rax, 60
    mov rdi, 2
    syscall
section .bss
    valeur resb 3

section .text
global _start
_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, valeur
    mov rdx, 3
    syscall

    mov al, [valeur]
    cmp al, '-'
    je negatif

    jmp check_valeur

negatif:
    mov al, [valeur + 1]

check_valeur:
    cmp al, '0'
    jb not_a_number
    cmp al, '9'
    ja not_a_number

    cmp al, '0'
    je even
    cmp al, '2'
    je even
    cmp al, '4'
    je even
    cmp al, '6'
    je even
    cmp al, '8'
    je even
    cmp al, '1'
    je odd
    cmp al, '3'
    je odd
    cmp al, '5'
    je odd
    cmp al, '7'
    je odd
    cmp al, '9'
    je odd

    jmp not_a_number

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
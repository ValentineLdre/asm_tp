section .bss
    saisie_utilisateur resb 6

section .data
number db "1337"

section .text
global _start

_start:

    mov rax, 0
    mov rdi, 0
    mov rsi, saisie_utilisateur
    mov rdx, 6
    syscall

    mov al, [saisie_utilisateur]
    cmp al, '4'
    jne erreur

    mov al, [saisie_utilisateur + 1]
    cmp al, '2'
    jne erreur

    mov al, [saisie_utilisateur + 2]
    cmp al, ''
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
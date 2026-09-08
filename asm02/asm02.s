section .bss
    saisie_utilisateur resb 8

section .data
number db "1337", 10

section .text
global _start

_start:

    mov rax, 0
    mov rdi, 0
    mov rsi, saisie_utilisateur
    mov rdx, 8
    syscall

    mov al, [saisie_utilisateur]
    cmp al, '4'
    jne erreur

    mov al, [saisie_utilisateur + 1]
    cmp al, '2'
    jne erreur

    mov al, [saisie_utilisateur + 2]
    cmp al, '1'
    je erreur

    mov al, [saisie_utilisateur + 2]
    cmp al, '2'
    je erreur

    mov al, [saisie_utilisateur + 2]
    cmp al, '3'
    je erreur

    mov al, [saisie_utilisateur + 2]
    cmp al, '4'
    je erreur

    mov al, [saisie_utilisateur + 2]
    cmp al, '5'
    je erreur

    mov al, [saisie_utilisateur + 2]
    cmp al, '6'
    je erreur

    mov al, [saisie_utilisateur + 2]
    cmp al, '7'
    je erreur

    mov al, [saisie_utilisateur + 2]
    cmp al, '8'
    je erreur

    mov al, [saisie_utilisateur + 2]
    cmp al, '9'
    je erreur

    mov rax, 1
    mov rdi, 1
    mov rsi, number
    mov rdx, 5
    syscall
    
    mov rax, 60
    mov rdi, 0
    syscall

erreur:
    mov rax, 60
    mov rdi, 1
    syscall
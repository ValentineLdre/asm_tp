section .data
    saisie_texte db 100 dup(0)

section .text
global _start

_start:

    mov rax, 0
    mov rdi, 0
    mov rsi, saisie_texte
    mov rdx, 100
    syscall
    
    mov rax, 1
    mov rdi, 1
    mov rsi, saisie_texte
    mov rdx, 100
    syscall
    
    mov rax, 60
    mov rdi, 0
    syscall
section .data
    saisie_texte db "Hello, Universe!"

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
section .text
global _start


_start:
    mov rsi, [rsp + 16]
    mov rcx, 0

    
boucle_longueur:
    cmp byte [rsi+rcx], 0
    je  fin_longueur
    inc rcx
    jmp boucle_longueur

    
fin_longueur:
    mov rax, 1
    mov rdi, 1
    mov rdx, rcx
    syscall

    mov rax, 60
    mov rdi, 0
    syscall
section .bss
    buffer resb 22

section .text
global _start

_start:
    mov rax, 0
    mov rdi, 0
    lea rsi, [rel buffer]
    mov rdx, 22
    syscall

    cmp rax, 0
    jle sortie_nombre_invalide
    cmp rax, 22
    jae sortie_nombre_invalide

    mov r14, rax
    lea rsi, [rel buffer]

verifier_fin_ligne:
    cmp byte [rsi + r14 - 1], 10
    jne verifier_retour_chariot
    dec r14

verifier_retour_chariot:
    cmp r14, 0
    je sortie_nombre_invalide
    cmp byte [rsi + r14 - 1], 13
    jne convertir_nombre
    dec r14

convertir_nombre:
    mov rdi, rsi
    xor rax, rax
    xor r8, r8

    movzx rcx, byte [rdi]
    cmp cl, '-'
    jne verifier_signe_positif
    mov r8, 1
    inc rdi
    jmp verifier_nombre_vide

verifier_signe_positif:
    cmp cl, '+'
    jne verifier_nombre_vide
    inc rdi

verifier_nombre_vide:
    lea rsi, [rel buffer + r14]
    cmp rdi, rsi
    jae sortie_nombre_invalide

lire_chiffres:
    cmp rdi, rsi
    jae verifier_nombre_converti

    movzx rcx, byte [rdi]
    sub rcx, '0'
    cmp rcx, 9
    ja sortie_nombre_invalide

    imul rax, rax, 10
    jo sortie_nombre_invalide

    sub rax, rcx
    jo sortie_nombre_invalide

    inc rdi
    jmp lire_chiffres

verifier_nombre_converti:
    cmp r8, 1
    je verifier_nombre_premier

    neg rax
    jo sortie_nombre_invalide

verifier_nombre_premier:
    cmp rax, 2
    jl sortie_nombre_non_premier

    je sortie_nombre_premier

    mov r12, rax

    test r12, 1
    jz sortie_nombre_non_premier

    mov rbx, 3

tester_diviseurs:
    mov rax, r12
    xor rdx, rdx
    div rbx

    cmp rbx, rax
    ja sortie_nombre_premier

    cmp rdx, 0
    je sortie_nombre_non_premier

    add rbx, 2
    jmp tester_diviseurs

sortie_nombre_premier:
    mov rax, 60
    mov rdi, 0
    syscall

sortie_nombre_non_premier:
    mov rax, 60
    mov rdi, 1
    syscall

sortie_nombre_invalide:
    mov rax, 60
    mov rdi, 2
    syscall

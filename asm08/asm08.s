section .bss
    buffer resb 42

section .text
global _start

_start:
    mov rax, [rsp]
    cmp rax, 2
    jne sortie_mauvais_args

convertir_nombre:
    mov rdi, [rsp + 16]
    xor rax, rax
    xor r8, r8

    movzx rcx, byte [rdi]
    cmp cl, '-'
    jne verifier_signe_positif
    mov r8, 1
    inc rdi
    jmp verifier_non_vide

verifier_signe_positif:
    cmp cl, '+'
    jne verifier_non_vide
    inc rdi

verifier_non_vide:
    cmp byte [rdi], 0
    je sortie_nombre_invalide

lire_chiffres:
    movzx rcx, byte [rdi]
    cmp rcx, 0
    je appliquer_signe

    sub rcx, '0'
    cmp rcx, 9
    ja sortie_nombre_invalide

    imul rax, rax, 10
    jo sortie_nombre_invalide

    sub rax, rcx
    jo sortie_nombre_invalide

    inc rdi
    jmp lire_chiffres

appliquer_signe:
    cmp r8, 1
    je calculer_somme

    neg rax
    jo sortie_nombre_invalide

calculer_somme:
    cmp rax, 1
    jle somme_nulle

    mov rcx, rax
    dec rcx

    test rax, 1
    jz diviser_nombre

    shr rcx, 1
    jmp multiplier_nombre

diviser_nombre:
    shr rax, 1

multiplier_nombre:
    mul rcx

    mov r12, rdx
    mov r13, rax

    jmp preparer_affichage

somme_nulle:
    xor r12, r12
    xor r13, r13

preparer_affichage:
    lea rdi, [rel buffer + 41]
    mov byte [rdi], 10

    mov rbx, 10

extraire_chiffres:
    mov rax, r12
    xor rdx, rdx
    div rbx

    mov r12, rax

    mov rax, r13
    div rbx

    mov r13, rax

    add dl, '0'
    dec rdi
    mov byte [rdi], dl

    cmp r12, 0
    jne extraire_chiffres

    cmp r13, 0
    jne extraire_chiffres

ecrire_resultat:
    mov rsi, rdi
    lea rdx, [rel buffer + 42]
    sub rdx, rsi

    mov rax, 1
    mov rdi, 1
    syscall

sortie_succes:
    mov rax, 60
    mov rdi, 0
    syscall

sortie_nombre_invalide:
    mov rax, 60
    mov rdi, 1
    syscall

sortie_mauvais_args:
    mov rax, 60
    mov rdi, 2
    syscall

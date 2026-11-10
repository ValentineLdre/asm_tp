section .bss
    buffer resb 66

section .text
global _start

_start:
    mov rax, [rsp]
    cmp rax, 2
    je verifier_option_par_defaut
    cmp rax, 3
    je verifier_option_binaire
    jmp sortie_mauvais_args

verifier_option_par_defaut:
    mov rdi, [rsp + 16]
    cmp byte [rdi], '-'
    jne convertir_hexadecimal
    cmp byte [rdi + 1], 'b'
    jne convertir_hexadecimal
    cmp byte [rdi + 2], 0
    je sortie_mauvais_args
    jmp convertir_hexadecimal

verifier_option_binaire:
    mov rdi, [rsp + 16]
    cmp byte [rdi], '-'
    jne sortie_mauvais_args
    cmp byte [rdi + 1], 'b'
    jne sortie_mauvais_args
    cmp byte [rdi + 2], 0
    jne sortie_mauvais_args

    mov r15, 2
    mov rdi, [rsp + 24]
    jmp convertir_nombre

convertir_hexadecimal:
    mov r15, 16
    mov rdi, [rsp + 16]

convertir_nombre:
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
    je verifier_nombre_negatif

    neg rax
    jo sortie_nombre_invalide

    xor r9, r9
    jmp preparer_conversion

verifier_nombre_negatif:
    cmp rax, 0
    je nombre_zero

    mov r9, 1
    neg rax
    jmp preparer_conversion

nombre_zero:
    xor r9, r9

preparer_conversion:
    lea rdi, [rel buffer + 65]
    mov byte [rdi], 10

extraire_chiffres:
    xor rdx, rdx
    div r15

    cmp rdx, 9
    ja ajouter_lettre

    add dl, '0'
    jmp sauvegarder_chiffre

ajouter_lettre:
    add dl, 'A' - 10

sauvegarder_chiffre:
    dec rdi
    mov [rdi], dl

    cmp rax, 0
    jne extraire_chiffres

    cmp r9, 1
    jne ecrire_resultat

    dec rdi
    mov byte [rdi], '-'

ecrire_resultat:
    mov rsi, rdi
    lea rdx, [rel buffer + 66]
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

section .bss
    buffer resb 21

section .text
global _start

_start:
    mov rax, [rsp]
    cmp rax, 3
    jne sortie_mauvais_args

convertir_premier:
    mov rdi, [rsp + 16]
    mov rax, 0
    mov r8, 0
    movzx rcx, byte [rdi]
    cmp cl, '-'
    jne verifier_non_vide_1
    mov r8, 1
    inc rdi

verifier_non_vide_1:
    cmp byte [rdi], 0
    je sortie_nombre_invalide

lire_chiffres_1:
    movzx rcx, byte [rdi]
    cmp rcx, 0
    je appliquer_signe_1
    sub rcx, '0'
    cmp rcx, 9
    ja sortie_nombre_invalide
    imul rax, rax, 10
    jo sortie_nombre_invalide
    sub rax, rcx
    jo sortie_nombre_invalide
    inc rdi
    jmp lire_chiffres_1

appliquer_signe_1:
    cmp r8, 1
    je sauvegarder_premier
    neg rax
    jo sortie_nombre_invalide

sauvegarder_premier:
    mov rbx, rax

convertir_second:
    mov rdi, [rsp + 24]
    mov rax, 0
    mov r8, 0
    movzx rcx, byte [rdi]
    cmp cl, '-'
    jne verifier_non_vide_2
    mov r8, 1
    inc rdi

verifier_non_vide_2:
    cmp byte [rdi], 0
    je sortie_nombre_invalide

lire_chiffres_2:
    movzx rcx, byte [rdi]
    cmp rcx, 0
    je appliquer_signe_2
    sub rcx, '0'
    cmp rcx, 9
    ja sortie_nombre_invalide
    imul rax, rax, 10
    jo sortie_nombre_invalide
    sub rax, rcx
    jo sortie_nombre_invalide
    inc rdi
    jmp lire_chiffres_2

appliquer_signe_2:
    cmp r8, 1
    je additionner
    neg rax
    jo sortie_nombre_invalide

additionner:
    add rax, rbx
    jo sortie_nombre_invalide

preparer_affichage:
    lea rdi, [buffer + 20]
    mov byte [rdi], 10
    mov r8, rax
    mov rcx, 10
    cmp rax, 0
    jge extraire_chiffres
    neg rax

extraire_chiffres:
    mov rdx, 0
    div rcx
    add dl, '0'
    dec rdi
    mov [rdi], dl
    cmp rax, 0
    jne extraire_chiffres

    cmp r8, 0
    jge ecrire_resultat
    dec rdi
    mov byte [rdi], '-'

ecrire_resultat:
    mov rsi, rdi
    mov rdx, buffer + 21
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

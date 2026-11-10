section .bss
    buffer resb 22

section .text
global _start

_start:
    mov rax, [rsp]
    cmp rax, 4
    jne sortie_mauvais_args

    mov r12, [rsp + 16]
    mov r13, [rsp + 24]
    mov r14, [rsp + 32]

convertir_premier_nombre:
    mov rdi, r12
    call convertir_nombre
    mov rbx, rax

convertir_deuxieme_nombre:
    mov rdi, r13
    call convertir_nombre
    cmp rax, rbx
    jle convertir_troisieme_nombre
    mov rbx, rax

convertir_troisieme_nombre:
    mov rdi, r14
    call convertir_nombre
    cmp rax, rbx
    jle preparer_affichage
    mov rbx, rax

preparer_affichage:
    lea rdi, [rel buffer + 21]
    mov byte [rdi], 10

    mov rax, rbx
    xor r9, r9

    cmp rax, 0
    jge convertir_nombre_positif

    mov r9, 1
    jmp extraire_chiffres

convertir_nombre_positif:
    neg rax

extraire_chiffres:
    cqo
    mov rcx, 10
    idiv rcx

    neg rdx
    add dl, '0'

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
    lea rdx, [rel buffer + 22]
    sub rdx, rsi

    mov rax, 1
    mov rdi, 1
    syscall

sortie_succes:
    mov rax, 60
    mov rdi, 0
    syscall

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
    je retour_nombre_converti

    neg rax
    jo sortie_nombre_invalide

retour_nombre_converti:
    ret

sortie_nombre_invalide:
    mov rax, 60
    mov rdi, 1
    syscall

sortie_mauvais_args:
    mov rax, 60
    mov rdi, 2
    syscall

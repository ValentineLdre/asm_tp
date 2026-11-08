
section .bss
    caractere resb 1

section .text
global _start

_start:
    xor r8, r8
    xor r9, r9
    xor r12, r12
    xor r14, r14

lecture:
    xor eax, eax
    xor edi, edi
    lea rsi, [rel caractere]
    mov edx, 1
    syscall

    test rax, rax
    js not_a_number
    jz fin_nombre

    mov al, [rel caractere]

    cmp al, 10
    je fin_nombre

    cmp al, '-'
    jne signe_positif

    cmp r14, 0
    jne not_a_number

    mov r9, 1
    mov r14, 1
    jmp lecture

signe_positif:
    cmp al, '+'
    jne check_valeur

    cmp r14, 0
    jne not_a_number

    mov r14, 1
    jmp lecture

check_valeur:
    cmp al, '0'
    jb not_a_number

    cmp al, '9'
    ja not_a_number

    mov r14, 1

    movzx r10, al
    sub r10, '0'

    mov rax, 922337203685477580

    cmp r8, rax
    ja not_a_number
    jb calcul

    cmp r9, 1
    je limite_negative

    cmp r10, 7
    ja not_a_number
    jmp calcul

limite_negative:
    cmp r10, 8
    ja not_a_number

calcul:
    imul r8, r8, 10
    add r8, r10

    inc r12
    jmp lecture

fin_nombre:
    cmp r12, 0
    je not_a_number

    test r8, 1
    jz even

    jmp odd

even:
    mov eax, 60
    xor edi, edi
    syscall

odd:
    mov eax, 60
    mov edi, 1
    syscall

not_a_number:
    mov eax, 60
    mov edi, 2
    syscall

section .bss
    valeur resb 21

section .text
global _start

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, valeur
    mov rdx, 21
    syscall

    cmp rax, 0
    jle not_a_number

    mov rcx, rax
    mov rsi, valeur
    mov r8, 0
    mov r9, 0
    mov r12, 0

    mov al, [rsi]
    cmp al, '-'
    je negatif

    jmp check_valeur

negatif:
    mov r9, 1
    inc rsi
    dec rcx

check_valeur:
    cmp rcx, 0
    je fin_nombre

    mov al, [rsi]
    cmp al, 10
    je fin_ligne

    cmp al, '0'
    jb not_a_number
    cmp al, '9'
    ja not_a_number

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
    mov r11, r10
    inc r12
    inc rsi
    dec rcx
    jmp check_valeur

fin_ligne:
    cmp rcx, 1
    jne not_a_number
    jmp fin_nombre

fin_nombre:
    cmp r12, 0
    je not_a_number

    cmp r11, 0
    je even
    cmp r11, 2
    je even
    cmp r11, 4
    je even
    cmp r11, 6
    je even
    cmp r11, 8
    je even

    cmp r11, 1
    je odd
    cmp r11, 3
    je odd
    cmp r11, 5
    je odd
    cmp r11, 7
    je odd
    cmp r11, 9
    je odd

    jmp not_a_number

even:
    mov rax, 60
    mov rdi, 0
    syscall

odd:
    mov rax, 60
    mov rdi, 1
    syscall

not_a_number:
    mov rax, 60
    mov rdi, 2
    syscall

section .data
    msg1 db 10, "numero #1 ===> ", 0
    msg2 db 10, "numero #2 ===> ", 0
    msg3 db 10, "numero #3 ===> ", 0
    msg_result db 10, "Valor minimo => ", 0
    newline db 10, 0
    error_msg db 10, "Numeros repetidos. Fin del programa.", 10, 0

section .bss
    num1 resb 1
    num2 resb 1
    num3 resb 1
    temp resb 1

section .text
    global _start

_start:
    ; pedir num1
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, 18
    int 0x80
    call read_digit
    sub al, '0'              ; convertir a valor numérico
    mov [num1], al

    ; pedir num2
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, 18
    int 0x80
    call read_digit
    sub al, '0'              ; convertir a valor numérico
    mov [num2], al

    ; pedir num3
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, 18
    int 0x80
    call read_digit
    sub al, '0'              ; convertir a valor numérico
    mov [num3], al

    ; verificar si hay duplicados
    mov al, [num1]
    cmp al, [num2]
    je duplicated
    cmp al, [num3]
    je duplicated
    mov al, [num2]
    cmp al, [num3]
    je duplicated

    ; encontrar el mínimo
    mov al, [num1]
    mov bl, [num2]
    cmp al, bl
    jbe check13
    mov al, bl

check13:
    mov bl, [num3]
    cmp al, bl
    jbe print_min
    mov al, bl

print_min:
    ; imprimir mensaje
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_result
    mov edx, 20
    int 0x80

    ; convertir a ASCII para imprimir
    add al, '0'
    mov [temp], al

    ; imprimir valor mínimo
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 0x80

    ; salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; salir
    mov eax, 1
    xor ebx, ebx
    int 0x80

duplicated:
    mov eax, 4
    mov ebx, 1
    mov ecx, error_msg
    mov edx, 40
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80

; -------------------------------
; subrutina: read_digit (lee 1 dígito y consume el ENTER)
; -------------------------------
read_digit:
    ; leer un carácter
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 0x80

    ; guardar en AL
    mov al, [temp]

    ; leer y descartar el ENTER
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 0x80
    ret

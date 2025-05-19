section .data
    mat db 9, 9, 9, 9, 9, 9, 9, 9, 9       ; Matriz de 3x3
    prompt db "Pos [", 0
    msg db "] --> ", 0
    newline db 10, 0

section .bss
    num resb 1          ; Número ingresado
    pos resb 1          ; Índice actual en matriz
    buffer resb 2       ; Buffer de entrada
    char_out resb 1     ; Para impresión de un solo carácter

section .text
    global _start

_start:
    mov byte [pos], 0

inicio:
    ; Verificamos si ya ingresamos 9 datos
    mov al, [pos]
    cmp al, 9
    jge fin             ; Salir si pos >= 9

    ; Imprimir "Pos ["
    mov edx, prompt
    call PrintString

    ; Imprimir la posición actual
    mov al, [pos]
    call PrintNum

    ; Imprimir "] -->"
    mov edx, msg
    call PrintString

    ; Leer número
    call ScanNum

    cmp al, 0
    je siguiente

    ; Guardar en la matriz
    movzx ebx, byte [pos]
    mov [mat + ebx], al

    inc byte [pos]      ; Siguiente posición

    ; Salto de línea
    mov edx, newline
    call PrintString

siguiente:
    jmp inicio          ; Repetir

fin:
    ; Salida
    mov eax, 1
    xor ebx, ebx
    int 0x80

; ---------------------------
PrintString:
    push edx
    mov ecx, edx
    call StrLen
    mov edx, eax
    mov eax, 4
    mov ebx, 1
    int 0x80
    pop edx
    ret

PrintNum:
    add al, '0'
    mov [char_out], al
    mov eax, 4
    mov ebx, 1
    mov ecx, char_out
    mov edx, 1
    int 0x80
    ret

ScanNum:
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 2
    int 0x80
    mov al, [buffer]
    sub al, '0'         ; Convertir ASCII a número
    ret

StrLen:
    xor eax, eax
.next:
    cmp byte [ecx + eax], 0
    je .done
    inc eax
    jmp .next
.done:
    ret

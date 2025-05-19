section .data
    msg1 db 10,10,'LEE SEIS DIGITOS Y LOS INSERTA EN EL STACK',10,0
    msg2 db 'LUEGO LOS EXTRAE EN EL ORDEN LIFO',10,0
    msg3 db 'ingresa valor unario (0 <= x <= 9) ---> ',0
    msg4 db 10,'impresion de datos:',10,0
    newline db 10,0

section .bss
    stack resb 6
    temp  resb 1
    buffer resb 1
    counter resb 1

section .text
    global _start

_start:
    ; imprime msg1
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, 50
    int 0x80

    ; imprime msg2
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, 40
    int 0x80

    mov esi, stack
    mov byte [counter], 6

leer_digito:
    ; imprimir prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, 40
    int 0x80

    ; leer caracter
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 1
    int 0x80

    ; validar si es un digito (0..9)
    mov al, [buffer]
    cmp al, '0'
    jb leer_digito
    cmp al, '9'
    ja leer_digito
    mov [esi], al
    inc esi
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 0x80
    dec byte [counter]
    cmp byte [counter], 0
    jne leer_digito

    ; imprimir 
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, 30
    int 0x80
    mov esi, stack
    add esi, 5
    mov ecx, 6

imprimir_digito:
    mov al, [esi]
    mov [buffer], al

    ; imprimir
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 1
    int 0x80

    dec esi
    loop imprimir_digito
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; salir
    mov eax, 1
    xor ebx, ebx
    int 0x80

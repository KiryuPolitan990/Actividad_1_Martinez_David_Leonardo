section .data
    msg_inicio db 10, 'Inicia captura ...', 10, 0
    msg_fin    db 10, 'Fin captura ...', 10, 0
    buffer     times 128 db 0   

section .bss


section .text
    global _start

_start:
    ; Imprimir mensaje inicial
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_inicio
    mov edx, 21
    int 0x80

leer_loop:
    ; Leer un carácter del teclado
    mov eax, 3        
    mov ebx, 0        ;
    mov ecx, buffer  
    mov edx, 1       
    int 0x80

    ; Comparar si es Enter (ASCII 10 en Linux)
    mov al, [buffer]
    cmp al, 10     
    jne leer_loop   

    ; Imprimir mensaje final
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_fin
    mov edx, 20
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

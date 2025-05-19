section .data
    msg db "Resultado: ", 0
    buffer db 10 dup(0)      

section .bss
    ; No usado en este ejemplo

section .text
    global _start

_start:
    ; --- Sumar dos números ---
    mov eax, 5              
    add eax, 7              

.convertir:
    xor edx, edx
    mov ebx, 10
    div ebx              
    add dl, '0'         
    mov [ecx], dl
    dec ecx
    test eax, eax
    jnz .convertir
    inc ecx                 

    ; Mostrar "Resultado: " 
    mov eax, 4           
    mov ebx, 1          
    mov ecx, msg          
    mov edx, 10       
    int 0x80

    ; --- Mostrar número ---
    mov eax, 4
    mov ebx, 1
    mov edx, buffer + 10
    sub edx, ecx         
    int 0x80

    ; --- Salir ---
    mov eax, 1             
    xor ebx, ebx
    int 0x80

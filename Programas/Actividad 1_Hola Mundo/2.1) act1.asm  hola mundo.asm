section .data
    mensaje db 'Hola mundo', 0xA  ; El mensaje con salto de línea al final
    longitud equ $ - mensaje      ; Calcula la longitud del mensaje

section .text
    global _start

_start:

    mov eax, 4         
    mov ebx, 1        
    mov ecx, mensaje  
    mov edx, longitud  
    int 0x80           
    mov eax, 1        
    xor ebx, ebx      
    int 0x80

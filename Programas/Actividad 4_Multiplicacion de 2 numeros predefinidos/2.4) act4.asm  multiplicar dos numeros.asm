section .data
    msg db "Resultado: ", 0
    buffer db 10 dup(0)   

section .text
    global _start

_start:
    ;Multiplicación
    mov eax, 6    
    mov ebx, 7        
    mul ebx             

    ;Convertir resultado a texto 
    mov ecx, buffer + 9   
    mov byte [ecx], 0xA   
    dec ec

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

    ;Imprimir "Resultado: "
    mov eax, 4          
    mov ebx, 1            
    mov ecx, msg
    mov edx, 10             
    int 0x80

    ;Imprimir número convertid
    mov eax, 4
    mov ebx, 1
    mov edx, buffer + 10
    sub edx, ecx
    int 0x80

    ; Salida limpia
    mov eax, 1             
    xor ebx, ebx
    int 0x80

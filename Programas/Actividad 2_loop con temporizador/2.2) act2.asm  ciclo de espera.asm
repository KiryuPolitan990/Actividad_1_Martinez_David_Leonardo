section .data
    mensaje1 db 10,10,"Ingresa al ciclo de espera del temporizador",10,0
    mensaje2 db "Salir del temporizador, termine !!",10,0

section .text
    global _start

_start:

    ; Imprimir mensaje1
    mov eax, 4      
    mov ebx, 1          
    mov ecx, mensaje1   
    mov edx, 42        
    int 0x80

    ; Ciclo de espera
    mov ecx, 0x400
ciclo:
    nop
    loop ciclo

    ; Imprimir mensaje2
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje2
    mov edx, 34         
    int 0x80

    ; Salir del programa
    mov eax, 1          
    xor ebx, ebx        
    int 0x80
     

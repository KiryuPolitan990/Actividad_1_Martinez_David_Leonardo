section .data
    var1 db 10,10, '** el valor unario es par o no **', 10,10, '$'
    var2 db 10,10, 'digite el numero  ==>  ', '$'
    var3 db 10,10, 'el valor es par', 10,10, '$'
    var4 db 10,10, 'el valor impar', 10,10, '$'
    var5 db 10,10, 'numerador igual a cero', 10,10, '$'

section .bss
    base resb 1
    buffer resb 1

section .text
    global _start

_start:
  
    mov eax, 4          
    mov ebx, 1            
    mov ecx, var1       
    mov edx, 70          
    int 0x80            

    ; Solicitar entrada del usuario
    mov eax, 4
    mov ebx, 1
    mov ecx, var2
    mov edx, 25
    int 0x80

    ; Capturar el valor 
    mov eax, 3           
    mov ebx, 0            
    mov ecx, buffer     
    mov edx, 1          
    int 0x80

    ; Validar si el valor está en el rango 0-9
    mov al, [buffer]
    cmp al, '0'           
    jb captura_invalida  
    cmp al, '9'           
    ja captura_invalida  

    sub al, '0'           

    ; Evaluar si el número es 0
    cmp al, 0
    je numerador_cero

    ; Evaluar si el número es par o impar
    test al, 1           
    jz es_par
    jmp es_impar

es_par:
    ; Imprimir el mensaje para número par
    mov eax, 4
    mov ebx, 1
    mov ecx, var3
    mov edx, 25
    int 0x80
    jmp salir

es_impar:
    ; Imprimir el mensaje para número impar
    mov eax, 4
    mov ebx, 1
    mov ecx, var4
    mov edx, 25
    int 0x80
    jmp salir

numerador_cero:
    ; Imprimir mensaje para número 0
    mov eax, 4
    mov ebx, 1
    mov ecx, var5
    mov edx, 25
    int 0x80
    jmp salir

captura_invalida:
    ; Si el número no es válido, simplemente salir sin hacer nada
    jmp salir

salir:
    ; Salir del programa
    mov eax, 1            
    xor ebx, ebx          
    int 0x80              

section .bss
    input resb 10         
    buffer resb 10       

section .data
    prompt db "Ingrese un numero: ", 0
    newline db 0xA
    resultado_msg db "Factorial: ", 0

section .text
    global _start

_start:
    ; Mostrar prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 18
    int 0x80

    ;Leer entrada
    mov eax, 3         
    mov ebx, 0        
    mov ecx, input
    mov edx, 10
    int 0x80

    ; Convertir ASCII a número
    mov ecx, input
    xor eax, eax        
    xor ebx, ebx

.next_digit:
    mov bl, [ecx]
    cmp bl, 0xA   
    je .done_input
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc ecx
    jmp .next_digit

.done_input:
    ; EAX contiene el número ingresado

    mov ecx, eax        
    mov ebx, eax       
    dec ebx            

.factorial_loop:
    cmp ebx, 1
    jl .factorial_done
    imul ecx, ebx    
    dec ebx
    jmp .factorial_loop

.factorial_done:
   
    
    ;Convertir resultado a texto
    mov eax, ecx        
    mov edi, buffer + 9
    mov byte [edi], 0xA
    dec edi

.convert_loop:
    xor edx, edx
    mov ebx, 10
    div ebx
    add dl, '0'
    mov [edi], dl
    dec edi
    test eax, eax
    jnz .convert_loop
    inc edi

    ; --- Mostrar mensaje "Factorial: " ---
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado_msg
    mov edx, 11
    int 0x80

    ; --- Mostrar número ---
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, buffer + 10
    sub edx, ecx
    int 0x80

    ; --- Salir ---
    mov eax, 1
    xor ebx, ebx
    int 0x80

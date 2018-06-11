%include "io.inc"

section .data
    msg: db 'Escolha o tipo de calculo de area, triangulo(1), retangulo(2) ou trapezio(3):', 10, 0
    msg1: db 'Area do triangulo e: %d', 10, 0
    msg1.a: db 'Digite a base do triangulo:', 10, 0
    msg1.b: db 'Digite a altura do triangulo:', 10, 0
    msg2: db 'Area do retangulo e: %d', 10, 0
    msg2.a: db 'Digite a base do retangulo:', 10, 0
    msg2.b: db 'Digite a altura do retangulo:', 10, 0
    msg3: db 'Area do trapezio e: %d', 10, 0   
    msg3.a: db 'Digite a base maior do trapezio:', 10, 0
    msg3.b: db 'Digite a base menor do trapezio:', 10, 0
    msg3.c: db 'Digite a altura do trapezio:', 10, 0     
    formatin: db "%d", 0
    usrinput: times 4 db 0 ; 32-bits integer = 4 bytes
    base: times 4 db 0 ; 32-bits integer = 4 bytes
    base_maior: times 4 db 0 ; 32-bits integer = 4 bytes
    altura: times 4 db 0 ; 32-bits integer = 4 bytes
    area: times 4 db 0 ; 32-bits integer = 4 bytes
    resultado: times 4 db 0 ; 32-bits integer = 4 bytes
    msgfim: db "Aperte 1  para terminar",10,0
    
section .text
    extern scanf
    extern printf
    global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging

    ;Pedindo que o usuario digite um numero
    push msg
    call printf
    add esp, 4
    ;Armazenando o numero digitado na variavel usrinput
    push usrinput
    push formatin
    call scanf
    add esp, 8
    ;Acessando o valor da variavel, para comp.
    mov ebx, [usrinput]
    ;Comparando o valor da variavel com as opções.
    cmp ebx, 1
    ;Se o valor digitado pelo usuario for igual a 1, va para o bloco if_block
    je if_block
    ;Caso a variavel tenha valor diferente de 1, va para o bloco else_block
    jmp else_block
    
    if_block:
            ;Se o usuario digitar 1, o bloco corrente sera executado.
            ;e exibira o calculo de area do triangulo.
          
            push msg1.a
            call printf
            add esp, 4
            
            push base
            push formatin
            call scanf
            add esp, 8
            
            push msg1.b
            call printf
            add esp, 4
            
            push altura
            push formatin
            call scanf
            add esp, 8 
            
            call TRIANGULO
            
            mov eax,[area]
            
            push eax            
            push msg1
            call printf
            add esp, 8
            
             
            ;Como o bloco else_block nao deve ser executado, fazemos um salto para o end_if.
            jmp end_if
            
        else_block:
                ;Comparando o valor da variavel com as opções.
                cmp ebx, 2
                ;Se o valor digitado pelo usuario for igual a 2, va para o bloco if1_block
                je if1_block
                ;Caso a variavel tenha valor diferente de 2, va para o bloco else1_block
                jmp else1_block
                
            if1_block:
                    ;Se o usuario digitar 2, o bloco corrente sera executado.
                    ;e exibira o calculo de area do retangulo.
                    push msg2.a
                    call printf
                    add esp, 4
                    
                    push base
                    push formatin
                    call scanf
                    add esp, 8
                    
                    push msg2.b
                    call printf
                    add esp, 4
                    
                    push altura
                    push formatin
                    call scanf
                    add esp, 8
                    
                    call RETANGULO
                    
                    mov eax, [area]
                    
                    push eax
                    push msg2
                    call printf
                    add esp, 8
                    
                    ;Como o bloco else1_block nao deve ser executado, fazemos um salto para o end_if.
                    jmp end_if
                else1_block:
                        push msg3.a
                        call printf
                        add esp, 4
                        
                        push base_maior
                        push formatin
                        call scanf
                        add esp, 8
                        
                        push msg3.b
                        call printf
                        add esp, 4
                        
                        push base
                        push formatin
                        call scanf
                        add esp, 8
                        
                        push msg3.c
                        call printf
                        add esp, 4
                        
                        push altura
                        push formatin
                        call scanf
                        add esp, 8
                        
                        call TRAPEZIO
                        
                        mov eax, [area]
                        
                        push eax
                        push msg3
                        call printf
                        add esp, 8
                       
                        ;Ao finalizar esse bloco, fazemos o salto para o end_if
                        jmp end_if
                    end_if:
                    
                    push msgfim
                    call printf
                    add esp, 4
                    
                    push altura
                    push formatin
                    call scanf
                    add esp, 8
                    ret                
TRIANGULO:
    mov eax, [base]
    mov ecx, [altura]
    mul ecx; eax = eax * ecx
    mov [resultado], eax
    mov ebx, 2
    div ebx
    mov [area], eax
    ret
        
RETANGULO:
    mov eax, [base]
    mov ebx, [altura]
    mul ebx
    mov [area], eax
    ret
    
TRAPEZIO:
; (bmaior + bmenor) * alt / 2
    mov eax, [base_maior]
    mov ebx, [base]
    add eax, ebx; eax = (bmaior + bmenor)
    mov ecx, [altura]; 
    mul ecx; eax = (bmaior + bmenor)* altura
    mov ecx, 2
    div ecx; eax = eax /2
    mov [area], eax
    ret
    
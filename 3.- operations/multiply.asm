;multiply.asm
;prints multiplication of numbers in args.
;author: Erick
;date: 2017/03/27

%include '../2.- functions/functions.asm'

section .text
    GLOBAL _start

_start:
    pop ecx                                          ;get number of args
    pop eax                                          ;remove first arg (name of executable)
    dec ecx                                          ;decrement ecx by 1
    mov ebx, 1h                                      ;initialize multiplication in 1

cycle:
    pop eax                                          ; get args    
    call atoi                                        ; ascii to integer function
    imul ebx, eax	                                 ; adds

    dec ecx                                          ; Substract 1 to the number of arguments
    cmp ecx,0                                        ; Checks if there are no more arguments
    jnz cycle                                        ; Repeat if not last

    mov eax, ebx
    call iprintLF                                    ; Prints the sum

    jmp quit
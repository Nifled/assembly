;multiply2.asm
;prints multiplication of ONLY first 2 numbers (args)
;author: Erick
;date: 2017/03/27

%include '../2.- functions/functions.asm'

section .text
    GLOBAL _start

_start:
    pop ecx                                          ;get # of args

    cmp ecx, 3                                       ;compare args to 3 (there should only be 2)
    jl quit                                          ;jump if less

    pop eax                                          ;pops name of program (first arg)

    pop eax                                          ;get first arg
    call atoi                                        ;convert 1st arg

    mov ebx, eax                                     ;save 1st arg

    pop eax                                          ;get next number (arg)
    call atoi                                        ;convert
    
    imul eax, ebx                                    ;multiply

    call iprintLF                                    ;print result
    jmp quit
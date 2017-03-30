;ftoc.asm
;converts fahrenheit to celsius
;2017/03/30

%include '../2.- functions/functions.asm'

section .text
    GLOBAL _start

_start:
    pop ecx                                          ;gets # of args

    cmp ecx, 2                                       ;compare args to 1 (make sure at least 1 number is arg)
    jl quit                                          ;jump if less

    pop eax                                          ;remove first arg
    dec ecx                                          ;decrement ecx by 1

cycle:
    pop eax                                          ;get arg
    dec ecx                                          ;Substract 1 to the number of arguments

    call atoi                                        ;ascii to integer function
    call ftoc                                        ;converts
    call iprintLF                                    ;Prints the converted
    
    cmp ecx,0                                        ;Checks if there are no more arguments
    jnz cycle                                        ;Repeat if not last

    jmp quit
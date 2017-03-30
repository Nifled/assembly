;sum_args.asm
;prints total sum of numbers in args.
;author: Erick
;date: 2017/03/28

%include '../2.- functions/functions.asm'

section .text
    GLOBAL _start

_start:
    pop ecx                                          ;gets # of args

    cmp ecx, 2                                       ;compare args to 1 (make sure at least 1 number is arg)
    jl quit                                          ;jump if less

cycle:
    pop eax                                          ; get args    
    call atoi                                        ; ascii to integer function
    add ebx, eax	                                 ; adds

    dec ecx                                          ; Substract 1 to the number of arguments
    cmp ecx,0                                        ; Checks if there are no more arguments
    jnz cycle                                        ; Repeat if not last

    mov eax, ebx
    call iprintLF                                    ; Prints the sum

    jmp quit
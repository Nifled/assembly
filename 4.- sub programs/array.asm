;array.asm
;prints first letter of each word in args
;author: Erick
;date: 2017/04/04

%include '../2.- functions/functions.asm'

segment .bss
    array resb 20

section .text
    global _start

_start:
    pop ecx                                          ;get # of args

    cmp ecx,2                                        ;compare #args to 2 to quit if less
    jl quit                                          ;jump if less

    pop eax                                          ;remove first arg (program name)
    dec ecx                                          ;decrement # of args by 1

    mov esi,array                                    ;move direction of 'array' to esi
    
    cycle:
        pop ebx                                      ;get direction of current argument
        mov eax,0                                    ;clean eax

        mov al, byte[ebx]                            ;move a byte from with direction ebx to al
        mov byte[esi+edx], al                        ;move al to current index (edx) in defined arr

        inc edx                                      ;increment edx (positin of DEFINED array)
        dec ecx                                      ;decrement # of args

        cmp ecx,0                                    ;compare current ecx to 0
        jne cycle                                    ;if not 0, jump to cycle again

    print:
        mov eax, array                               ;point eax to array
        call sprintLF                                ;print array
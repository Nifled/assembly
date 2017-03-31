;int.asm
;prints whole number
;author: Erick
;date: 2017/03/08

%include '../2.- functions/functions.asm'

section .data
    num DD 543

section .text
    GLOBAL _start

_start:
    mov EAX, [num]                                   ;number to print
    call iprintLF                                    ;print whole number

    mov EAX, num                                  ;string to convert to ASCII
    call atoi                                        ;converts num
    call iprintLF                                    ;prints converted number

    jmp quit                                         ;exit

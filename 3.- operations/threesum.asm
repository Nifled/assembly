;threesum.asm
;adds three numbers
;author: Erick
;date: 2017/03/13

%include '../2.- functions/functions.asm'

section .data
    num1 DD 543                                      ;int
    string1 DB "789",0x0                             ;number string
    num2 DD 888                                      ;int

section .bss
    sum resb 4                                       ;reserve 4 bytes

section .text
    GLOBAL _start
 
_start:
    mov EAX, string1                                 ;string to be converted
    call atoi                                        ;convert string to int
    mov [sum], EAX                                   ;saves converted to sum

    mov EBX, [num1]                                  ;load num2 to EBX
    add EAX, EBX                                     ;adds EAX + EBX and loads to EAX

    mov EBX, [num2]
	add EAX, EBX

    call iprintLF                                    ;prints result

    jmp quit                                         ;exit

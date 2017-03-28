;sum.asm
;prints single digit result after adding 2 numbers.
;author: Erick
;date: 2017/03/06

section .data
    a DB "3"                                         ;primer operator
    b DB "4"                                         ;segundo operador
    msg DB "La suma es: ", 0x0                       ;mensaje
    len EQU $ - msg                                  ;len de mensaje
    vac DB " ", 0xA, 0x0                             ;renglon vacio
    lv EQU $ - vac                                   ;len de vacio

segment .bss
    sum resb 1                                       ;reserves 1 bit

section .text
    GLOBAL _start

_start:
    mov EAX, [a]                                     ;loads first operator 
    sub EAX, '0'                                     ;subtracts character '0'

    mov EBX, [b]                                     ;loads second operator
    sub EBX, '0'                                     ;subtracts character '0'

    add EAX, EBX                                     ;adds numbers
    add EAX, '0'                                     ;adds character '0'
    mov [sum], EAX                                   ;transfers accumulator

    mov ECX, msg                                     ;prints message
    mov EDX, len                                     ;message len
    mov EBX, 1                                       ;stdout
    mov EAX, 4                                       ;sys_write
    int 0x80                                         ;kernel call

    mov ECX, sum                                     ;prints sum
    mov EDX, 1                                       ;sum length
    mov EBX, 1
    mov EAX, 4
    int 0x80                                         ;kernel call

    mov ECX, vac                                     ;renglon vacio
    mov EDX, lv                                      ;len de vacio
    mov EBX, 1 
    mov EAX, 4
    int 0x80                                         ;kernel call

    mov EAX, 1                                       ;sys_exit
    int 0x80                                         ;kernel call

;threestrings.asm
;prints three strings, using functions for repeated tasks
;author: Erick
;date: 2017/03/07

%include 'functions.asm'

section .data
    msg1 DB "Hello world!",0x0                       ;1st message
    msg2 DB "Assembly for dummies",0x0               ;2nd message
    msg3 DB "Erick",0x0                              ;3rd message

section .text
    GLOBAL _start
_start:

    ; PRINTS 1ST MESSAGE
    ; ===================
    mov EAX, msg1                                    ;loads msg1
    call sprint


    ; PRINTS 2ND MESSAGE
    ; ===================
    mov EAX, msg2                                    ;loads msg2
    call sprint                                      ;sprint function call


    ; PRINTS 3RD MESSAGE
    ; ===================
    mov EAX, msg3                                    ;loads msg3
    call sprint

    jmp quit

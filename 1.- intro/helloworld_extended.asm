;helloworld_extended.asm
;prints two strings 'Hello World!' and 'My name is Erick.'
;author: Erick
;date: 2017/02/27

section .data
    msj1 DB 'Hello World!', 0xA, 0x0                 ;1er string
    len1 EQU $ - msj1                                ;len de 1er string
    
    msj2 DB 'My name is Erick.', 0xA                 ;2nd string
    len2 EQU $ - msj2                                ;len de 2do string

section .text                                        ;requerido por el linker
    GLOBAL _start                                    ;punto de partida           
_start:
    mov EDX, len1                                    ;len de primer mensaje
    mov ECX, msj1                                    ;mensaje 1
    mov EBX, 1                                       ;stdout
    mov EAX, 4                                       ;sys_write
    int 0x80                                         ;llamar a Kernel

    mov EDX, len2                                    ;len del segundo mensaje
    mov ECX, msj2                                    ;mensaje 2
    mov EBX, 1                                       ;stdout
    mov EAX, 4                                       ;sys_write
    int 0x80                                         ;llamar a Kernel

    mov EAX, 1                                       ;sys_exit
    int 0x80                                         ;Kernel

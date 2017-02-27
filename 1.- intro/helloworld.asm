;helloworld.asm
;prints 'Hello World!'
;author: Erick
;date: 2017/02/23

section .data
    msj DB 'Hello World!', 0xA, 0x0                  ;mensaje a imprimir
    len EQU $ - msj                                  ;len de mensaje

section .text                                        ;necesario para linker
    GLOBAL _start                                    ;punto de partida
_start:
    mov EDX, len                                     ;len del mensaje
    mov ECX, msj                                     ;mensaje a imprimir
    mov EBX, 1                                       ;descriptor del archivo(stdout)
    mov EAX, 4                                       ;num de llamada de sistema(sys_write)
    int 0x80                                         ;llamar al Kernal

    mov EAX, 1                                       ;num de llamada de systema(sys_exit)                                       
    int 0x80                                         ;llamar al Kernel

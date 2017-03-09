;functions.asm
;prints three strings, using functions for repeated tasks
;author: Erick
;date: 2017/03/08

sys_exit EQU 1
sys_read EQU 3
sys_write EQU 4
stdin EQU 0
stdout EQU 1
stderr EQU 3

strlen:
    push EBX
    mov EBX, EAX

sigcar:
    cmp byte[EAX], 0                                 ;checks if curr byte == 0
    jz finalizar                                     ;if 0, jump to finalizar
    inc EAX                                          ;else, incremente EAX
    jmp sigcar

finalizar:
    sub EAX, EBX
    pop EBX
    ret

sprint:
    push EDX                                         ;save value of EDX
    push ECX                                         ;save value of ECX
    push EBX                                         ;save value of EBX
    push EAX                                         ;save value of EAX
    call strlen                                      ;call strlen function

    mov EDX, EAX                                     ;move len of msg
    pop EAX                                          ;get EAX location from stack
    mov ECX, EAX                                     ;msg's address
    mov EBX, stdout                                       ;stdout
    mov EAX, sys_write                                       ;sys_write
    int 80h                                          ;executes

    pop EBX                                          ;re-establish EBX
    pop ECX                                          ;re-establish ECX
    pop EDX                                          ;re-establish EDX
    ret

quit:
    mov EAX, sys_exit                                       ;sys_exit
    int 0x80                                         ;kernel call

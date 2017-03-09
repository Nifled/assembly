;threestrings.asm
;prints three strings, using functions for repeated tasks
;author: Erick
;date: 2017/03/07

section .data
    msg1 DB "Hello world!",0xA,0x0                   ;1st message
    msg2 DB "Assembly for dummies",0xA,0x0           ;2nd message
    msg3 DB "Erick",0xA,0x0                          ;3rd message

section .text
    GLOBAL _start
_start:

    ; PRINTS 1ST MESSAGE
    ; ===================
    mov EAX, msg1                                    ;loads msg1
    call sprint

    ; call strlen                                    ;calculate len of str in EAX
    ; mov EDX, EAX                                   ;saves len in EDX
    ; mov EXC, msg1                                  ;loads msg1
    ; mov EAX, 4                                     ;sys_write
    ; mov EBX, 1                                     ;stdout
    ; int 0x80                                       ;kernel call


    ; PRINTS 2ND MESSAGE
    ; ===================
    mov EAX, msg2                                    ;loads msg2
    call sprint                                      ;sprint function call

    ; call strlen                                    ;calculate len of str in EAX
    ; mov EDX, EAX                                   ;saves len in EDX
    ; mov EXC, msg2                                  ;loads msg2
    ; mov EAX, 4                                     ;sys_write
    ; mov EBX, 1                                     ;stdout
    ; int 0x80                                       ;kernel call


    ; PRINTS 3RD MESSAGE
    ; ===================
    mov EAX, msg3                                    ;loads msg3
    call sprint

    ; call strlen                                    ;calculate len of str in EAX
    ; mov EDX, EAX                                   ;saves len in EDX
    ; mov EXC, msg3                                  ;loads msg3
    ; mov EAX, 4                                     ;sys_write
    ; mov EBX, 1                                     ;stdout
    ; int 0x80                                       ;kernel call

    jmp exit

strlen:
    push EBX                                         ;saves value of EBX 
    mov EBX, EAX                                     ;copies location of EAX to EBX

sigcar:
    cmp byte[EAX], 0                                 ;checks if curr byte == 0
    jz finalizar                                     ;if 0, jump to finalizar
    inc EAX                                          ;else, incremente EAX
    jmp sigcar                                       ;

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
    mov EBX, 1                                       ;stdout
    mov EAX, 4                                       ;sys_write
    int 80h                                          ;executes

    pop EBX                                          ;re-establish EBX
    pop ECX                                          ;re-establish ECX
    pop EDX                                          ;re-establish EDX
    ret

exit:
    mov EAX, 1                                       ;sys_exit
    int 0x80                                         ;kernel call

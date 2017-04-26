;read_file.asm
;read from a txt file and outputs
;author: Erick
;date: 2017/04/25   

%include '../2.- functions/functions.asm'

segment .bss
    buffer resb 2048
    len equ $-buffer

section .text
    global _start

_start:
    pop ecx                                          ;# of args
    cmp ecx, 2                                       ;check that there's at least 1 arg
    jl end

    pop eax                                          ;pop first arg
    dec ecx                                          ;decrement # of args

    ;====== Open file ======
    pop ebx                                          ;file name
    mov eax, sys_open                                ;read operation

    mov ecx, O_RDONLY                                ;O_RDONLY = 0

    int 0x80                                         ;call to system
    cmp eax, 0                                       ;greater than 0
    jle error

    ;====== Read file ======
    mov ebx, eax                                     ;move file handle to ebx
    mov eax, sys_read                                ;read

    mov ecx, buffer                                  ;buffer direction
    mov edx, len                                     ;buffer len

    int 0x80                                         ;call to system


    ;====== Close file ======
    mov eax, sys_close
    int 0x80

    mov eax, buffer
    call sprintLF

error:
    mov ebx, eax
    mov eax, sys_exit
    int 0x80

end:
    jmp quit
;read_file_menu.asm
;displays menu for reading and printing text file
;author: Erick
;date: 2017/04/26

%include '../2.- functions/functions.asm'

section .data
    menu DB "| 1. Read File | 2. Print File | 0. Quit |",0xA,0x0

segment .bss
    file_buffer resb 2048
    len equ $-file_buffer

    option_buffer resb 3
    option_buffer_len equ $-option_buffer

    filename_buffer resb 20
    filename_buffer_len equ $-filename_buffer

    filename resb 20

section .text
    global _start

_start:
    mov eax, menu
    call sprint                                      ;displays menu

    mov ecx, option_buffer                           ;moves option_buffer to ecx for readText function
    mov edx, option_buffer_len                       ;moves option_buffer_len to edx for readText

    call readText
    mov eax, option_buffer
    call atoi                                        ;convert option to int

    cmp eax,1                                        ;compare option to 1 (readFile)
    je readFile                                      ;jump if equal

    cmp eax,2                                        ;compare option to 2 (printFile)
    je printFile                                     ;jump if equal

    cmp eax,0                                        ;compare option to 3 (Quit)
    je end                                           ;jump if equal


    ;=== if any other number is entered, displays menu again ===
    cmp eax, 3
    jge _start


readFile:
    mov ecx, filename_buffer                         ;moves option_buffer to ecx for readText function
    mov edx, filename_buffer_len                     ;moves option_buffer_len to edx for readText

    call readText
    mov eax, filename_buffer

    mov esi, filename                                ;moves filename to esi for stringcopy function
    call stringcopy

    jmp _start

printFile:
    mov ebx, filename

    ;====== Open file ======
    mov eax, sys_open                                ;read operation

    mov ecx, O_RDONLY                                ;O_RDONLY = 0

    int 0x80                                         ;call to system
    cmp eax, 0                                       ;greater than 0
    jle error

    ;====== Read file ======
    mov ebx, eax                                     ;move file handle to ebx
    mov eax, sys_read                                ;read

    mov ecx, file_buffer                             ;buffer direction
    mov edx, len                                     ;buffer len

    int 0x80                                         ;call to system


    ;====== Close file ======
    mov eax, sys_close
    int 0x80

    mov eax, file_buffer
    call sprintLF

    jmp _start

error:
    mov ebx, eax
    mov eax, sys_exit
    int 0x80


end:
    jmp quit

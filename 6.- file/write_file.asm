;write_file.asm
;write to a text file
;author: Erick
;date: 2017/04/27

%include '../2.- functions/functions.asm'

segment .bss
    buffer_text resb 30
    len_text equ $-buffer_text

    filename resb 30
    len_filename equ $-filename

    file resb 30

section .text
    global _start

_start:
    mov ecx, buffer_text                             ;gets buffer ready (text to write to file)
    mov edx, len_text
    call readText                                    ;gets input

    mov ecx, filename                                ;gets filename buffer ready
    mov edx, len_filename
    call readText

    mov esi, file                                    ;moves file to esi for copystring
    mov eax, filename                                ;moves filename to eax for copystring func
    call copystring

    ;create file if doesn't exist
    mov ebx, file
    mov  eax, 8                                      ;sys_creat
    mov ecx, 511                                     ;permissions
    int 0x80

    cmp eax, 0                                       ;if file is none, go to error
    jle error

    ;open file for writing
    mov eax, sys_open
    mov ecx, O_RDWR                                  ;file for reading and writing
    int 0x80

    cmp eax, 0
    jle error                                        ;if 0 or less, error

    ;write
    mov ebx, eax                                     ;file handle to ebx
    mov eax, sys_write

    mov ecx, buffer_text
    mov edx, len_text
    int 0x80

    mov eax, 36                                      ;sys_sync
    int 0x80

error:
    mov ebx, eax
    mov eax, sys_exit
    int 0x80

end:
    jmp quit
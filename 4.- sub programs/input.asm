;input.asm
;captures input and print
;author: Erick
;date: 2017/04/18

%include '../2.- functions/functions.asm'

section .data
    msg1 DB "Your name: ",0xA,0x0
    msg2 DB "Your age: ",0xA,0x0

segment .bss
    name_buffer resb 20
    name_buffer_len equ $-name_buffer

    age_buffer resb 3                                ;reserve 3 because buffer is going to be hexadecimal
    age_buffer_len equ $-age_buffer

    name resb 20
    age resb 4

section .text
    global _start

_start:
    ;===== name =====
    mov eax, msg1                                    ;move msg1 to eax to print
    call sprint                                      ;print msg1

    mov ecx, name_buffer                             ;mov name_buffer to ecx for readText func
    mov edx, name_buffer_len                         ;mov name_buffer_len to 

    call readText                                    ;waits for name input
    mov eax, name_buffer ;saves name_buffer to memory in eax

    mov esi, name ;moves name to esi for stringcopy function
    call stringcopy

    ;===== age =====
    mov eax, msg2
    call sprint ;prints msg2

    mov ecx, age_buffer
    mov edx, age_buffer_len
    
    call readText ;waits for age input
    mov eax, age_buffer ;move age_buffer to eax

    call atoi ;convert to int
    mov [age],eax ;move eax to age var

    ;===== print =====
    mov eax, name
    call sprintLF ;print name with line feed
    mov eax, [age]
    call iprintLF ;print age with line feed

    jmp quit

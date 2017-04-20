;menu.asm
;displays menu and acts accordingly to choice (using input)
;author: Erick
;date: 2017/04/20

%include '../2.- functions/functions.asm'

section .data
    menu DB "| 1. Capture Name | 2. Capture Age | 3. Print | 4. Quit |",0xA,0x0

    msgName DB "Your name: ",0xA,0x0
    msgAge DB "Your age: ",0xA,0x0

segment .bss
    option_buffer resb 3
    option_buffer_len equ $-option_buffer

    name_buffer resb 20
    name_buffer_len equ $-name_buffer

    age_buffer resb 3                                ;reserve 3 because buffer is going to be hexadecimal
    age_buffer_len equ $-age_buffer

    name resb 20
    age resb 4

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

    cmp eax,1                                        ;compare option to 1 (captureName)
    je captureName                                   ;jump if equal

    cmp eax,2                                        ;compare option to 2 (captureAge)
    je captureAge                                    ;jump if equal

    cmp eax,3                                        ;compare option to 3 (printAll)
    je printAll                                      ;jump if equal

    cmp eax,4                                        ;compare option to 4 (end)
    je end                                           ;jump if equal


    ;=== if any other number is entered, displays menu again ===
    cmp eax, 5
    jge _start


captureName:
    mov eax, msgName                                 ;move msgName to eax to print
    call sprint                                      ;print msgName

    mov ecx, name_buffer                             ;mov name_buffer to ecx for readText func
    mov edx, name_buffer_len                         ;mov name_buffer_len to 

    call readText                                    ;waits for name input
    mov eax, name_buffer                             ;saves name_buffer to memory in eax

    mov esi, name                                    ;moves name to esi for stringcopy function
    call stringcopy

    jmp _start                                       ;jump to _start to display menu again

captureAge:
    mov eax, msgAge
    call sprint                                      ;prints msgAge

    mov ecx, age_buffer
    mov edx, age_buffer_len
    
    call readText                                    ;waits for age input
    mov eax, age_buffer                              ;move age_buffer to eax

    call atoi                                        ;convert to int
    mov [age],eax                                    ;move eax to age var

    jmp _start

printAll:
    mov eax, name
    call sprintLF                                    ;print name with line feed
    mov eax, [age]
    call iprintLF                                    ;print age with line feed

    jmp _start


end:
    jmp quit

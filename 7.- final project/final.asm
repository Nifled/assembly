;final.asm
;prints three strings, using functions for repeated tasks
;author: Erick Delfin, Gilberto Ayala, German Verdugo
;date: 2017/05/11

%include '../2.- functions/functions.asm'

segment .data
    msg_file_not_found db "File not found...",0x0

segment .bss
    array resb 3000
    file_buffer resb 2048
    len equ $-file_buffer

section .text
    global _start


_start:
    mov esi, array 									 ;save array direction to esi

    pop ecx                                          ;# of args
    cmp ecx, 2                                       ;check that there's at least 1 arg
    jl no_file

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

    mov ecx, file_buffer                                  ;file_buffer direction
    mov edx, len                                     ;file_buffer len

    int 0x80                                         ;call to system


    ;====== Close file ======
    mov eax, sys_close
    int 0x80


    mov eax, file_buffer ;move file contents to eax
    call string_copy_count

    mov eax, array                               ;point eax to array
    call sprintLF                                ;print array



string_copy_count:
	mov ebx, 0
	mov ecx, 0
	mov ebx, eax
    pop edx
    
    .next_char:

        mov bl, byte[eax]

        cmp bl, 0 ;if there's still something left
        jz .done        

        cmp bl, 0xA ;if its end of word
        je .end_word

        mov byte[esi+ecx], bl	; moves a char to current index

        inc eax			    	; next letter
        inc ecx			    	; so it doesn't rewrite a char
        jmp .next_char

    .end_word:
        add esi, 30

        inc eax				; next letter
        inc ecx				; so it doesn't rewrite a char
        jmp .next_char
        
    .done:				;restore values
        push edx
        ret






no_file:
    mov eax, msg_file_not_found
    call sprintLF
    jmp end

error:
    mov ebx, eax
    mov eax, sys_exit
    int 0x80

end:
    jmp quit

;capture_array.asm
;file operations with array
;author: Erick
;date: 2017/05/01

%include '../2.- functions/functions.asm'

segment .bss
    buffer_name resb 50
	len_name equ $-buffer_name

	option resb 4
	buffer_option resb 3
	len_option equ $-buffer_option

	buffer_file resb 2048
	len_file equ $-buffer_file
	
	
	name resb 50
	file resb 2048
	array resb 2000
	len_array EQU $-array

section .text
    global _start

segment .data
	menu db "1.- Capture Name | 2.- Print array | 3.- Save File | 0.- Quit",0xA,0x0

	msg_file DB "File name: ",0x0
	msg_print db "Saved Names: ", 0x0
	
	msg_name db "Input Name: ",0x0

	msg_empty db "Array is Empty!", 0x0
	msg_error db "Not valid!",0x0

	dummy db "c",0x0
	

_start:
	mov esi, array
	push ecx

	menu_start:
		push esi

		mov eax,menu
		call sprint ;menu display

		mov ecx, buffer_option 	;get registers ready for input
		mov edx, len_option
		call readText ;reads input

		mov eax, buffer_option
		mov esi, option
		call stringcopy ;handles the option that is inputted

		mov eax, option
		call atoi

		cmp eax, 1 ;if option 1 is inputted (capture name)
		je capture_name

		cmp eax, 2 ;if option 2 is inputted (print)
		je print_array


		cmp eax, 3 ;if option 4 is inputted (save file)
		je opcion3 

		cmp eax, 0 ;if option 0 is inputted (quit)
		je end

		jmp validation_error


;=========================== Capture Names ============================
capture_name:
	
	mov eax, msg_name
	call sprint  ;print name message
	
	mov ecx, buffer_name ;registers ready for name input
	mov edx, len_name
	call readText ;gets name input
	mov eax, buffer_name

	pop esi 		; obteiene el pointer del array_nombr
	call stringcopy
	add esi, 50 ;move the array index

	pop ecx
	add ecx, 1 
	push ecx

	;clean up buffer
	mov edi, buffer_name
	mov ecx, 50
	xor eax, eax
	rep stosb

	jmp menu_start


;=========================== Prints array ============================
print_array:
	
	mov eax, msg_print
    call sprintLF ;print print message

    pop ebx                         ;recover ebx
    mov esi, array                  ;start esi with current array pos

    pop ecx                         ;get # of names saved
    push ecx                        ;save number of names
    cmp ecx, 0

    jz noValues ;if zero, go to no values message

    prloop:
        mov eax, esi			
        call sprint

        add esi,50
        dec ecx
        cmp ecx, 0

        jne prloop

    mov esi, ebx                    ;restore original esi

    jmp menu_start


;=========================== Write and Save File ============================
opcion3:
	mov eax, msg_file
	call sprint
	mov ecx, buffer_file
	mov edx, len_file
	call readText

	mov esi, file
	mov eax, buffer_file ;esi used for copstring
	call copystring

	mov eax, sys_create ;sys_create
	mov ebx, file
	mov ecx, 511 ;permissions
	int 0x80

	cmp eax,0
	jle error

	;open file for write
	mov eax, sys_open
	mov ebx, file
	mov ecx, O_RDWR ;read + write
	int 0x80
	cmp eax, 0 ;compare file to 0
	jle error ;if less or equal, go to error


	; write ;
	mov ebx, eax ; file handle a eax
	mov eax, sys_write
	mov ecx, array
	mov edx, len_array
	int 0x80
	mov eax, sys_sync		; sys_sync
	int 0x80
 ;====== Close file ======
    mov eax, sys_close
    int 0x80
    pop esi

    jmp menu_start

validation_error:
	mov eax, msg_error
	call sprintLF
	pop esi

	jmp menu_start

error:
	mov ebx,eax
	mov eax,sys_exit
	int 0x80

noValues:
	mov eax, msg_empty
	call sprintLF
	
	jmp menu_start

end:
	jmp quit

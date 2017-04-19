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
    push ebx
    mov ebx, eax

sigcar:
    cmp byte[eax], 0                                 ;checks if curr byte == 0
    jz finalizar                                     ;if 0, jump to finalizar
    inc eax                                          ;else, incremente eax
    jmp sigcar

finalizar:
    sub eax, ebx
    pop ebx
    ret

sprint:
    push edx                                         ;save value of edx
    push ecx                                         ;save value of ecx
    push ebx                                         ;save value of ebx
    push eax                                         ;save value of eax
    call strlen                                      ;call strlen function

    mov edx, eax                                     ;move len of msg
    pop eax                                          ;get eax location from stack
    mov ecx, eax                                     ;msg's address
    mov ebx, stdout                                       ;stdout
    mov eax, sys_write                                       ;sys_write
    int 80h                                          ;executes

    pop ebx                                          ;re-establish ebx
    pop ecx                                          ;re-establish ecx
    pop edx                                          ;re-establish edx
    ret

;Function sprintLF,	prints with LineFeed (new line)	
sprintLF:	
	call sprint		                                 ;calls and prints msg
	
	push eax		                                 ;save accumulator eax to use in function
	mov eax,0xA		                                 ;Hexadecimal LineFeed character
	push eax		                                 ;save 0xA to stack
	mov eax, esp	                                 ;mov 0xA location to stack  // esp points to last direction of stack or to eax
	call sprint		                                 ;calls and prints LineFeed 
	pop eax			                                 ;get back 0xA
	pop eax			                                 ;get back original value of 0xA
	ret				                                 ;returns

;Function iprint (IntegerPrint)
iprint:
	push eax				                         ;save eax to stack (accumulator)
	push ecx				                         ;save ecx to stack (counter)
	push edx				                         ;save edx to stack (data)
	push esi				                         ;save esi to stack (source index)
	mov ecx,0				                         ;count how many bytes we need
	
dividirLoop:
	inc ecx					                         ;increment ecx by 1
	mov edx, 0 				                         ;clean edx
	mov esi, 10				                         ;save 10 in esi, we will divide by 10
	idiv esi				                         ;divide eax by esi, siempre divide a eax lo que este en eax lo divide con el vqlor de esi	
	add edx, 48				                         ;agregamos el caracter 48 '0' 
	push edx				                         ;la representación en ASCII de nuestro numero, lo guarda en el stack como caracter
	cmp eax, 0 				                         ;se puede dividir mas el numero entero ?
	jnz dividirLoop			                         ;jump if not zero (salta si no es cero)

imprimirLoop:
	dec ecx					                         ;count backwards each byte in stack
	mov eax, esp			                         ;stack pointer to eax
	call sprint				                         ;call sprint function
	pop eax					                         ;remove last char from stack and send to eax
	cmp ecx, 0 				                         ;print all of stack's bytes?
	jnz imprimirLoop		                         ;there is no number to print
	
	pop esi 				                         ;recover value of esi
	pop edx					                         ;recover value of edx
	pop ecx                                          ;recover value of ecx
	pop eax 				                         ;recover value of eax
	ret

iprintLF:
    call iprint                                      ;print out the numbers
    push eax                                         ;saves what's stored in eax

    mov eax,0xA                                      ;copy line-feed to eax
    push eax                                         ;saves line-feed in the stack
    mov eax, esp                                     ;copies stack's pointer
    call sprint                                      ;print out the line-feed
    pop eax                                          ;removes line-feed from stack
    pop eax                                          ;recover data that we had
    ret                                              ;returns

;==========================
; Converts int to ASCII
;==========================
atoi:
    push ebx                                         ;preserve ebx
    push ecx                                         ;preserve ecx
    push edx                                         ;preserve edx
    push esi                                         ;preserves esi
    mov esi, eax                                     ;number to convert to esi
    mov eax, 0                                       ;initialize eax in 0
    mov ecx, 0                                       ;initialize ecx in 0

    loopmult:                                        ;loop multiplication

    xor ebx, ebx                                     ;reset ebx to 0
    mov bl, [esi + ecx]

    cmp bl, 48                                       ;compare with ASCII '0'
    jl finalized                                     ;if less, jump to finalized

    cmp bl, 57                                       ;compare with ascci '9'
    jg finalized                                     ;if greater, finalized

    cmp bl, 10                                       ;compare with linefeed
    je finalized                                     ;if equal, jump to finalized

    cmp bl, 0                                        ;compare with null character
    jz finalized                                     ;if zero, jump to finalized

    sub bl, 48                                       ;convert character to int
    add eax, ebx                                     ;add value of ebx
    mov ebx, 10                                      ;move decimal 10 to ebx
    mul ebx                                          ;multiplies eax x EBC
    inc ecx                                          ;increment ecx (counter)
    jmp loopmult                                     ;keep looping the multiplication loop

    finalized:
    mov ebx,10 	                                     ; move decimal 10 to ebx
    div ebx		                                     ; divide ebx by 10
    pop esi 	                                     ; get esi
    pop edx		                                     ; get edx
    pop ecx		                                     ; get ecx
    pop ebx 	                                     ; get ebx
    ret

; Fahrenheit to Celsius conversion
ftoc:
    sub eax, 32 ;subtract 32
    imul eax, 5 ;multiply 5
    push edx ;save register in stack for use
    mov edx, 0
    push ebx ;save register in stack for use
    mov ebx, 9
    div ebx ;divide eax by given register (ebx)
    pop ebx ;get rid of register from stack
    pop edx ;get rid of register from stack
    ret

; Celsius to Fahrenheit conversion
ctof:
	imul eax, 9 
	push edx
	mov edx,0
	push ebx
	mov ebx, 5
	div ebx
	pop ebx
	pop edx
	add eax, 32
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function to print string from array ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stringcopy:
	push ecx										 ;save and clear registers
	push ebx
	mov ebx, 0
	mov ecx, 0
	mov ebx, eax

	.sigcar:
		mov bl, byte[eax]
		mov byte[esi+ecx], bl						 ;move one character

		cmp byte[eax],0								 ;check if byte is 0
		jz .finalized 								 ;jump if zero to finalized

		inc eax										 ;next letter
		inc ecx 									 ;avoid rewriting a char in index
		jmp .sigcar

	.finalized:
		pop ebx 									 ;restore values
		pop ecx
		ret

;==========================
; Reads input.
; Accepts buffer in ecx, and buffer len in edx.
;==========================
readText:
    mov eax, sys_read
    mov ebx, stdin
    int 0x80
    return

quit:
    mov eax, sys_exit                                ;sys_exit
    int 0x80                                         ;kernel call
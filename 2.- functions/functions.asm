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

;Function sprintLF,	prints with LineFeed (new line)	
sprintLF:	
	call sprint		                                 ;calls and prints msg
	
	push EAX		                                 ;save accumulator EAX to use in function
	mov EAX,0xA		                                 ;Hexadecimal LineFeed character
	push EAX		                                 ;save 0xA to stack
	mov EAX, ESP	                                 ;mov 0xA location to stack  // ESP points to last direction of stack or to EAX
	call sprint		                                 ;calls and prints LineFeed 
	pop EAX			                                 ;get back 0xA
	pop EAX			                                 ;get back original value of 0xA
	ret				                                 ;returns

;Function iprint (IntegerPrint)
iprint:
	push eax				                         ;save eax to stack (accumulator)
	push ecx				                         ;save ecx to stack (counter)
	push edx				                         ;save edx to stack (data)
	push esi				                         ;save esi to stack (source index)
	mov ecx, 0				                         ;count how many bytes we need
	
dividirLoop:
	inc ecx					                         ;increment ecx by 1
	mov edx, 0 				                         ;clean edx
	mov esi, 10				                         ;save 10 in esi, we will divide by 10
	idiv esi				                         ;divide eax by esi, siempre divide a EAX lo que este en eax lo divide con el vqlor de esi	
	add EDX, 48				                         ;agregamos el caracter 48 '0' 
	push EDX				                         ;la representación en ASCII de nuestro numero, lo guarda en el stack como caracter
	cmp EAX, 0 				                         ;se puede dividir mas el numero entero ?
	jnz dividirLoop			                         ;jump if not zero (salta si no es cero)

imprimirLoop:
	dec ECX					                         ;count backwards each byte in stack
	mov EAX, ESP			                         ;stack pointer to eax
	call sprint				                         ;call sprint function
	pop EAX					                         ;remove last char from stack and send to eax
	cmp ECX, 0 				                         ;print all of stack's bytes?
	jnz imprimirLoop		                         ;there is no number to print
	
	pop ESI 				                         ;recover value of ESI
	pop EDX					                         ;recover value of EDX
	pop ECX                                          ;recover value of ECX
	pop EAX 				                         ;recover value of EAX
	ret

iprintLF:
    call iprint                                      ;print out the numbers
    push EAX                                         ;saves what's stored in EAX

    mov EAX,0xA                                      ;copy line-feed to EAX
    push EAX                                         ;saves line-feed in the stack
    mov EAX, ESP                                     ;copies stack's pointer
    call sprint                                      ;print out the line-feed
    pop EAX                                          ;removes line-feed from stack
    pop EAX                                          ;recover data that we had
    ret                                              ;returns

;==========================
; Converts int to ASCII
;==========================
atoi:
    push EBX                                         ;preserve EBX
    push ECX                                         ;preserve ECX
    push EDX                                         ;preserve EDX
    push ESI                                         ;preserves ESI
    mov ESI, EAX                                     ;number to convert to ESI
    mov EAX, 0                                       ;initialize EAX in 0
    mov ecx, 0                                       ;initialize ECX in 0

    loopmult:                                        ;loop multiplication

    xor EBX, EBX                                     ;reset EBX to 0
    mov BL, [ESI + ECX]

    cmp BL, 48                                       ;compare with ASCII '0'
    jl finalizado                                    ;if less, jump to finalizado

    cmp BL, 10                                       ;compare with linefeed
    je finalizado                                    ;if equal, jump to finalizado

    cmp BL, 0                                        ;compare with null character
    jz finalizado                                    ;if zero, jump to finalizado

    sub BL, 48                                       ;convert character to int
    add EAX, EBX                                     ;add value of EBX
    mov EBX, 10                                      ;move decimal 10 to EBX
    mul EBX                                          ;multiplies EAX x EBC
    inc ECX                                          ;increment ECX (counter)
    jmp loopmult                                     ;keep looping the multiplication loop

    finalizado:
    mov ebx,10 	                                     ; move decimal 10 to EBX
    div ebx		                                     ; divide EBX by 10
    pop esi 	                                     ; get ESI
    pop edx		                                     ; get edx
    pop ecx		                                     ; get ecx
    pop ebx 	                                     ; get ebx
    ret
    


quit:
    mov EAX, sys_exit                                ;sys_exit
    int 0x80                                         ;kernel call
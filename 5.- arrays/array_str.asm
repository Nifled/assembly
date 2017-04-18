; array_str.asm
;author: Erick
;date: 2017/04/05

%include '../2.- functions/functions.asm'

segment .bss
	array resb 20

section .text
	global _start

_start:
	pop ecx 										 ;get # of args
	cmp ecx, 2										 ;compare to 2
	jl end											 ;if less than 2, end

	pop eax 										 ;pop first arg
	dec ecx											 ;decrement num of args (ecx)

	mov edx, ecx 									 ;save original # of args
	mov esi, array 									 ;save array direction to esi

	cycle:
		pop eax 									 ;get arg direction
		call stringcopy

		add esi, 10

		dec ecx 									 ;decrement # of args  
		cmp ecx,0 									 ;check if there are still args
		jne cycle 								 	 ;keep looping

	mov ecx, edx 									 ;restore original # of args
	mov esi, array


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

print:
	mov eax, esi
	call iprintLF									 ;prints int
	add esi, 10

	dec ecx
	cmp ecx, 0
	jne print

end:
	jmp quit

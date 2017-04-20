;array_str.asm
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

print:
	mov eax, esi
	call iprintLF									 ;prints int
	add esi, 10

	dec ecx
	cmp ecx, 0
	jne print

end:
	jmp quit

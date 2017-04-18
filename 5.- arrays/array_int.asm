;array_int.asm
;puts args in array and prints avg
;author: Erick
;date: 2017/04/06

%include '../2.- functions/functions.asm'

segment .bss
	array resb 100
    num_arg resb 4

section .text
	global _start

_start:
	pop ecx					                         ;get # of args
	cmp ecx, 2				                         ;check if there are less than 2 arguments
	jl quit

	pop eax					                         ;pop first argument
	dec ecx				
	mov [num_arg], ecx		                         ;save original number of arguments
	mov esi, array			                         ;save array direction to esi

    cycle:
        pop eax					                     ;get directino of arg
        call atoi                                    ;converto to int

        mov [esi], eax                               ;move eax to the array
        add esi, 4                                   ;move the pointer

        dec ecx					                     ;decrement # of args
        cmp ecx, 0				                     ;check if there are still args
        jne cycle

    mov ecx, [num_arg] 			                     ;restore original number of args
    mov esi, array
    mov ebx, 0                                       ;clean ebx (to put sum in there)

    summation:
        mov eax, [esi]			                     ;get num from array

        add ebx, eax                                 ;add current num to ebx (counter)

        add esi, 4                                   ;moves the array's pointer
        dec ecx                                      ;decrement ecx
        cmp ecx, 0                                   ;check if there are still args
        jne summation

    mov eax, ebx                                     ;move sum to eax
    mov ecx, [num_arg]                               ;move # of args to ecx
    idiv ecx                                         ;divide eax / ecx
    call iprintLF                                    ;print avg
        
    jmp quit
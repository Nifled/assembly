;args.asm
;prints given args in order, using a cycle
;author: Erick
;date: 2017/03/16

;arguments.asm

%include '../2.- functions/functions.asm'

section .text
    global _start

_start:
    pop ecx                                          ;get number of args

cycle:
    pop eax                                          ;get arg
    call sprintLF                                    ;prints arg

    dec ecx                                          ;subtract 1 to num of args
    cmp ecx, 0                                       ;check if last arg
    jnz cycle                                        ;(jump if not zero) go on if not last arg

    jmp quit                                         ;if last arg, quit
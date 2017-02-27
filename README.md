# Assembly Language

To build .asm code:
```
$ nasm -f elf -F stabs myfile.asm         # This will create .o file
$ ld -m elf_i386 -s -o myfile myfile.o    # Creates executable
$ ./myfile                                # Outputs
```

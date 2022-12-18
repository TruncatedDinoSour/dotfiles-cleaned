format ELF64 executable 3
segment readable executable

include "include/syscalls.asm"
include "include/constants.asm"

_start:
    ;; Code

    mov eax, SYS_exit
    xor edi, edi
    syscall

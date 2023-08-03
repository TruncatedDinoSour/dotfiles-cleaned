define ARGV_1 16

define SYS_open 2
define SYS_write 1
define SYS_close 3
define SYS_exit 60

define O_WRONLY 1

define stderr 2
define EXIT_FAILURE 1

format ELF64 executable 3
segment readable executable

_start:
    mov rsi, oob_msg
    mov rdx, oob_msg_len

    mov rbx, [rsp + ARGV_1]  ; argv[1]

    cmp byte [rbx], 51       ; *argv[1] > '3'
    jg .err
    cmp byte [rbx], 48       ; || *argv[1] < '0'
    jl .err

    mov rax, SYS_open        ; open(backlight, O_WRONLY)
    mov rdi, backlight
    mov rsi, O_WRONLY
    syscall

    mov rdi, rax             ; fd = ^

    mov rax, SYS_write
    ; <fd>
    mov rsi, rbx
    mov rdx, 1
    syscall

    mov rax, SYS_close       ; close(fd)
    syscall

    mov rax, SYS_exit        ; return 0
    xor rdi, rdi
    syscall

.err:
    mov rax, 1               ; fputs(stderr, err_msg)
    mov rdi, stderr
    syscall

    mov rax, SYS_exit        ; return 1
    mov rdi, EXIT_FAILURE
    syscall


segment readable

oob_msg: db "brightness out of bounds [0;3]", 10
oob_msg_len = $ - oob_msg

backlight: db "/sys/class/leds/asus::kbd_backlight/brightness", 0

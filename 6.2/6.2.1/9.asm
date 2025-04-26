section .data
    smallestInt dd 0x80000000    ; -2147483648

section .text

global _start

_start:
    mov eax, [smallestInt]    ; Load smallest 32-bit signed integer into EAX

    mov ebx, 0                ; Exit code 0
    mov eax, 1                ; Syscall number for exit
    int 0x80                  ; Call kernel

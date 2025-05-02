section .data
    myBYTE      db  255
    mySBYTE     db  -128

    myWORD      dw  65535
    mySWORD     dw  -32768

    myDWORD     dd  4294967295
    mySDWORD    dd  -2147483648

    myQWORD     dq  0FFFFFFFFFFFFFFFFh
    mySQWORD    dq  -9223372036854775808

    myREAL4     dd  3.14
    myREAL8     dq  3.1415926535

    newline     db 10

section .bss
    myTBYTE     resb 10
    myREAL10    resb 10
    buffer      resb 12         ; 10 digits + null + extra

section .text
global _start

_start:
    ; Load value from myDWORD into EAX
    mov eax, [myDWORD]

    ; Convert EAX to ASCII in buffer
    mov esi, buffer + 11        ; point to end of buffer
    mov ecx, 10                 ; divisor for base 10

.convert_loop:
    xor edx, edx
    div ecx                     ; eax ÷ 10 → eax=quotient, edx=remainder
    add dl, '0'                 ; convert digit to ASCII
    dec esi
    mov [esi], dl
    test eax, eax
    jnz .convert_loop

    ; Write result to stdout
    mov eax, 4                  ; syscall: sys_write
    mov ebx, 1                  ; file descriptor: stdout
    mov ecx, esi                ; pointer to ASCII string
    mov edx, buffer + 11
    sub edx, esi                ; length = end - start
    int 0x80

    ; Write newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80

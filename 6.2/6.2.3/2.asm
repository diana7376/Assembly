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

section .bss
    myTBYTE     resb 10        ; 80-bit integer (uninitialized)
    myREAL10    resb 10        ; 80-bit float placeholder (uninitialized)

section .text
global _start

_start:
    mov eax, 1
    xor ebx, ebx
    int 0x80

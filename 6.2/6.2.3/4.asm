section .data
    num1       dd 5
    num2       dd 7
    newline    db 10, 0        ; newline character

section .bss
    result     resd 1
    buffer     resb 12         ; enough for 10-digit number + newline

section .text
global _start

_start:
    ; add num1 and num2
    mov eax, [num1]
    add eax, [num2]
    mov [result], eax          ; store result

    ; convert number in eax to string in buffer
    mov ecx, buffer + 11       ; point to end of buffer
    mov ebx, 10                ; divisor

convert_loop:
    xor edx, edx
    div ebx                    ; eax ÷ 10 → eax = quotient, edx = remainder
    add dl, '0'                ; convert remainder to ASCII
    dec ecx
    mov [ecx], dl              ; store digit in buffer
    test eax, eax
    jnz convert_loop

    ; write the number to stdout
    mov eax, 4                 ; syscall: sys_write
    mov ebx, 1                 ; file descriptor: stdout
    mov edx, buffer + 11       ; buffer end
    sub edx, ecx               ; length = end - start
    mov ecx, ecx               ; ECX already points to start of digits
    int 0x80

    ; print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80


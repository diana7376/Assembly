; Filename: 2.asm
BITS 32

section .data
    var1    dq 0x0123456789ABCDEF        ; First 64-bit number
    var2    dq 0x0000000011111111        ; Second 64-bit number
    sum     dq 0                         ; Sum result (64-bit)

    hex_chars db "0123456789ABCDEF"      ; Lookup for hex digits
    output  db "0x0000000000000000", 10  ; Output template + newline

section .text
global _start

_start:
    ; Load var1 into EDX:EAX
    mov eax, dword [var1]
    mov edx, dword [var1 + 4]

    ; Add var2 to EDX:EAX
    add eax, dword [var2]
    adc edx, dword [var2 + 4]

    ; Store result into sum
    mov dword [sum], eax
    mov dword [sum + 4], edx

    ; Convert result to hex string (64-bit)
    mov esi, output + 2 + 16 - 1     ; point to last hex digit
    mov ecx, 16                      ; 16 hex digits
    mov ebx, edx                     ; upper 32 bits
    call convert_dword_to_hex
    mov ebx, eax                     ; lower 32 bits
    call convert_dword_to_hex

    ; Print the output
    mov eax, 4       ; sys_write
    mov ebx, 1       ; STDOUT
    mov ecx, output
    mov edx, 18
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Converts 32-bit EBX to 8 hex chars at [ESI]
convert_dword_to_hex:
    push ecx
    mov ecx, 8
.hex_loop:
    mov eax, ebx
    and eax, 0xF
    mov edi, hex_chars
    mov al, [edi + eax]
    mov [esi], al
    dec esi
    shr ebx, 4
    loop .hex_loop
    pop ecx
    ret

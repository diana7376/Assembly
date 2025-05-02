section .data
    newline db 10, 0         ; newline character

section .bss
    buffer resb 12           ; buffer to hold ASCII result (max 10 digits + newline)

section .text
global _start

_start:
    ; Step 1: Assign initial values
    mov eax, 10              ; A
    mov ebx, 20              ; B
    mov ecx, 5               ; C
    mov edx, 3               ; D

    ; Step 2: Calculate A = (A + B) - (C + D)
    add eax, ebx             ; EAX = A + B
    add ecx, edx             ; ECX = C + D
    sub eax, ecx             ; EAX = (A + B) - (C + D)

    ; Step 3: Convert EAX to string (result is in EAX)
    mov esi, buffer + 11     ; Point to the end of buffer
    mov ecx, 10              ; Divisor for base 10

.convert_loop:
    xor edx, edx             ; Clear EDX before division
    div ecx                  ; EAX ÷ 10 → quotient in EAX, remainder in EDX
    add dl, '0'              ; Convert digit to ASCII
    dec esi
    mov [esi], dl            ; Store character
    test eax, eax
    jnz .convert_loop        ; Repeat if quotient is not zero

    ; Step 4: Print the result using sys_write
    mov eax, 4               ; sys_write
    mov ebx, 1               ; stdout
    mov ecx, esi             ; pointer to string
    mov edx, buffer + 11
    sub edx, esi             ; length = end - start
    int 0x80

    ; Step 5: Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80

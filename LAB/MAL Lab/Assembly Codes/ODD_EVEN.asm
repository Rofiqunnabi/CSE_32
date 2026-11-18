.model small
.stack 100h
.data
    prompt      db 'Enter a number (0-9): $'
    newline     db 13, 10, '$'
    evenMsg     db 'The number is EVEN.$'
    oddMsg      db 'The number is ODD.$'

.code
main:
    mov ax, @data
    mov ds, ax

    ; Display prompt
    lea dx, prompt
    mov ah, 09h
    int 21h

    ; Read character input
    mov ah, 01h
    int 21h
    sub al, '0'         ; Convert ASCII to numeric
    mov bl, al          ; Store input in BL

    ; Check even or odd using bitwise AND
    mov al, bl
    and al, 1           ; AL = AL AND 00000001
    jz is_even          ; If result is 0, it's even

is_odd:
    lea dx, oddMsg
    mov ah, 09h
    int 21h
    jmp exit

is_even:
    lea dx, evenMsg
    mov ah, 09h
    int 21h

exit:
    ; Print newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
end main

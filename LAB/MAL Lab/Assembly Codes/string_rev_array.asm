.model small
.stack 100h
.data
    inputStr  db 100 dup(?)     ; input buffer
    msg1      db 'Enter a string: $'
    msg2      db 0Dh,0Ah, 'Reversed string: $'
.code
main:
    mov ax, @data
    mov ds, ax

    ; --- Print "Enter a string: " ---
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; --- Read string ---
    lea dx, inputStr
    mov ah, 0Ah           ; DOS function to read buffered input
    mov inputStr, 99      ; max characters that can be entered
    mov inputStr+1, 0     ; actual length initialized to 0
    int 21h

    ; --- Show "Reversed string: " ---
    lea dx, msg2
    mov ah, 09h
    int 21h

    ; --- Get actual input length ---
    mov cl, inputStr+1    ; number of characters entered
    mov ch, 0
    lea si, inputStr+2    ; SI points to the first character
    add si, cx            ; move to the end of the string
    dec si                ; point to last character

print_reverse:
    cmp cx, 0
    je end_program

    mov dl, [si]
    mov ah, 02h
    int 21h

    dec si
    dec cx
    jmp print_reverse

end_program:
    mov ah, 4Ch
    int 21h
end main

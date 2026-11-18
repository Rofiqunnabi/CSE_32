               .model small
.stack 100h
.data
    inputString db 100 dup('$')     ; buffer for input string
    msg db 'Enter a string: $'
    newline db 13, 10, '$'

.code
main:
    mov ax, @data
    mov ds, ax

    ; Print prompt
    lea dx, msg
    mov ah, 09h
    int 21h

    ; Read string from user
    mov ah, 0Ah
    lea dx, inputString
    int 21h

    ; Print newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Convert case
    lea si, inputString + 2         ; Skip first two bytes (length info)
convert_loop:
    mov al, [si]
    cmp al, 0Dh                     ; Check for carriage return (end of input)
    je done

    ; Check if uppercase
    cmp al, 'A'
    jb check_lower
    cmp al, 'Z'
    ja check_lower
    add al, 32                      ; Convert to lowercase
    jmp store_char

check_lower:
    cmp al, 'a'
    jb store_char
    cmp al, 'z'
    ja store_char
    sub al, 32                      ; Convert to uppercase

store_char:
    mov [si], al
    inc si
    jmp convert_loop

done:
    ; Print newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Print converted string
    lea dx, inputString + 2
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
end main
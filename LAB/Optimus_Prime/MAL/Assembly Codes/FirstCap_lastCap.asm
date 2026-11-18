                             .model small
.stack 100h
.data
    inputStr     db 100 dup(?)     ; input buffer
    msg1         db 'Enter a string: $'
    msg2         db 0Dh, 0Ah, 'First capital: $'
    msg3         db 0Dh, 0Ah, 'Last capital alphabetically: $'
    noCapsMsg    db 0Dh, 0Ah, 'No Capitals$'
    firstCap     db '?'
    lastAlphaCap db '?'
.code
main:
    mov ax, @data
    mov ds, ax

    ; --- Print "Enter a string: "
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; --- Read string ---
    lea dx, inputStr
    mov ah, 0Ah           ; DOS function 0Ah (Buffered input)
    mov inputStr, 99      ; max chars
    mov inputStr+1, 0     ; init length
    int 21h

    ; --- Initialize pointers and variables ---
    mov cl, inputStr+1    ; get length
    mov ch, 0
    lea si, inputStr+2    ; SI = start of actual string
    mov bl, 0             ; flag: 0 = no capitals found yet
    mov firstCap, '?'     ; placeholder
    mov lastAlphaCap, 'A' ; start with A as lowest capital

find_capitals:
    cmp cl, 0
    je check_cap_found

    mov al, [si]          ; get current char
    cmp al, 'A'
    jb next_char          ; below 'A', skip
    cmp al, 'Z'
    ja next_char          ; above 'Z', skip

    ; it's a capital letter
    cmp bl, 0
    jne skip_first
    mov firstCap, al      ; store first found capital
    mov bl, 1             ; set flag

skip_first:
    ; Check if this capital is greater than current lastAlphaCap
    mov ah, lastAlphaCap
    cmp al, ah
    jbe next_char
    mov lastAlphaCap, al

next_char:
    inc si
    dec cl
    jmp find_capitals

check_cap_found:
    cmp bl, 0
    je no_capitals

    ; --- Print first capital letter ---
    lea dx, msg2
    mov ah, 09h
    int 21h

    mov dl, firstCap
    mov ah, 02h
    int 21h

    ; --- Print last capital letter alphabetically ---
    lea dx, msg3
    mov ah, 09h
    int 21h

    mov dl, lastAlphaCap
    mov ah, 02h
    int 21h

    jmp end_program

no_capitals:
    lea dx, noCapsMsg
    mov ah, 09h
    int 21h

end_program:
    mov ah, 4Ch
    int 21h
end main

.model small
.stack 100h
.data
    prompt db 'Enter 5 numbers (0-9): $'
    newline db 13, 10, '$'
    ascMsg db 13, 10, 'Ascending Order: $'
    descMsg db 13, 10, 'Descending Order: $'
    array db 5 dup(?)        ; input array
    sorted db 5 dup(?)       ; buffer for sorted output

.code
main:
    mov ax, @data
    mov ds, ax

    ; Prompt user
    lea dx, prompt
    mov ah, 09h
    int 21h

    ; Read 5 numbers
    mov si, 0
read_loop:
    mov ah, 01h
    int 21h
    sub al, '0'
    mov array[si], al
    inc si
    cmp si, 5
    jne read_loop

    ; Copy array to sorted buffer
    mov si, 0
copy_array:
    mov al, array[si]
    mov sorted[si], al
    inc si
    cmp si, 5
    jne copy_array

    ; Sort in ascending order
    mov cx, 4
outer_asc:
    mov si, 0
inner_asc:
    mov al, sorted[si]
    mov ah, sorted[si+1]
    cmp al, ah
    jbe no_swap_asc
    ; Swap
    mov sorted[si], ah
    mov sorted[si+1], al
no_swap_asc:
    inc si
    cmp si, 4
    jne inner_asc
    loop outer_asc

    ; Print ascending order
    lea dx, ascMsg
    mov ah, 09h
    int 21h

    mov si, 0
print_asc:
    mov dl, sorted[si]
    add dl, '0'
    mov ah, 02h
    int 21h
    inc si
    cmp si, 5
    jne print_asc

    ; Copy array again for descending sort
    mov si, 0
copy_array2:
    mov al, array[si]
    mov sorted[si], al
    inc si
    cmp si, 5
    jne copy_array2

    ; Sort in descending order
    mov cx, 4
outer_desc:
    mov si, 0
inner_desc:
    mov al, sorted[si]
    mov ah, sorted[si+1]
    cmp al, ah
    jae no_swap_desc
    ; Swap
    mov sorted[si], ah
    mov sorted[si+1], al
no_swap_desc:
    inc si
    cmp si, 4
    jne inner_desc
    loop outer_desc

    ; Print descending order
    lea dx, descMsg
    mov ah, 09h
    int 21h

    mov si, 0
print_desc:
    mov dl, sorted[si]
    add dl, '0'
    mov ah, 02h
    int 21h
    inc si
    cmp si, 5
    jne print_desc

    ; Exit
    mov ah, 4Ch
    int 21h
end main

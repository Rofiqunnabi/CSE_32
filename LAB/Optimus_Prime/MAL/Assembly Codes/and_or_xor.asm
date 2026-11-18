.model small
.stack 100h
.data
a db 10,13,'AND OPERATION: $'
b db 10,13,'OR OPERATION: $'
c db 10,13,'XOR OPERATION: $'
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,a
    int 21h
    
    mov ah,1
    mov bl,101b
    and bl,100b
    add bl,48
    
    mov ah,2
    mov dl,bl
    int 21h
    
    mov ah,9
    lea dx,b
    int 21h
    
    mov ah,1
    mov bl,101b
    or bl,100b
    add bl,48
    
    mov ah,2
    mov dl,bl
    int 21h
    
    mov ah,9
    lea dx,c
    int 21h
    
    mov ah,1
    mov bl,101b
    xor bl,100b
    add bl,48
    
    mov ah,2
    mov dl,bl
    int 21h
    
    exit:
    
    mov ah,4ch
    int 21h
    main endp
end main
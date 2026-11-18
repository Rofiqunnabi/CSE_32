.model small
.stack 100h
.data
;constant declaration EQU
a equ '2'
b equ 'Hi,I am ANTOR $'
c db b
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,1
    mov bl,a
    int 21h
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13 
    int 21h
    
    mov ah,2
    mov dl,bl
    int 21h
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    mov ah,9
    lea dx,c
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
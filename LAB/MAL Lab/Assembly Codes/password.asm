.model small
.stack 100h
.data
a db 'Enter your password: $'
b db 10,13,'Correct password $'
c db 10,13,'Incorrect password $'  
pass db 'ASSEMBLY$'
pass1 dw 8

.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,a
    int 21h
    
    mov cx,pass1
    mov bx,offset pass
    
    level1:
    
    mov ah,8
    int 21h
    
    cmp al,[bx]
    jne level2
    inc bx
    loop level1
    
    mov ah,9
    lea dx,b
    int 21h
    jmp exit
    
    level2:
    mov ah,9
    lea dx,c
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
    
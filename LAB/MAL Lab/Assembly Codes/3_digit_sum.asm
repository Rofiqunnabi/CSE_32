.model small
.stack 100h
.data
a db 'Enter first number: $'
b db 10,13,'Enter second number: $'
c db 10,13,'Enter Third number: $' 
d db 10,13 ,'Result: $'
msg db ?
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,a
    int 21h
    
    
    mov ah,1
    int 21h
    mov bl,al  
    
    mov ah,9
    lea dx,b
    int 21h
    
    mov ah,1 
    int 21h
    mov bh,al 
    
    mov ah,9
    lea dx,c
    int 21h
    
    mov ah,1
    int 21h
    mov cl,al
    
    add bl,bh
    sub bl,48
    
    mov ch,bl
    
    add cl,ch
    sub cl,48
    
    mov msg,cl 
    
    mov ah,9
    lea dx,d
    int 21h
    
    mov ah,2
    mov dl,msg
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
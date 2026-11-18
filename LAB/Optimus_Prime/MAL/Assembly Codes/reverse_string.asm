.model small
.stack 100h
.data
a db 'ANTOR$'
len equ $-a
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov si,0
    mov cx,len
    dec cx
    
    again:
        
        push [si]
        inc si
        loop again
        
        mov cx,len
        dec cx
        
        disp:
        pop dx
        mov ah,2
        int 21h 
        loop disp
        
        exit:
        mov ah,4ch
        int 21h
        main endp
end main
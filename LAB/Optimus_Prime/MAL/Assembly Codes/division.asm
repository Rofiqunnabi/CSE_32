.model     small
.stack 100h     
.data
a dw ?
b dw ?

c db 10,13, 'Enter two digits:$'
d db 10,13,'Results:$'

.code
main proc
    mov ax,@data
    mov ds,ax
    
   mov ah,9
   lea dx,c
   int 21h
   
   mov ah,1
   int 21h
   sub al,48
   mov ah,al
   
   mov ah,1
   int 21h
   sub al,48
   mov bh,al
   
   mov ax,a
   div b
   
   mov ah,9
   lea dx,d
   int 21h
   mov ah,2
   
   mov dl,ah 
   add dl,48
   int 21h 
   
   exit:
   mov ah,4ch
   int 21h
   main endp
end main
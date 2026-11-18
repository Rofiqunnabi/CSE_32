  .model small
  .stack 100h
  .data
  a db 'Enter first digit: $'
  b db 10,13, 'Enter second digit: $'
  c db 10,13,'Enter third digit: $'
  d db 10,13,'Enter forth digit: $'
  e db 10,13,'RESULT : $'
  
  one db ?
  two db ?
  
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
    
    mov ah,9
    lea dx,d
    int 21h
    
    mov ah,1
    int 21h
    mov ch,al
    
    add bl,bh
    sub bl,48 
    mov one,bl
    
    add one,cl
    sub one,48
     
     mov bl,one
     
     add bl,ch
     sub bl,48
     mov two,bl
   
    
    
    mov ah,9
    lea dx,e
    int 21h
    
    mov ah,2
    mov dl,two
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
  end main
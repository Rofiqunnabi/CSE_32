  .model small
  .stack 100h
  .data
  str db 'MARKRAM$'
  len equ $-str  
  msg1 db 10,13,'Palindrome$'
  msg2 db 10,13,'Not Palindrome$'
  
  .code
  main proc
    mov ax,@data
    mov ds,ax
    
    lea si, str
    mov cx,len
 
    lea di,str+(len-1)
    
    check:
    mov al,[si]
    mov bl,[di]
    cmp al,bl
    jne not_pal
    inc si
    dec di
    loop check
    
    mov ah,9
    lea dx,msg1
    int 21h 
    jmp exit
    
    not_pal:
    mov ah,9
    lea dx,msg2
    int 21h 
    
    exit:
             
             mov ah,4ch
             int 21h
             main endp
  end main
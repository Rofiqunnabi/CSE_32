  .model small
  .stack 100h
  .data
  msg db 'Hi am Antor $'
  
  .code
  main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,msg
    int 21h   
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
   
     ;loop concept:
    mov cx,26
    mov ah,2
    mov dl,'Z'
    
    level1:
    int 21h
    dec dl
    loop level1
    
    exit:
    mov ah,4ch
    int 21h
    main endp
  end main
    
    
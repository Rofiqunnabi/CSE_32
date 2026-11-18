      .model small
      .stack 100h
      .data
      msg db 'I am ANTOR $'
      .code
      main proc
        mov ax,@data
        mov ds,ax
         ;func: 9->character string output:
        mov ah,9
        lea dx,msg
        int 21h
        
        ;new line print   :
        
        mov ah,2
        mov dl,10
        int 21h
        mov dl,13
        int 21h
        
        ;func: 1->single character input:
        
        mov ah,1
        int 21h
        mov bl,al 
        
        ;newline:
        mov ah,2
        mov dl,10
        int 21h
        mov dl,13
        int 21h
        
        
        ;func: 2->single character output:
        
        mov ah,2
        mov dl,bl
        int 21h
        
        exit:
        mov ah,4ch
        int 21h
        main endp
      end main
        
        
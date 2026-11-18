                   .MODEL SMALL
.STACK 100h

.DATA
msg1     DB 'Enter a number (1-255): $'
msgPrime DB 0DH,0AH,'Number is Prime.$'
msgNot   DB 0DH,0AH,'Number is Not Prime.$'
input    DB 4,0,4 DUP(0)     ; DOS buffered input
num      DB ?                ; store N

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ; -------- Prompt user --------
    LEA DX,msg1
    MOV AH,9
    INT 21h

    ; -------- Read input --------
    MOV AH,0Ah
    LEA DX,input
    INT 21h

    ; Convert ASCII to number
    MOV AL,input+2
    SUB AL,'0'           ; convert ASCII -> number
    MOV num,AL

    ; Check if N < 2 -> Not Prime
    CMP AL,2
    JB NOT_PRIME

    MOV BL,2             ; divisor = 2

CHECK_DIV:
    MOV AL,num
    XOR AH,AH
    DIV BL               ; AL = num / BL, AH = remainder
    CMP AH,0
    JE NOT_PRIME         ; divisible -> not prime
    INC BL
    MOV AL,num
    CMP BL,AL
    JB CHECK_DIV         ; BL < num -> continue

    ; If we reach here -> prime
    LEA DX,msgPrime
    MOV AH,9
    INT 21h
    JMP EXIT_PROGRAM

NOT_PRIME:
    LEA DX,msgNot
    MOV AH,9
    INT 21h

EXIT_PROGRAM:
    MOV AH,4Ch
    INT 21h

MAIN ENDP
END MAIN

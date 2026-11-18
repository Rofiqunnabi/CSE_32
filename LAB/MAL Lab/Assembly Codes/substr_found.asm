; Simple substring check (MASM/TASM - 8086)
.MODEL SMALL
.STACK 100H

.DATA
 msg1    DB 'Enter first string: $'
 msg2    DB 0DH,0AH,'Enter second string: $'
 msgFound   DB 0DH,0AH,'Substring found!$'
 msgNotFound DB 0DH,0AH,'Substring not found!$'

 ; DOS buffered input: max 50 chars
 str1 DB 50, ?, 50 DUP('$')
 str2 DB 50, ?, 50 DUP('$')

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ; Read first string
    LEA DX, msg1
    MOV AH, 9
    INT 21h

    MOV AH, 0Ah
    LEA DX, str1
    INT 21h

    ; Read second string
    LEA DX, msg2
    MOV AH, 9
    INT 21h

    MOV AH, 0Ah
    LEA DX, str2
    INT 21h

    ; Get lengths: len1 in AL, len2 in BL
    MOV AL, [str1 + 1]   ; length of str1
    MOV BL, [str2 + 1]   ; length of str2

    ; If second string longer -> not found
    CMP AL, BL
    JB  NOTFOUND

    ; Compute number of start positions: CX = len1 - len2 + 1
    MOV CL, AL
    MOV CH, 0
    SUB CL, BL
    INC CL             ; now CX = len1 - len2 + 1

    LEA SI, str1 + 2   ; SI -> first char of str1

OUTER_LOOP:
    ; BX used as pointer into str1 for comparison (copy of SI)
    MOV BX, SI
    LEA DI, str2 + 2   ; DI -> first char of str2
    MOV DL, [str2 + 1] ; DL = remaining length to match (len2)

INNER_LOOP:
    MOV AL, [BX]       ; char from str1
    MOV AH, [DI]       ; char from str2
    CMP AL, AH
    JNE  NO_MATCH
    INC BX
    INC DI
    DEC DL
    JNZ INNER_LOOP     ; continue until DL == 0

    ; if we reach here, DL == 0 => full match
    JMP FOUND

NO_MATCH:
    INC SI             ; advance start position in str1
    LOOP OUTER_LOOP    ; decrement CX and repeat if not zero

NOTFOUND:
    LEA DX, msgNotFound
    MOV AH, 9
    INT 21h
    JMP END_PROG

FOUND:
    LEA DX, msgFound
    MOV AH, 9
    INT 21h

END_PROG:
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN

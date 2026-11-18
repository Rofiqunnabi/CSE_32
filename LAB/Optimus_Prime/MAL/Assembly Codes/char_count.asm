                                        ; Count vowels, consonants, digits, and spaces in a string
; Assembler: MASM/TASM (8086 real mode)

.MODEL SMALL
.STACK 100H

.DATA
msg1    DB 'Enter a line: $'
msg2    DB 0DH,0AH,'Vowels: $'
msg3    DB 0DH,0AH,'Consonants: $'
msg4    DB 0DH,0AH,'Digits: $'
msg5    DB 0DH,0AH,'Spaces: $'

buffer  DB 255,?,255 DUP('$')   ; input buffer

; Counters
vowels      DW 0
consonants  DW 0
digits      DW 0
spaces      DW 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt for input
    LEA DX, msg1
    MOV AH, 9
    INT 21H

    ; Read input string (DOS 0Ah)
    MOV AH, 0Ah
    LEA DX, buffer
    INT 21H

    ; SI points to first character
    LEA SI, buffer+2
    MOV CL, [buffer+1]   ; number of characters
    MOV CH, 0

CHECK_LOOP:
    JCXZ DISPLAY_RESULTS ; if no chars, done

    MOV AL, [SI]         ; get character

    ; Check for space
    CMP AL, ' '
    JE IS_SPACE

    ; Check digit '0'-'9'
    CMP AL, '0'
    JB CHECK_LETTER
    CMP AL, '9'
    JA CHECK_LETTER
    ; It's a digit
    INC digits
    JMP NEXT_CHAR

CHECK_LETTER:
    ; Convert to uppercase (ignore case)
    CMP AL, 'a'
    JB UPPER_OK
    CMP AL, 'z'
    JA UPPER_OK
    SUB AL, 20H          ; make it uppercase
UPPER_OK:
    CMP AL, 'A'
    JB NEXT_CHAR
    CMP AL, 'Z'
    JA NEXT_CHAR

    ; Check vowel
    CMP AL, 'A'
    JE IS_VOWEL
    CMP AL, 'E'
    JE IS_VOWEL
    CMP AL, 'I'
    JE IS_VOWEL
    CMP AL, 'O'
    JE IS_VOWEL
    CMP AL, 'U'
    JE IS_VOWEL

    ; Otherwise consonant
    INC consonants
    JMP NEXT_CHAR

IS_VOWEL:
    INC vowels
    JMP NEXT_CHAR

IS_SPACE:
    INC spaces

NEXT_CHAR:
    INC SI
    LOOP CHECK_LOOP

DISPLAY_RESULTS:
    ; Print Vowels
    LEA DX, msg2
    MOV AH, 9
    INT 21H
    MOV AX, vowels
    CALL PRINT_NUM

    ; Print Consonants
    LEA DX, msg3
    MOV AH, 9
    INT 21H
    MOV AX, consonants
    CALL PRINT_NUM

    ; Print Digits
    LEA DX, msg4
    MOV AH, 9
    INT 21H
    MOV AX, digits
    CALL PRINT_NUM

    ; Print Spaces
    LEA DX, msg5
    MOV AH, 9
    INT 21H
    MOV AX, spaces
    CALL PRINT_NUM

    ; Exit
    MOV AH, 4Ch
    INT 21H
MAIN ENDP

; ---------------------------
; PRINT_NUM: print AX as decimal
; ---------------------------
PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX, CX        ; digit count
    MOV BX, 10

PRINT_LOOP:
    XOR DX, DX
    DIV BX            ; AX ÷ 10
    PUSH DX           ; remainder
    INC CX
    CMP AX, 0
    JNE PRINT_LOOP

PRINT_DIGITS:
    POP DX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    LOOP PRINT_DIGITS

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

END MAIN

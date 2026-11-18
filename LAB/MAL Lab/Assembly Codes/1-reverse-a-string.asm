.MODEL SMALL
.STACK 100H
.DATA

; The string to be printed
STRING DB 'This is a sample string', '$'

.CODE
MAIN PROC 


				
	EXIT:
	; add $ to the end of string
	MOV [SI],'$ '
	RET
		
REVERSE ENDP
END MAIN

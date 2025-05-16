                                                    .MODEL SMALL
.STACK 100H
.DATA
    TEXT DB '8ELLO$'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    ; Push letters
    MOV SI,0
    MOV CX,5
PUSH_CHARS:
    MOV AL,TEXT[SI]
    PUSH AX
    ADD SI,1
    LOOP PUSH_CHARS
    
    ; Pop letters to reverse
    MOV DI,0
    MOV CX,5
POP_CHARS:
    POP AX
    MOV TEXT[DI],AL
    ADD DI,1
    LOOP POP_CHARS
    
    ; Display
    MOV AH,9
    LEA DX,TEXT
    INT 21H
    
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
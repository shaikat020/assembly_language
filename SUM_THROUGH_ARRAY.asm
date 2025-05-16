.MODEL SMALL
.STACK 100H
.DATA
    NUMBERS DB 0,20,60,30,1
    TOTAL DB 0
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV SI,0
    MOV AL,0      
    MOV CX,5      
    
    SUM_LOOP:
        ADD AL,NUMBERS[SI]          
        INC SI                    ; Next word
        LOOP SUM_LOOP           ; Repeat
    
    
        MOV TOTAL,AL
    
    
    MOV AH,0
    MOV BL,10
    DIV BL
    
    ADD AL,30H
    MOV DL,AL
    MOV AH,02H
    INT 21H
    
    MOV AL,AH
    ADD AL,30H
    MOV DL,AL
    MOV AH,02H
    INT 21H
    
    EXIT:
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
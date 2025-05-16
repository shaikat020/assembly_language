.MODEL SMALL
.STACK 100H
.DATA
    A DB 3
    B DB 6
    RESULT1 DB 7
    RESULT2 DB 7
    
.CODE
MAIN:

    MOV AX, @DATA
    MOV DS,AX
    
    MOV AL, A
    MOV BL, B
    
    PUSH AX
    PUSH BX
    
    POP DX
    POP CX
    
    MOV RESULT1,CL
    MOV RESULT2,DL             
    
    MOV AL, RESULT1
    ADD AL, 30H
    MOV DL, AL
    MOV AH, 2H
    INT 21H
    
    MOV DL, ' '
    MOV AH, 2H
    INT 21H   
    
    MOV AL, RESULT2
    ADD AL, 30H
    MOV DL, AL
    MOV AH, 2H 
    INT 21H
    
    EXIT:
    MOV AH, 4CH
    INT 21H
    
END MAIN
    
                               
                               
INCLUDE "EMU8086.INC"
.MODEL SMALL              
.DATA
.STACK 100H
.CODE

MAIN PROC
    
    MOV CX, 10
    
    MOV AH, 2
    MOV DL, 30H
    
    PRINT:
    INT 21H
    
    PRINTN ""
    
    INC DL                                                                   
    LOOP PRINT
    
    EXIT:
    MOV AH, 4CH
    INT 21H
    MAIN ENDP

END MAIN
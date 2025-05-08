.MODEL SMALL

.STACK 100H

.DATA 

char1 DB 'X'
num1 DB 9        
msg DB 'HI ASSEMBLY$'

.CODE

MAIN PROC
            
    MOV AX,@DATA
    MOV DS,AX
    
    ;INPUT
    ;MOV AH, 1H
    ;INT 21H 
    
    ;MOV AH, 1H
    ;INT 21H  
    ;MOV char1,AL
      
                
    ;MOV DL, char1                
    ;MOV AH, 2H  
    ;INT 21H
    
    ;FOR PRINT NUMBER
    ;MOV AL, num1
    ;ADD AL, 30H
    ;MOV DL, AL
    ;MOV AH, 2H
    ;INT 21H
    
    ;OUTPUT
    ;MOV AH,2
    ;MOV DL,'M'
    ;INT 21H
     
    
    ;PRINT STRING   
    MOV AH, 9H
    LEA DX, msg
    INT 21H
    
    
    MOV AH, 4CH
    INT 21H
    
    MAIN ENDP

END MAIN
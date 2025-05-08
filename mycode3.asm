INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H
.DATA
    prompt DB "Enter a number (0-8): $"
    result_msg DB 10, 13, "Factorial is: $"
    n DB ?          ; 8-bit input
    factorial DW 1  ; 16-bit result

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Print input prompt
    MOV AH, 9
    LEA DX, prompt
    INT 21H
                                                                
    ; Read single digit input (0-8)
    MOV AH, 1
    INT 21H
    SUB AL, '0'     ; Convert ASCII to number
    MOV n, AL       ; Store in n (8-bit)

    ; Calculate factorial
    MOV CX, 0       ; Clear CX (16-bit register)
    MOV CL, n       ; Move 8-bit n to CL (lower half of CX)
    CMP CX, 0       ; Check if n=0 (0! = 1)
    JE PRINT_RESULT

    MOV AX, 1       ; Initialize result (AX = 1)

FACT_LOOP:
    MUL CX          ; AX = AX * CX
    LOOP FACT_LOOP  ; Decrement CX and loop if not zero

    MOV factorial, AX ; Store result

PRINT_RESULT:
    ; Print result message
    MOV AH, 9
    LEA DX, result_msg
    INT 21H

    ; Print the factorial number
    MOV AX, factorial
    CALL PRINT_NUM

    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; Helper procedure to print number in AX
PRINT_NUM PROC
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV CX, 0       ; Digit counter
    MOV BX, 10      ; Base 10 divisor

PUSH_DIGITS:
    XOR DX, DX      ; Clear DX for division
    DIV BX          ; AX = AX/10, DX = remainder
    PUSH DX         ; Save digit
    INC CX          ; Count digits
    CMP AX, 0       ; Continue until AX=0
    JNE PUSH_DIGITS

POP_DIGITS:
    POP DX          ; Get digit
    ADD DL, '0'     ; Convert to ASCII
    MOV AH, 2       ; Print character
    INT 21H
    LOOP POP_DIGITS ; Repeat for all digits
    
    POP DX
    POP CX
    POP BX
    RET
PRINT_NUM ENDP

END MAIN
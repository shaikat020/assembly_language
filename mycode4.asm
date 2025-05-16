.MODEL SMALL
.STACK 100H

.DATA
    msg8  DB '8-bit value (DL): $'
    msg16 DB 13, 10, '16-bit value (DX): $'
    nl    DB 13, 10, '$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; --- First Value (8-bit): 02h ---
    MOV AL, 2
    MOV AH, 0         ; Make it 16-bit value in AX
    PUSH AX           ; Push 16-bit AX to stack

    ; --- Print msg8 ---
    MOV AH, 9
    LEA DX, msg8
    INT 21H

    ; --- POP AX ---
    POP AX            ; Retrieve value into AX
    MOV DL, AL        ; Get 8-bit value (low byte)
    ADD DL, '0'       ; Convert to ASCII for display
    MOV AH, 2
    INT 21H

    ; New line
    MOV AH, 9
    LEA DX, nl
    INT 21H

    ; --- Second Value (16-bit): 1234h ---
    MOV AX, 1234h
    PUSH AX

    ; --- Print msg16 ---
    MOV AH, 9
    LEA DX, msg16
    INT 21H

    ; --- POP AX ---
    POP DX            ; 16-bit value in DX
    CALL PRINT_HEX    ; Print DX in hex

    ; --- Exit ---
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; ===== PRINT_HEX: Prints 16-bit value in DX =====
PRINT_HEX PROC
    MOV CX, 4          ; 4 hex digits
PRINT_NEXT:
    ROL DX, 4          ; Rotate left 4 bits
    MOV AL, DL         ; Copy lower 4 bits
    AND AL, 0FH        ; Mask upper bits
    ADD AL, 30H        ; Convert 0-9 to ASCII
    CMP AL, '9'
    JBE PRINT_CHAR
    ADD AL, 7          ; Convert A-F
PRINT_CHAR:
    MOV DL, AL
    MOV AH, 2
    INT 21H
    LOOP PRINT_NEXT
    RET
PRINT_HEX ENDP

END MAIN
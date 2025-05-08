.model small
.stack 100h

.data
    prompt db 'You: $'
    bot db 'Bot: $'
    newline db 13, 10, '$'
    hello db 'hello$'
    hello_response db 'Hi there!$'
    howareyou db 'how are you$'
    how_response db "I'm just a simple bot!$"
    default_response db "I don't understand that yet.$"
    buffer db 255        ; max length
          db ?          ; actual length
          db 255 dup(?)  ; input buffer
    input db '$'         ; for adding terminator

.code
main proc
    mov ax, @data
    mov ds, ax
    
main_loop:
    ; Print prompt
    mov ah, 09h
    mov dx, offset prompt
    int 21h
    
    ; Read input
    mov ah, 0Ah
    mov dx, offset buffer
    int 21h
    
    ; Process input
    call process_input
    
    ; Repeat
    jmp main_loop
    
    ; Exit
    mov ah, 4Ch
    int 21h
main endp

process_input proc
    ; Convert input to $ terminated string
    mov si, offset buffer + 1
    mov cl, [si]        ; get length
    mov ch, 0
    mov si, offset buffer + 2
    add si, cx
    mov byte ptr [si], '$'
    
    ; Print newline
    mov ah, 09h
    mov dx, offset newline
    int 21h
    
    ; Compare with 'hello'
    mov si, offset buffer + 2
    mov di, offset hello
    call strcmp
    je respond_hello
    
    ; Compare with 'how are you'
    mov si, offset buffer + 2
    mov di, offset howareyou
    call strcmp
    je respond_how
    
    ; Default response
    mov ah, 09h
    mov dx, offset bot
    int 21h
    
    mov ah, 09h
    mov dx, offset default_response
    int 21h
    
    mov ah, 09h
    mov dx, offset newline
    int 21h
    
    ret
    
respond_hello:
    ; Respond to hello
    mov ah, 09h
    mov dx, offset bot
    int 21h
    
    mov ah, 09h
    mov dx, offset hello_response
    int 21h
    
    mov ah, 09h
    mov dx, offset newline
    int 21h
    
    ret
    
respond_how:
    ; Respond to how are you
    mov ah, 09h
    mov dx, offset bot
    int 21h
    
    mov ah, 09h
    mov dx, offset how_response
    int 21h
    
    mov ah, 09h
    mov dx, offset newline
    int 21h
    
    ret
process_input endp

strcmp proc
compare_loop:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne not_equal
    cmp al, '$'
    je equal
    inc si
    inc di
    jmp compare_loop
equal:
    xor ax, ax
    ret
not_equal:
    mov ax, 1
    ret
strcmp endp

end main
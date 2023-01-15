assume cs:code

code segment
start:  mov ax,4c00h
        int 21h

add128: ;this function can ADD 2 128-bit(8-word, 16-byte) numbers
        ;para: ds:si point the RAM space of first number; ds:di point the RAM space of second number;
        ;return value: result store in the space of first number
        push ax
        push bx
        push si
        push di

        sub ax,ax ;set CF to 0

        mov cx,8
      s:mov ax,[si]
        adc ax,[di]
        mov [si],ax

        inc si
        inc si
        inc di
        inc di ;inc here can't be replaced by "add si,2" or "add di,2"!
        loop s

        pop di
        pop si
        pop bx
        pop ax
        ret

code ends
end start
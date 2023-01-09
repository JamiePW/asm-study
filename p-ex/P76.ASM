assume cs:code,ds:data

data segment
        db 'BaSiC'
        db 'MinIX'
data ends

code segment
start:  mov ax,data
        mov ds,ax

        sub bx,bx
        mov cx,5

      s:mov al,[bx]
        and al,11011111b
        mov [bx],al
        mov al,5[bx]
        or al,00100000b
        mov 5[bx],al
        inc bx
        loop s

        mov ax,4c00h
        int 21h
code ends
end start

assume cs:code
code segment
        mov ax,0020h
        mov ds,ax
        mov cx,64
        sub bx,bx

      s:mov [bx],bl
        inc bx
        loop s

        mov ax,4c00h
        int 21h
code ends
end


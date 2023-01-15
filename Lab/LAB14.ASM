assume cs:code

code segment
start:  mov bx,0b80ah
        mov es,bx
        mov di,160*12+30*2

        ;year
        mov al,9
        out 70h,al
        in al,71h
        call disb
        mov byte ptr es:[di],2fh
        mov byte ptr es:[di+1],2
        add di,2

        ;month
        mov al,8
        out 70h,al
        in al,71h
        call disb
        mov byte ptr es:[di],2fh
        mov byte ptr es:[di+1],2
        add di,2

        ;day
        mov al,7
        out 70h,al
        in al,71h
        call disb
        mov byte ptr es:[di],20h
        mov byte ptr es:[di+1],2
        add di,2

        ;hour
        mov al,4
        out 70h,al
        in al,71h
        call disb
        mov byte ptr es:[di],3ah
        mov byte ptr es:[di+1],2
        add di,2

        ;minute
        mov al,2
        out 70h,al
        in al,71h
        call disb
        mov byte ptr es:[di],3ah
        mov byte ptr es:[di+1],2
        add di,2

        ;second
        mov al,0
        out 70h,al
        in al,71h
        call disb

        mov ax,4c00h
        int 21h

   disb:mov ah,al
        mov cl,4
        shr ah,cl
        and al,00001111b

        add ah,30h
        add al,30h

        mov byte ptr es:[di],ah
        mov byte ptr es:[di+1],2
        mov byte ptr es:[di+2],al
        mov byte ptr es:[di+3],2

        add di,4
        ret

code ends
end start

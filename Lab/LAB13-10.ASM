assume cs:code

code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset showstr

        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset showend-offset showstr
        cld
        rep movsb

        mov ax,0
        mov es,ax
        mov word ptr es:[7ch*4],200h
        mov word ptr es:[7ch*4+2],0

        mov ax,4c00h
        int 21h

showstr:push ax

        mov ax,0b80ah
        mov es,ax
        mov di,0

        mov al,160
        mul dh
        add di,ax
        mov al,2
        mul dl
        add di,ax

        mov ah,cl
      s:mov al,ds:[si]
        cmp al,0
        je ok
        mov es:[di],ax
        inc si
        add di,2
        jmp short s

     ok:pop ax
        iret
showend:nop

code ends
end start




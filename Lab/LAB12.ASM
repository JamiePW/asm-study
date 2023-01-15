assume cs:code

code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset do0
        mov ax,0
        mov es,ax
        mov di,200h ;store code in 0:200

        mov cx,offset do0end-offset do0

        cld     ;transportation direction is positive
        rep movsb

        ;set interrupt vector table
        mov ax,0
        mov es,ax
        mov word ptr es:[0*4],200h
        mov word ptr es:[0*4+2],0

        mov ax,4c00h
        int 21h

    do0:jmp short do0start
        db "overflow!"

    do0start:
        mov ax,cs
        mov ds,ax
        mov si,202h ;set ds:si point at the string

        mov ax,0b800h
        mov es,ax
        mov di,12*160+36*2 ;set es:di point at the display RAM

        mov cx,9
      s:mov al,[si]
        mov es:[di],al
        inc si
        add di,2
        loop s

        mov ax,4c00h
        int 21h

 do0end:nop

 code ends
 end start
assume cs:code,ds:data

data segment
        db 'welcome to masm!'
        db 02h,24h,71h
data ends

code segment
start:  mov ax,data
        mov ds,ax

        mov ax,0b800h
        mov es,ax

    s0: mov cx,16
        mov bx,0
        mov bp,6e0h
        mov di,3eh

      s:mov al,[bx]

        mov ah,dS:[16]
        mov es:[bp+di],ax

        mov ah,dS:[17]
        mov es:[bp+di+160],ax

        mov ah,dS:[18]
        mov es:[bp+di+320],ax

        inc bx
        add di,2
        loop s

        ;jmp s0

        mov ax,4c00h
        int 21h
code ends
end start



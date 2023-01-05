assume cs:code,ds:data

data segment
        db 77h,02h,65h,02h,6ch,02h,63h,02h,6fh,02h,6dh,02h,65h,02h,20h,02h,74h,02h,6fh,02h,20h,02h,6dh,02h,61h,02h,73h,02h,6dh,02h,21h,02h
        db 77h,24h,65h,24h,6ch,24h,63h,24h,6fh,24h,6dh,24h,65h,24h,20h,24h,74h,24h,6fh,24h,20h,24h,6dh,24h,61h,24h,73h,24h,6dh,24h,21h,24h
        db 77h,71h,65h,71h,6ch,71h,63h,71h,6fh,71h,6dh,71h,65h,71h,20h,71h,74h,71h,6fh,71h,20h,71h,6dh,71h,61h,71h,73h,71h,6dh,71h,21h,71h
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

      s:mov ax,[bx]
        mov es:[bp+di],ax

        mov ax,[bx+32]
        mov es:[bp+di+160],ax

        mov ax,[bx+64]
        mov es:[bp+di+320],ax

        add bx,2
        add di,2
        loop s

        ;jmp s0

        mov ax,4c00h
        int 21h
code ends
end start



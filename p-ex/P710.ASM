assume cs:code,ds:data

data segment
        db 'ibm             '
        db 'dec             '
        db 'dos             '
        db 'vax             '
data ends

code segment
start:  mov ax,data
        mov ds,ax

        mov bx,0

        mov cx,4

     s0:mov dx,cx ;save the value of cx of outside loop in dx
        mov cx,3
        mov si,0

      s:mov al,[bx+si]
        and al,11011111b
        mov [bx+si],al
        inc si
        loop s

        add bx,16 ;move to the next data segemnt
        mov cx,dx
        loop s0

        mov ax,4c00h
        int 21h
code ends
end start


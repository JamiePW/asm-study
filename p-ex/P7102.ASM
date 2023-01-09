assume cs:code,ds:data,ss:stack

data segment
        db 'ibm             '
        db 'dec             '
        db 'doc             '
        db 'vax             '
data ends

stack segment
        dw 0,0,0,0,0,0,0,0
stack ends

code segment
start:  mov ax,data
        mov ds,ax

        mov ax,stack
        mov ss,ax
        mov sp,16

        mov bx,0
        mov cx,4

      s:push cx
        mov cx,3
        mov si,0

     s0:mov al,[bx+si]
        and al,11011111b
        mov [bx+si],al
        inc si
        loop s0

        add bx,16
        pop cx
        loop s

        mov ax,4c00h
        int 21h
code ends
end start


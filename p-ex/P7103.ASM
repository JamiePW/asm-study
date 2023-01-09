assume cs:code,ds:data,ss:stack

data segment
        db '1. display      '
        db '2. brows        '
        db '3. replace      '
        db '4. modify       '
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
        mov cx,4
        mov si,0

     s0:mov al,[bx+si+3]
        and al,11011111b
        mov [bx+si+3],al
        inc si
        loop s0

        pop cx
        add bx,16
        loop s

        mov ax,4c00h
        int 21h
code ends
end start

        

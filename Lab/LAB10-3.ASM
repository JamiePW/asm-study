assume cs:code,ds:data,ss:stack

data segment
    db 16 dup (15)
data ends

stack segment
    db 32 dup (0)
stack ends

code segment
start:  mov ax,12666
        mov bx,data
        mov ds,bx
        mov si,0
        mov bx,stack
        mov ss,bx
        mov sp,32
        call dtoc

        mov si,0
        mov dh,8
        mov dl,3
        mov cl,2
        call show_str

        mov ax,4c00h
        int 21h

dtoc:   ;this funtion transfer a DEC number(word type) to a string(end with 0)
        ;para: ax: DEC number; ds:si point at the head of string
        ;no return value
        push ax
        push dx
        push cx

        mov cx,10
        mov dx,0
        push dx ;put a 0 in bottom so that we can identify the end of string

        transin:

        div cx
        add dx,30h ;store ascii code
        push dx
        mov dx,0
        mov cx,ax
        jcxz transout
        mov cx,10
        jmp short transin

        transout:

        pop cx
        jcxz transok
        mov ds:[si],cl
        inc si
        jmp short transout

        transok:

        mov cx,0
        mov ds:[si],cx ;put in a 0 to mark the end of the string
        pop cx
        pop dx
        pop ax
        ret

show_str: 
        push ax
        push bx
        push cx

        mov al,10
        mul dh
        add ax,0b80Ah ;caculate the segment address of line
        mov es,ax

        mov bl,dl
        mov bh,0
        add bx,bx ;display a byte costs 2 bytes space

        mov ah,cl
        mov ch,0
   show:mov cl,ds:[si]
        jcxz ok
        mov al,cl
        mov es:[bx],ax
        inc si
        add bx,2
        jmp short show

     ok:pop cx
        pop bx
        pop ax
        ret

code ends
end start
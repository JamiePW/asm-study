assume cs:code,ds:data,ss:stack

data segment
        db 'Welcome to masm!',0 ;zero marks the end of the string
data ends

stack segment
        db 16 dup (0)
stack ends

code segment
start:  mov ax,data
        mov ds,ax
        mov ax,stack
        mov ss,ax
        mov sp,16
        mov si,0 ;ds:si point at first byte of string

        mov dh,8 ;line number (0-24)
        mov dl,3 ;column number (0-79)
        mov cl,2 ;color setting byte
        call show_str

        mov ax,4c00h
        int 21h

show_str: ;this funtion display a particular string end with 0 in particular position
        ;para: dh: line number (0-24); dl: column number (0-79); cl: color setting byte; ds:di point at first byte of string
        ;no return value
        push ax
        push bx
        push cx

        mov al,10
        inc dh
        mul dh
        add ax,0b800h ;caculate the segment address of line
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

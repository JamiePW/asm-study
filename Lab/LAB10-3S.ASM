assume cs:code,ds:data,ss:stack

data segment
    dd 5937000
    db 12 dup (15)
data ends

stack segment
    db 32 dup (0)
stack ends

code segment
start:  mov ax,data
        mov ds,ax
        mov si,0
        mov ax,stack
        mov ss,ax
        mov sp,32

        mov ax,ds:[si]
        mov dx,ds:[si+2]
        mov si,4
        call dtoc2

        mov si,4
        mov dh,8
        mov dl,3
        mov cl,2
        call show_str

        mov ax,4c00h
        int 21h

dtoc2:  ;this funtion transfer a DEC number(double word type) to a string(end with 0)
        ;para: ax: lower bits of DEC number; dx: higher bits of DEC number; ds:si point at the head of string
        ;no return value
        ;note: this funtion also suitable for word type DEC number, just set dx 0
        push ax
        push dx
        push cx

        mov cx,0
        push cx ;put a 0 in bottom so that we can identify the end of string

        transin:

        mov cx,10
        call divdw
        add cx,30h
        push cx
        mov cx,dx
        jcxz dx0
        jmp short transin

    dx0:mov cx,ax
        jcxz transout
        jmp short transin
        
        transout:

        pop cx
        jcxz transok
        mov ds:[si],cl
        inc si
        jmp short transout


        transok:
        mov cl,0
        mov ds:[si],cl
        pop cx
        pop dx
        pop ax
        ret

divdw:  ;this funtion execute dword division without overflow
        ;para: ax: low bits; dx: high bits; cx: divisor
        ;return values: ax: low bits, dx: high bits, cx: remainder
        push bx

        push ax
        mov ax,dx
        mov dx,0
        div cx

        mov bx,ax ;temporarily store the result of higher bits
        
        pop ax ;the remainder of last div automatically store in dx
        div cx

        mov cx,dx
        mov dx,bx

        pop bx
        ret

show_str: 
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
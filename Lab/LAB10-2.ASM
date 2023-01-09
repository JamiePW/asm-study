assume cS:code,ss:stack

stack segment
    db 16 dup (0)
stack ends

code segment
start:  mov ax,stack
        mov ss,ax
        mov sp,16

        mov ax,4240h ;low bits
        mov dx,000fh ;high bits
        mov cx,0ah   ;divisor
        call divdw

        mov ax,4c00h
        int 21h

divdw:  ;this funtion execute dword division without overflow
        ;para: ax: low bits; dx: high bits; cx: remainder
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

        
code ends
end start

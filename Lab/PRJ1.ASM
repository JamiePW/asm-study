assume cs:code,ds:data,ss:stack

data segment
        db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
        db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
        db '1993','1994','1995'
        ;21 years, 84 bytes

        dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
        dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
        ;total income, 84 bytes

        dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
        dw 11542,14430,15257,17800
        ;total stuff number, 42 bytes

        db 16 dup (0)
        ;space for string

        dw 5,3,42,104,85,210,123,111,105,125,140,136,153,211,199,209,224,239,260,304,333
        ;average income of the year
data ends

stack segment
    db 32 dup (0)
stack ends

code segment
start:  mov ax,data
        mov ds,ax
        mov di,0
        mov ax,stack
        mov ss,ax

        ;use es:[bp+si+idata] for display RAM
        mov ax,0b80Ah
        mov es,ax
        mov bp,0
        mov si,0

        mov cx,21
        mov ah,2
    
        ;this part display the years
   disY:push cx 
        mov si,0
        mov cx,4

        disY1:
                mov al,ds:[di]
                mov es:[bp+si],ax
                inc di
                add si,2
                loop disY1

        add bp,160
        pop cx
        loop disY

        ;this part display total income
        mov dx,0
        mov cx,21
        mov bx,84
   disI:push cx

        push dx
        mov ax,ds:[bx]
        mov dx,ds:[bx+2]
        mov si,210
        call dtoc2
        pop dx

        mov si,210
        mov dl,12
        mov cl,2
        call show_str
        
        add bx,4
        inc dh
        pop cx
        loop disI

        ;this part display stuff number
        mov dx,0
        mov cx,21
        mov bx,168
   disS:push cx
        
        push dx
        mov ax,ds:[bx]
        mov dx,0
        mov si,210
        call dtoc2
        pop dx

        mov si,210
        mov dl,22
        mov cl,2
        call show_str

        add bx,2
        inc dh
        pop cx
        loop disS

        ;this part display average income
        mov dx,0
        mov cx,21
        mov bx,226
   disA:push cx
        
        push dx
        mov ax,ds:[bx]
        mov dx,0
        mov si,210
        call dtoc2
        pop dx

        mov si,210
        mov dl,32
        mov cl,2
        call show_str

        add bx,2
        inc dh
        pop cx
        loop disA

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

show_str: ;this funtion display a particular string end with 0 in particular position
        ;para: dh: line number (0-24); dl: column number (0-79); cl: color setting byte; ds:di point at first byte of string
        ;no return value
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


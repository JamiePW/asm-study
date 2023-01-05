assume cs:code,ds:data

data segment
        db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
        db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
        db '1993','1994','1995'
        ;21 years

        dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
        dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
        ;total income

        dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
        dw 11542,14430,15257,17800
        ;total stuff number
data ends

table segment
        db 21 dup ('year summ ne ?? ')
table ends

code segment
start:  mov ax,data
        mov ds,ax

        mov ax,table
        mov es,ax

        mov bx,0
        mov bp,0
        mov si,0
        mov di,0
        ;'ds:bx+si' in data, 'es:bp+idata' in table
        ;ps. use 'bx+di' when deal with stuff number

        mov cx,21

      s:mov ax,ds:[bx+si]
        mov es:[bp],ax
        mov ax,ds:[bx+si+2]
        mov es:[bp+2],ax

        add bx,84
        mov ax,ds:[bx+si]
        mov dx,ds:[bx+si+2] ;store the dividend
        mov es:[bp+5],ax
        mov es:[bp+7],dx

        add bx,84
        div word ptr ds:[bx+di] ;div first
        mov es:[bp+0dh],ax
        mov ax,ds:[bx+di]
        mov es:[bp+0ah],ax

        mov bx,0
        add di,2
        add bp,16
        add si,4
        loop s

        mov ax,4c00h
        int 21h
code ends
end start


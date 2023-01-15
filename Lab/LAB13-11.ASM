assume cs:code,ds:data

data segment
    db "welcome to masm!",0
data ends

code segment
start:  mov dh,10   ;line number
        mov dl,10   ;column number
        mov cl,2    ;color
        mov ax,data
        mov ds,ax
        mov si,0    ;ds:si point at head of string
        int 7ch
        
        mov ax,4c00h
        int 21h
code ends
end start
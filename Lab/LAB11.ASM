assume cs:code,ds:data

data segment
    db "Beginner's All-purpose Symbolic Instruction Code.",0
data ends

code segment
start:  mov ax,data
        mov ds,ax
        mov si,0
        call letterc

        mov ax,4c00h
        int 21h

letterc:push ax

      s:cmp byte ptr ds:[si],0
        je ok
        cmp byte ptr ds:[si],61h
        jb next
        cmp byte ptr ds:[si],7ah
        ja next
        mov al,ds:[si]
        and al,11011111b
        mov ds:[si],al
   next:inc si
        jmp short s

     ok:pop ax
        ret

code ends
end start
      
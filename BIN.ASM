init_ds macro
mov ax,@data
mov ds,ax
endm

sort_ar macro
mov bx,n
dec bx
lp1: lea si,array
         mov cl,n
         dec cl
lp2: mov al,array[si];
         inc si
         cmp al,array[si]
         jc lp3
         xchg al,array[si]
         xchg al,array[si-1]
lp3:loop lp2
        dec bx
        jnz lp1

endm

print macro msg
mov ah,09h
lea dx,msg
int 21h
endm

disp_char macro pos
mov dl,pos
mov ah,02h
int 21h
endm

.model small
.stack
.data
array db 10h,12h,3h,16h,1h
n db $-array
key db 16h
pos db ?
msg1 db 10,13,"key is found at $"
msg2 db 10,13,"key not found $"

.code 
      init_ds
      sort_ar 
              ;binary search code
              mov bl,0;
              mov dl,n;
              dec dl
              mov al,key
             blp1: cmp bl,dl
                        ja ntfnd
                        mov cl,bl
                        add cl,dl
                        shr  cl,01
                        mov si,cl
                        cmp al,array[si]
                        jz fnd
                        ja shalf
              fhalf:mov dl,cl
                      dec dl
                      jmp blp1
         shalf:mov bl,cl
                      inc bl
                       jmp blp1
        ntfnd: print msg2
                      jmp ext
             fnd:print msg1
                       mov ax,si
                       add ax,30h
                       mov pos,al
                      disp_char pos
                      pop ax
             ext:mov ah,04ch
                     int 21h

end
          


; j:\c463\fa02\divFloat.asm
; External FAR Module for Prog03.asm

Extrn      Bin1:Word
Extrn      Bin2:Word
Extrn      Len1:Byte
Extrn      Len2:Byte
Extrn      Num1:Byte
Extrn      Num2:Byte
Extrn      FirstInt:Byte
Extrn      Divisor:Byte
Extrn      Sign:Byte
Extrn      Quotient:Byte 
Extrn      Remainder:Byte
Extrn      AnsMsg:Byte

Public     divFloat

	  .Model Small
	  .Code

divFloat   PROC  Far
; Input:   Num1 is Dividend (in ASCII characters)
;          Num2 is Divisor  (in ASCII characters)

; Input:   Bin1 is Dividend (in binary)
;          Bin2 is Divisor  (in binary)

           xor    cx,cx         ; move Num1 to Dividend
	   mov    cl,Len1
	   lea    si,Num1
	   lea    di,FirstInt
	   rep    movsb

           xor    cx,cx         ; move Num2 to Divisor
	   mov    cl,Len2
	   lea    si,Num2
	   lea    di,Divisor
	   rep    movsb

	   lea   si,Quotient
	   lea   di,Remainder
       
	   mov   ax,Bin1
	   mov   bx,Bin2

	   div   bl
	   push  bx
	   push  ax

	   cmp   al,99 
           ja    QMore99
	   cmp   al,9  
           ja    QMore9  

	   or    al,30h
	   mov   [si+2],al
	   jmp   CompRem  

QMore9:    xor   ah,ah
	   mov   bl,10
	   div   bl
	   or    al,30h
	   mov   [si+1],al
	   or    ah,30h
	   mov   [si+2],ah
	   jmp   CompRem  
	   
QMore99:   xor   ah,ah       ; e.g., al=123
           mov   bl,100      ;       bl=100 
           div   bl          ; Then, al=1 & ah=23  
	   or    al,30h
	   mov   [si],al

	   mov   al,ah
	   xor   ah,ah
	   mov   bl,10
	   div   bl
	   or    al,30h
	   mov   [si+1],al

	   or    ah,30h
	   mov   [si+2],ah

CompRem:   pop   ax
	   mov   al,ah
	   xor   ah,ah
	   mov   bl,10
	   mul   bl

	   pop   bx
	   push  bx

	   div   bl
	   or    al,30h
	   mov   [di],al

	   mov   al,ah
	   xor   ah,ah
	   mov   bl,10
	   mul   bl
	   pop   bx
	   div   bl
	   or    al,30h
	   mov   [di+1],al

	   lea    dx, AnsMsg
	   mov    ah, 09h
	   int    21h

	   ret
divFloat   ENDP
	   END          

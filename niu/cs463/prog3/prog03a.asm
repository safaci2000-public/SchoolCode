
; j:\c463\fa02\prog03a.asm

clear      MACRO  Field, size
	   xor    cx,cx
           mov    cl,size
	   mov    al,20h
           lea    di,Field
	   rep    stosb
           ENDM

Extrn      divFloat:Far
Public     Len1,Num1,Len2,Num2,Bin1,Bin2,AnsMsg,Dividend,Divisor
Public     Sign,Quotient,Remainder

           TITLE  Prog03a                  
	  .MODEL  SMALL
	  .STACK  100h

	  .DATA
PgmMsg     db  0dh,0ah
           db  "This Program simulates Floating-point Division.", "$"

EnterMsg1  db  0dh,0ah,0dh,0ah
	   db  "Enter Dividend in the range of -255 thru 255, now!",0dh,0ah
	   db  "To Exit, press <Enter> key only.", 0dh,0ah, "$"
EnterMsg2  db  0dh,0ah,0dh,0ah
	   db  "Enter Divisor in the range of 1 thru 255, now!",0dh,0ah
	   db  "To Exit, press <Enter> key only.", 0dh,0ah, "$"

InBuff1    db  05
Len1       db  00
Num1       db  20h,20h,20h,20h,0dh

InBuff2    db  04
Len2       db  00
Num2       db  20h,20h,20h,0dh

InvalMsg1  db  0dh,0ah 
	   db  "An Invalid Number was entered for Dividend!", 0dh,0ah, "$"
	   db  "Enter a Number in the range of -255 thru 255.", 0dh,0ah,"$"
InvalMsg2  db  0dh,0ah 
	   db  "An Invalid Number was entered for Divisor!", 0dh,0ah, "$"
	   db  "Enter a Number in the range of 1 thru 255.", 0dh,0ah,"$"

ZeroMsg    db  0dh,0ah
	   db  "The Zero was entered for Divisor!", 0dh,0ah, "$"
	   db  "Enter a Nonzero number in 1 thru 255.", 0dh,0ah, "$"

Factor     db  1,1,10,100

Bin1       dw  0000
Bin2       dw  0000

AnsMsg     db  0dh,0ah,0dh,0ah, "When the Dividend is "
Dividend   db  20h,20h,20h,20h, " and the Divisor is "
Divisor    db  20h,20h,20h
	   db  0dh,0ah, "the Result is "
Sign       db  20h
Quotient   db  20h,20h,20h,2eh
Remainder  db  20h,20h,0dh,0ah,"$"

ByeMsg     db  0dh,0ah, "Bye for Now!", 0dh,0ah, "$"


	  .CODE
MAIN       PROC
           mov   ax,@data
	   mov   ds,ax
	   mov   es,ax

	   lea   dx,PgmMsg
	   mov   ah,09h
	   int   21h

Start:     call  ClrStorage
	   call  GetDividnd 
	   call  ChkDividnd 
	   call  GetDivisor
	   call  ChkDivisor
           call  divFloat
	   jmp   Start
MAIN       ENDP


ClrStorage PROC
           clear Dividend,04         ; Clear Dividend field
           clear Divisor,03          ; Clear Divisor field
           clear Sign,04             ; Clear Sign & Quotient fields 
           clear Remainder,02        ; Clear Remainder field 
	   ret
ClrStorage ENDP


GetDividnd PROC
	   lea   dx,EnterMsg1
	   mov   ah,09h
	   int   21h

	   lea   dx,InBuff1
	   mov   ah,0ah
	   int   21h

	   xor   ch,ch
	   mov   cl,Len1

	   cmp   cl,00
	   je    Exit1
	   ret
	   
Exit1:     lea   dx,ByeMsg
	   mov   ah,09h
	   int   21h

	   mov   ah,4ch
	   int   21h
GetDividnd ENDP


ChkDividnd PROC
Again1:    lea   di,Factor

	   xor   dx,dx
	   xor   ax,ax
	   xor   ch,ch
	   mov   cl,Len1

	   lea   si,Num1
	   mov   al,[si]
	   cmp   al,'-'
	   je    LessZero

Rest1:     cmp   al,30h
	   jl    Inval1
	   cmp   al,39h
	   ja    Inval1

	   and   al,0Fh
	   push  di
	   add   di,cx
	   mov   bl,[di]
	   mul   bl
	   add   dx,ax
  
	   inc   si
	   pop   di
	   mov   al,[si]
	   loop  Rest1
	   
	   mov   Bin1,dx      
	   ret   

LessZero:  mov   ah,'-'
	   mov   Sign,ah
	   dec   cx 
	   inc   si
	   mov   al,[si]   
	   jmp   Rest1
	   
Inval1:    lea   dx,InvalMsg1
	   mov   ah,09h
	   int   21h

	   call  GetDividnd
	   jmp   Again1
ChkDividnd ENDP


GetDivisor PROC
	   lea   dx,EnterMsg2
	   mov   ah,09h
	   int   21h

	   lea   dx,InBuff2
	   mov   ah,0ah
	   int   21h

	   xor   ch,ch
	   mov   cl,Len2

	   cmp   cl,00
	   je    Exit2
	   ret
	   
Exit2:     lea   dx,ByeMsg
	   mov   ah,09h
	   int   21h

	   mov   ah,4ch
	   int   21h
GetDivisor ENDP


ChkDivisor PROC
Again2:    lea   di,Factor

	   xor   dx,dx
	   xor   ax,ax

	   xor   ch,ch
	   mov   cl,Len2

	   lea   si,Num2
Rest2:     mov   al,[si]
	   cmp   al,30h
	   jl    Inval2
	   cmp   al,39h
	   ja    Inval2

	   and   al,0Fh
	   push  di
	   add   di,cx
	   mov   bl,[di]
	   mul   bl
	   add   dx,ax
  
	   inc   si
	   pop   di
	   loop  Rest2

	   cmp   dx,0
	   je    ZeroErr
      
	   mov   Bin2,dx
	   ret

Inval2:    lea   dx,InvalMsg2
	   mov   ah,09h
	   int   21h

	   call  GetDivisor
	   jmp   Again2

ZeroErr:   lea   dx,ZeroMsg
	   mov   ah,09h
	   int   21h

	   call  GetDivisor
	   jmp   Again2
ChkDivisor ENDP
	   END   Main

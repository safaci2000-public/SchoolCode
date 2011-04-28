clear      MACRO  Field, size
	   xor    cx,cx
           mov    cl,size
	   mov    al,20h
           lea    di,Field
	   rep    stosb
           ENDM

Public     Len1,Num1,Len2,Num2,Bin1,Bin2,AnsMsg,Integer,Float
Public     Integral,Fraction

           TITLE  prog03b                  
	  .MODEL  SMALL
	  .STACK  100h

	  .DATA
PgmMsg     db  0dh,0ah
           db  0dh,0ah,"This Program reads an integer constant and a floating-point,"
           db  0dh,0ah,"and computes their sum, then displays the sum.", "$"

EnterMsg1  db  0dh,0ah,0dh,0ah
           db  "Enter an integer constant in the range of 0 thru 256",0dh,0ah
	   db  "To Exit, press <Enter> key only.", 0dh,0ah, "$"

EnterMsg2  db  0dh,0ah,0dh,0ah
           db  "Enter a floating-point in the range of 0.00 thru 256.00",0dh,0ah
	   db  "To Exit, press <Enter> key only.", 0dh,0ah, "$"

InBuff1    db  04
Len1       db  00
Num1       db  20h,20h,20h,0dh

InBuff2    db  07
Len2       db  00
Num2       db  20h,20h,20h,20h,20h,20h,0dh

InvalMsg1  db  0dh,0ah
           db  "An Invalid integer constant was entered!","$"
InvalMsg2  db  0dh,0ah
           db  "An Invalid float-point was entered!","$"

Factor     db  1,10,100

Bin1       dw  0000
Bin2       dw  0000

AnsMsg     db  0dh,0ah,0dh,0ah, "When the integer constant is "
Integer    db  20h,20h,20h
           db  0dh,0ah,"and the floating-point constant is "
Float      db  20h,20h,20h,20h,20h,20h
           db  0dh,0ah,"their sum is "
Integral   db  20h,20h,20h
Fraction   db  2eh,20h,20h,20h,20h,20h,0dh,0ah,"$"

ByeMsg     db  0dh,0ah, "Bye for Now!", 0dh,0ah, "$"

	  .CODE
MAIN       PROC
           mov   ax,@data	; sets up addresibility
	   mov   ds,ax		; aka Entry Linkeage
	   mov   es,ax

	   lea   dx,PgmMsg
	   mov   ah,09h
	   int   21h

Start:     call  ClrStorage

           call  GetInteger	; gets first integer
           call  ChkInteger	; checks to make sure the integer is valid

           call  GetFloat	; gets the real number
           call  ChkFloat	; checks the real number.

           call  CompuSum	; adds them together.

           jmp   Start
MAIN       ENDP

ClrStorage PROC
           clear Integer,03          ; Clear Integer field
           clear Float,06            ; Clear Float field
           clear Fraction+1,05       ; Clear Fraction field 
           ret
ClrStorage ENDP


GetInteger PROC
	   lea   dx,EnterMsg1	     ; prints the first prompt.
	   mov   ah,09h
	   int   21h

	   lea   dx,InBuff1	     ; reads input from keyboard
	   mov   ah,0ah		     ; aka the integer input.
	   int   21h

	   xor   ch,ch		     ; zeroes out ch
	   mov   cl,Len1             ; moves length of input into cl

	   cmp   cl,00		     ; if (cl == 0) 
	   je    Exit1		     ; goto Exit1
	   ret
	   
Exit1:     lea   dx,ByeMsg	     ; prints ByeMsg
	   mov   ah,09h
	   int   21h

	   mov   ah,4ch
	   int   21h
GetInteger ENDP


ChkInteger PROC
Again1:    lea   di,Factor

	   xor   dx,dx		      ; zeroes out dx register
	   xor   ax,ax		      ; zeroes out ax register
	   xor   ch,ch		      ; zeroes out ch part of cx register
	   mov   cl,Len1	      ; moves length of 1st input into cl

	   lea   si,Num1	      ; loads address of Num1 into si
	   mov   al,[si]	      ; moves si into al

Rest1:     cmp   al,30h               ; compares al to spaces
	   jl    Inval1               ; jump to inval1 if value is greater
	   cmp   al,39h               ; if value isn't a digit
	   ja    Inval1		      ;  jumpt to inval1

	   and   al,0Fh		      ; converts string to binary
	   push  di                   
	   add   di,cx
           dec   di   
           mov   bl,[di]
	   mul   bl
	   add   dx,ax
  
	   inc   si
	   pop   di
	   mov   al,[si]
	   loop  Rest1		      ; loops until it has check all the chars.
	   
	   mov   Bin1,dx              ; since value was valid, store val in Bin1.
	   ret   

Inval1:    lea   dx,InvalMsg1         ; print error msg.
	   mov   ah,09h
	   int   21h

           call  GetInteger	      ; check failed, call function to get new value.
	   jmp   Again1               ; then attempt to check value again.
ChkInteger ENDP


GetFloat   PROC
	   lea   dx,EnterMsg2	      ; prints prompt to get floating point.
	   mov   ah,09h
	   int   21h

	   lea   dx,InBuff2           ; reads value entered into a string.
	   mov   ah,0ah
	   int   21h

	   xor   ch,ch		      ; zeroes out ch
	   mov   cl,Len2	      ; moves size of string into cl

	   cmp   cl,00                ; if sizeof(inBuff2) == 00
	   je    Exit2		      ;   goto Exit2
	   ret
	   
Exit2:     lea   dx,ByeMsg            ; prints bye message.
	   mov   ah,09h
	   int   21h

	   mov   ah,4ch
	   int   21h
GetFloat   ENDP


ChkFloat  PROC

; Assume the input for Floating-point constant is 48.25
; Then, 1) the memory contents of Num2 is: 34 38 2e 32 35 0D (in ASCII)
;       2) the memory contents of Len2 is: 5

; This PROCedure will compute the integral
; part of the Floating-point constant.
; 1. Compute the number of digits in the integral part is 2
; 2. Convert 34 38 to 04 08
; 3. From 04 08, compute and store 04 x 10 + 8 = 48 into Bin2 in binary   
; 4. Check if the input value is valid

Again2:    xor   cx,cx      ; First, find # of digits in Integral part
           lea   si,Num2    ; si points to  34 38 . 32 35 0D
           mov   al,[si]    ; al = 34

intLen:    cmp   al,'.'     ; If (al == '.') then Branch to EndInt
           je    EndInt     ; Else if (al < '0') OR (al > '9') then
                            ;         Branch to Inval2
           cmp   al,'0'     ; Else  
           jl    Inval2     ;   cx = cx + 1
                            ;   si points to Next digit
           cmp   al,39h     ;   al contains Next digit
           ja    Inval2     ; EndIf
                            ; Branch back to intLen
           inc   cx
           inc   si
           mov   al,[si]
           jmp   intLen

EndInt:    inc   si         ; si points to Digit following '.'
           mov   al,[si]    ; al contains that Digit

           cmp   al,0Dh     ; If (al == '\0') then Branch to IntInBin
           je    IntInBin   ; Else if (al < '0') OR (al > '9') then
                            ;      Branch to Inval2
           cmp   al,30h     ; Else
           jl    Inval2     ;      Branch back to EndInt 
                            ; EndIf
           cmp   al,39h
           ja    Inval2

IntInBin:  lea   di,Factor  ; If input for float-point constant is valid
           xor   dx,dx      ; then convert its integral part to binary 
           xor   ax,ax      ; and save the value into Bin2 
        

           lea   si,Num2
Rest2:     mov   al,[si]
	   and   al,0Fh		      ; me head hurts...me need sleep
	   push  di                   ; 
	   add   di,cx
           dec   di   
           mov   bl,[di]
	   mul   bl
	   add   dx,ax
  
	   inc   si
	   inc   di
	   pop   di
	   loop  Rest2   	      ; loops until it has check all the chars.

           mov   Bin2,dx
           ret


Inval2:    lea   dx,InvalMsg2
	   mov   ah,09h
	   int   21h

           call  GetFloat  
	   jmp   Again2

ChkFloat   ENDP


compuSum   PROC

; Input:   Num1 is the integer value        (in ASCII characters)
;          Num2 is the floating-point value (in ASCII characters)

; Input:   Bin1 is the integer value        (in binary)
;          Bin2 is the floating-point value (in binary)

           xor  cx,cx         ; copy Num1 to Integer (in ASCII)
           mov  cl,Len1
           lea  si,Num1
           lea  di,Integer
           rep  movsb

           xor  cx,cx         ; copy Num2 to Float (in ASCII)
           mov  cl,Len2
           lea  si,Num2
           lea  di,Float
           rep  movsb

           xor  cx,0          ; Computes the number of digits in the
           lea  si,Num2       ; Integral part of the Floating-point   
nextDgt:   mov  al,[si]       ; constant, and saves it into CX
           cmp  al,'.'
           je   frcPart       ; Assume: 48.25 = 34 38 . 32 35 0D
           inc  cx            ; Then, CX = 2
           inc  si
           jmp  nextDgt

frcPart:   inc  si            ; si points to First Digit of Floaing-point 
           lea  di,Fraction   ; di points to the position following '.'
           inc  di            

           mov  al,Len2       ; 34 38 . 32 35 ->  al = 5
           sub  al,cl         ; al = al - cl = 5 - 2 = 3
           mov  cl,al         ; cl = al = 3
           dec  cx            ; cx = cx - 1 = 2 = # of digits in float-point
           rep  movsb         ; 32 35 copied to Fraction field

           mov  ax,Bin1       ; ax = 10 (Integer constant = 16 = 10h)
           mov  bx,Bin2       ; bx = 30 (Integral = 48 = 30h)
           add  ax,bx         ; ax = 40 = 64 in decimal

           lea  si,Integral   ; si points to Integral field
           cmp  ax,99
           ja   QMore99
           cmp  ax,9  
           ja   QMore9  

           or   al,30h        ; if ax = 0, 1, 2, . . , 9
           mov  [si+2],al     ; convert it to ASCII character, and copy it
           jmp  printAns      ; to Integral field, then print it

QMore9:    mov  bl,10         ; if ax = 10, 11, 12, . . , 99
           div  bl            ; convert it to ASCII characters, and copy  
           or   al,30h        ; them to Integral field, then print them  
           mov  [si+1],al     ; e.g., if ax = 48, then ax/bl = 48/10
           or   ah,30h        ; -> 08 in AH and 04 in AL
           mov  [si+2],ah     ; -> 34 = [si+1]
           jmp  printAns      ; -> 38 = [si+2]

	   
QMore99:   mov  bl,100        ; if ax = 100, 101, 102, . . , 999
           div  bl            ; convert it to ASCII characters, and copy
           or   al,30h        ; them to Integral field, then print them
                        
           mov  [si],al       ; e.g., ax = 567, then ax/bl = 567/100 
           mov  al,ah         ; -> ah = 67, al = 5
           xor  ah,ah         ; -> al OR 30h = 35h = [si]
           mov  bl,10         ; -> mov al,ah -> al = 67, and ah = 0 
           div  bl            ; -> ax/bl = 67/10 -> ah = 7, al = 6 
           or   al,30h        ; -> al OR 30h -> 36h = [si+1] 
           mov  [si+1],al     ; -> ah OR 30h -> 37h = [si+2]
	   or   ah,30h
	   mov  [si+2],ah
	   jmp  printAns

printAns:  lea  dx, AnsMsg
           mov  ah, 09h
           int  21h

	   ret
compuSum   ENDP
           END   Main



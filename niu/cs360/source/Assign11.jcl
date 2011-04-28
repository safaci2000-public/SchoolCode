//Z002161A JOB ,'Samir Faci',MSGLEVEL=(1,0)
/*JOBPARM  NOLOG,ROOM=161
// EXEC ASSIST
//SYSIN DD *
         TITLE 'SAMIR FACI CSCI 360 SECTION 1 ASSIGNMENT 11'
         MACRO
&CNAM    STENT &PLREGS,&BR=0
.********************************************************************
.* NAME:           STENT                                            *
.*                                                                  *
.* FUNCTION:       TO ESTABLISH STANDARD ENTRY INTO EXTERNAL        *
.*                 SUBROUTINE                                       *
.*                                                                  *
.* PROTOTYPE STATEMENT:                                             *
.*      &CNAM STENT &PLREGS,&BR                                     *
.*                                                                  *
.* SYMBOLIC PARAMETERS:                                             *
.*       &CNAM:      NAME OF CSECT                                  *
.*       &PLREGS:    NUMBER OF REG TO BE LOADED OFF OF R1           *
.*       &BR:        BASE REGISTER                                  *
.*                                                                  *
.* ERROR CONDITION:                                                 *
.*      IF &PLREGS IS NULL THE LM STATEMENT IS NOT EXECUTED.        *
.* NOTES:                                                           *
.*      NONE                                                        *
.*                                                                  *
.********************************************************************
&CNAM    CSECT
         STM   R14,R12,12(R13)  SAVES ALL REGS.                                             
         LR    &BR,R15          GETS BASE REGISTER                                          
         USING &CNAM,&BR        ESTABLISHES ADDRESIBILITY                                   
         LA    R14,&CNAM.SV     LOADS & OF SAVE AREA INTO R14
         ST    R13,4(R14)       SAVES BACKWARD POINTER                                      
         ST    R14,8(R13)       SAVES FORWARD POINTER                                       
         LR    R13,R14          GET STORAGE IN R13                                          
         LR    R10,R1           SAVES PARM LIST IN R10
         AIF   ('&PLREGS' EQ '').END
         LM    &PLREGS(1),&PLREGS(2),0(R1)  LOADS PARM LISTS.
.END     MEND
*
*
         MACRO
&LABEL   STEXT &REGS
.********************************************************************
.* NAME:           STEXT                                            *
.*                                                                  *
.* FUNCTION:       TO ESTABLISH STANDARD EXIT FROM AN EXTERNAL      *
.*                 SUBROUTINE                                       *
.*                                                                  *
.* PROTOTYPE STATEMENT:                                             *
.*      &LABEL STEXT &REGS                                          *
.*                                                                  *
.* SYMBOLIC PARAMETERS:                                             *
.*       &LABEL:     OPTIONAL LABEL                                 *
.*       &REGS:      REGS PASSED ARE SAVED BEFORE BEING PASSED      *
.*                   BACK BY THE EXIT LINKAGE                       *
.*                                                                  *
.* ERROR CONDITION:                                                 *
.*         IF MORE THEN 4 REGS ARE PASSED IN OR IF REGISTER PASSED  *
.*         AREN'T 0, 1 OR 15                                        *
.*                                                                  *
.* NOTES:                                                           *
.*      NONE                                                        *
.*                                                                  *
.********************************************************************
         LCLA  &NUM          KEEPS TRACK OF NUM OF VALS IN PARM LIST
&NUM     SETA  1             SETS &NUM TO 1
         L     R13,4(R13)        GETS BACKWARD POINTER
         AIF   ('&REGS(4)' NE '').ERR1
         AIF   (1).NEXT1         BRANCHES TO NEXT TEST.
.ERR1    ANOP
         MNOTE 4,'MORE THEN 3 PARMS WERE PASSED'
         AGO   .EXEND
.NEXT1   AIF   ('&REGS(&NUM)' EQ '').SAVE      IF PARM IS EITHER NULL
         AIF   ('&REGS(&NUM)' EQ '0').SAVE     0,1, OR 15 DO NOT KILL
         AIF   ('&REGS(&NUM)' EQ '1').SAVE       MACRO.
         AIF   ('&REGS(&NUM)' EQ '15').SAVE 
         MNOTE 4,'ERROR, ONE OF PARMS PASSED IS NOT 0,1, OR 15'
         AGO   .EXEND
.SAVE    ANOP                    THE LAND OF THE SAVED (PARM THAT IS)
         AIF   ('&NUM' GT '3').NEXT
&NUM     SETA  &NUM+1
         AGO   .NEXT1
.NEXT    ANOP
&NUM     SETA  N'&REGS           SETS &NUM TO NUMBER OF PARM IS LIST
         AIF   ('&REGS(1)' EQ '').OTHER
         AIF   ('&REGS(1)' EQ '0').ST1   CHECKS TO SEE WHICH REGS
         AIF   ('&REGS(1)' EQ '1').ST2   IS PASSED IN THE 1ST SUBLIST
         AIF   ('&REGS(1)' EQ '15').ST3
.ST1     ST    &REGS(1),20(R13)       STORES R0 INTO SAVE AREA.
         AGO   .NEXTST
.ST2     ST    &REGS(1),24(R13)       STORES R1 INTO SAVE AREA.
         AGO   .NEXTST
.ST3     ST    &REGS(1),16(R13)       STORES R15 INTO SAVE AREA
.NEXTST  AIF   ('&NUM' GE '2').NSTR
         AGO   .OTHER
.NSTR    ANOP
         AIF   ('&REGS(2)' EQ '0').ST4   CHECKS TO SEE W/H REGS
         AIF   ('&REGS(2)' EQ '1').ST5   IS PASSED IN THE 2ND POS
         AIF   ('&REGS(2)' EQ '15').ST6
.ST4     ST    &REGS(2),20(R13)       STORES R0 INTO SAVE AREA.
         AGO   .NEXTST2
.ST5     ST    &REGS(2),24(R13)       STORES R1 INTO SAVE AREA.
         AGO   .NEXTST2
.ST6     ST    &REGS(2),16(R13)       STORES R15 INTO SAVE AREA
.NEXTST2 AIF   ('&NUM' NE '3').OTHER
         AIF   ('&REGS(3)' EQ '0').ST7   CHECKS TO SEE W/H REG
         AIF   ('&REGS(3)' EQ '1').ST8   IS PASSED IN THE 3D POS
         AIF   ('&REGS(3)' EQ '15').ST9       IF ANY.
.ST7     ST    &REGS(3),20(R13)       STORES R0 INTO SAVE AREA.
         AGO   .NEXTST3
.ST8     ST    &REGS(3),24(R13)       STORES R1 INTO SAVE AREA.
         AGO   .NEXTST3
.ST9     ST    &REGS(3),16(R13)       STORES R15 INTO SAVE AREA
.OTHER  LM    R14,R12,12(R13)   RESTORES REGISTERS.
.OVER3   AIF   ('&REGS(1)' EQ '').BRANCH
         AIF   ('&NUM' GE '2').LDNEXT
         AGO   .BRANCH
.LDNEXT  ANOP
         AIF   ('&NUM' NE '3').BRANCH
.BRANCH  BR    R14               RETURNS CONTROL TO MAIN.
         LTORG                   GETS RID OF LITERALS
         EJECT
.EXEND   MEND
*
         MACRO
&LABEL   STCAL &CNAM,&PAR,&BTAB
.********************************************************************
.* NAME:           STCAL                                            *
.*                                                                  *
.* FUNCTION:       TO CALL AN EXTERNAL SUBROUTINE AND BRANCH IF     *
.*                 ANY IS SPECIFIED.                                *
.*                                                                  *
.* PROTOTYPE STATEMENT:                                             *
.*      &LABEL STCAL &CNAM,&PAR,&BTAB                               *
.*                                                                  *
.* SYMBOLIC PARAMETERS:                                             *
.*       &LABEL:     OPTIONAL LABEL                                 *
.*       &CNAM:      NAME OF FUNCTION BEING CALLED                  *
.*       &PAR:       @ OF PARM LIST THAT WILL BE USED BY FUNCTION   *
.*       &BTAB       LABELS OF WHERE TO BRANCH                      *
.*                                                                  *
.*                                                                  *
.* ERROR CONDITION:                                                 *
.*      KICKS OUT IF &BTAB CONTAINS MORE THEN 4 LABELS.             *
.*                                                                  *
.* NOTES:                                                           *
.*      NONE                                                        *
.*                                                                  *
.********************************************************************
         LCLA  &NUM          KEEPS TRACK OF # OF PARMS IN BTAB
&NUM     SETA  N'&BTAB       SET &NUM TO # OF PARMS IN BTAB
         AIF   ('&NUM' LE '4').NEXT  IF VAL < 4, KEEP GOING.
         MNOTE 4,'ERROR.  MORE THEN 4 LABELS WERE SPECIFIED'
         AGO   .CLEND           GO TO END OF MACRO.
.NEXT    LA    R1,&PAR          LOADS ADDRESS OF PARAMETERS LIST
         L     R15,=V(&CNAM)    STORES ADDRESS INTO R15
         BALR  R14,R15          BRANCHES TO BUILD AND BUILDS 1ST TABLE
         AIF   ('&BTAB(1)' EQ '').CLEND
         B     B&SYSNDX+0(R15) BRANCH TO LABEL DEPENDING ON VAL OF 15
B&SYSNDX B     &BTAB(1)         BRANCHES TO LABELS SPECIFIED.
         AIF   ('&BTAB(2)' EQ '').CLEND IF LABEL NOT PASSED, DO NO PUT
         B     &BTAB(2)
         AIF   ('&BTAB(3)' EQ '').CLEND   IN THE BRANCH STATEMENT INTO
         B     &BTAB(3)
         AIF   ('&BTAB(4)' EQ '').CLEND   THE CODE
         B     &BTAB(4)
*        
.CLEND   MEND
***********************************************************************
*                                                                     *                     
*                         CSCI 360 Program 11                         *                     
*                                                                     *                     
* Function:  Read in a bunch of store stock data, stores it in a      *                     
*            hash table, after which it is printed several times.     *                     
*            subroutines are now external subroutines instead of      *                     
*            interanl.                                                *                     
*                                                                     *                     
* Input:     A file                                                   *                     
*                                                                     *                     
* Output:    To Screen                                                *                     
*                                                                     *                     
* Entry                                                               *                     
* Conds:     None (This routine is not called as a subroutine)        *                     
*                                                                     *                     
* Exit                                                                *                     
* Conds:     None (This routine does not return parameters)           *                     
*                                                                     *                     
* Program Logic:                                                      *                     
*                                                                     *                     
*                                                                     *                     
* Register                                                            *                     
* Usage:       R1      STORES PARAM ADDRESS                           *                     
*              R2      STORES / REWRITE @ OF TABLE TO PARM LIST.      *                     
*              R15     STANDARD LINKAGE                               *                     
*              R11     STANDARD LINKAGE                               *                     
*                                                                     *                     
*         R14,R13,R15  USED FOR EXTERNAL SUBROUTINES LINKING          *                     
* NOTES:                                                              *                     
***********************************************************************                     
MAIN     CSECT                                                                              
*ENTRY LINKAGE                                                                              
         STM   R14,R12,12(R13)   SAVES ALL REGS.                                            
         LR    R12,R15           GETS BASE REGISTER                                                   LA    R11,4095(,R15)    ESTABLISHES LINKAGE                                        
         LA    R11,1(,R11)       ESTABLISHES LINKAGE                                        
         USING MAIN,R12,R11      USING R15 & R12                                            
         LA    R14,MAINSAVE      GETS STORAGE ADDRESS                                       
         ST    R13,4(R14)        SAVES BACKWARD POINTER                                      
         ST    R14,8(R13)        SAVES FORWARD POINTER                                       
         LR    R13,R14           GET STORAGE @ IN 13                                        
LOOP     DS    0H                                                                           
*BUILD                                                                                      
         LA    R2,TABLE         LOADS ADDRESS OF TABLE INTO R2
         ST    R2,PARM          STORES @ OF TABLE INTO PARM LIST.
         STCAL BUILD,PARM      
         L     R7,PARM          LOADS RETURN CODE INTO R7                                   
*PRINT FIRST TABLE                                                                          
         LA    R2,TABLE         STORES @ OF TABLE INTO R2                                   
         ST    R2,PARM          LOADS ADDRESS OF TABLE INTO PARM LIST.                      
         STCAL PRT,PARM
         C     R7,=F'4'         COMPARES RETURN CODE WITH VAL OF 4                          
         BE    END              ON EQUAL BRANCH TO END.                                     
         B     LOOP            UNCONDITIONAL LOOP TO LOOP                                   
*                                                                                           
END      DS    0H                                                                           
*EXIT LINKAGE                                                                               
         L     R13,4(R13)
         LM    R14,R12,12(R13)
         BR    R14               RETURNS TO CALLER                                          
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
***********************************************************************                     
*                                                                                           
*                          STORAGE AREA                                                     
*                                                                                           
*                                                                                           
***********************************************************************                     
         ORG   MAIN+((*-MAIN+31)/32*32)                                                     
         DC    CL32'  THE HASH TABLE BEGINS HERE   '                                        
TABLE    DC    496F'-1'                                                                     
ANA      DC    A(TABLE)                                                                     
         DC    CL32'  THE HASH TABLE END HERE      '                                        
*                                                                                           
MAINSAVE DS    18F               AREA TO SAVE REGISTERS                                     
PARM     DC    A(TABLE,INPUT) STORES ADDRESS TO BE PASSED TO FUNC.                          
*
*
TEST     STENT (3,5),BR=12             
         STEXT 
TESTSV   DS    18F               AREA TO SAVE REGISTERS
***********************************************************************
*       NAME:           BUILD                                         *                     
*       FUNCTION:       TO BUILD THE 1ST TABLES                       *                     
*       INPUT:          A FILE ON DISK                                *                     
*       OUTPUT:         NONE                                          *                     
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *                     
*       REGISTER USE:   R1 - PARM LIST                                *                     
*                       R3 - ADDRESS OF TABLE.
*                       R4 - INPUT BUFFER                             *
*                       R5 - INPUT BUFFER                             *
*                       R8 - USED FOR DSECTS.
*       PSEUDOCODE:     DO WHILE NOT EOF                              *                     
*                        ENTER RECORD INTO THE TABLE.                 *                     
*                       ON EOF, EXIT LOOP AND RETURN TO MAIN.         *                     
*                                                                     *                     
*       NOTES:                                                        *                     
***********************************************************************                     
BUILD    STENT (3,5),BR=12
*code
LOOP2    LM    R3,R4,0(R10)     LOADS VALS OF PARM LISTS INTO REGS.                         
         XREAD 0(R4),80         READS NEXT RECORD.                                          
         BC    B'0100',EOF      BRANCH IF EOF.                                              
         PACK  THESTKNM(4),1(5,R4) PACKS STOCK NUMBER.                                      
*                                                                                           
         MVC   HASHPARM+4(4),THESTKNM    MOVES STOCK NUM INTO PARM.                         
         ST    R3,HASHPARM      STORES @ OF TABLE INTO PARM LIST.                           
*                                                                                           
         CP    THESTKNM(4),=P'0'   COMPARES VAL WITH ZERO.                                  
         BE    FIX              IF EQUAL GO TO FIX.                                         
         B     SKIPFIX          SKIP OVER FIX.                                              
FIX      L     R15,=F'0'        LOADS 0 INTO R15                                            
         B     ENDBLD            BRANCHES TO ENDBLD                                         
SKIPFIX  DS    0H                                                                           
*HASH                                                                                       
         STCAL HASH,HASHPARM,(DORC0,DORC4,DORC8)
*         LA    R1,HASHPARM       LOADS ADDRESS OF PARM INTO R1
*         L     R15,=V(HASH)      STORES ADDRESS OF HASH INTO R15                            
*         BALR  R14,R15           BRANCHES TO HASH.                                          
*ENDHASH                                                                                    
*         B     BTAB(R15)         BRANCH TO BRANCH STATEMENT DEPENDING                       
*                                ON VALUE OF R15                                            
*BTAB     B     DORC0             BRANCHES ON RETURN CODE OF 0                               
*         B     DORC4             BRANCHES ON RETURN CODE OF 4                               
*         B     DORC8             BRANCHES ON RETURN CODE OF 8                               
DORC0    DS    0H                                                                           
         CLI   0(R4),C'I'        COMPARES 1ST CHAR TO THE LETTER I                          
         BE    ER                ON EQUAL, BRANCH TO ERROR STATMENT.                        
         B     OVER              BRANCHES OVER ERROR STATEMENT                              
ER       XPRNT ERR1,36           PRINT ERROR STATMENT #1                                    
         B     REDO              GO TO REDO & BRANCH OVER RC4&8.                            
OVER     L     R4,4(R10)         LOADS ADDRESS OF INPUT.                                    
         PACK  TEMP(4),48(3,R4)  STORES VALUE IN INPUT RECORD IN TEMP                       
         CLI   0(R4),C'A'        COMPRES CHARACTER TO THE LETTER A                          
         BE    ALTER             BRANCH TO ALTER ON EQAUL                                   
         B     DELETE            BRANCH TO DELETE                                           
ALTER    DS    0H                                                                           
         AP    TEMP(4),0(3,R1)   ADDS VAL TO TEMP.                                          
         MVC   0(3,R1),TEMP+1    STORES MODIFIED Q. ON HAND IN TABLE.                       
         B     REDO              BRANCH TO REDO.                                            
DELETE   DS    0H                                                                           
         SP    TEMP(4),0(3,R1)   SUBSTRACT VAL FROM TEMP.                                   
         MVC   0(3,R1),TEMP+1    STORE MOD. Q. ON HAND IN TABLE.                            
         B     REDO              BRANCH TO REDO.                                            
*                                                                                           
DORC4    DS    0H                                                                           
         CLI   0(R4),C'I'        COMPARES CHAR. TO THE LETTER 'I'                           
         BE    INS               ON EQUAL GO TO INSERT.                                     
         B     OVER2             BRANCH OVER.                                               
INS      MVC   3(16,R1),7(R4)    STORES ARTIST NAME                                         
         MVC   24(23,R1),24(R4)  STORES TITLE OF CD                                         
         PACK  0(3,R1),48(3,R4)  PACKS QUANTITY ON HAND.                                    
         PACK  19(5,R1),58(9,R4) PACKS THE ISBN #                                           
         PACK  51(3,R1),52(5,R4) PACKS THE PRICE                                            
         PACK  47(4,R1),1(5,R4)  PACKS THE STOCK NUMBER                                     
         B     REDO              BRANCH TO REDO.                                            
OVER2    DS    0H                                                                           
         XPRNT ERR2,36           PRINTS ERROR STAT. # 2.                                    
         B     REDO              BRANCHES TO REDO.                                          
DORC8    DS    0H                                                                           
         CLI   0(R4),C'I'        COMPARES CHAR TO I                                         
         BE    ER1               ON EQUAL GOTO ERROR.                                       
         B     OVER3             BRANCHES OVER ERROR.                                       
ER1      XPRNT ERR3,36           PRINT ERROR STAT. # 3.                                     
         B     REDO              BRANCH TO REDO.                                            
OVER3    CLI   0(R4),C'A'        COMPARES CHAR TO THE LETTER 'A'                            
         BE    ER2               ON EQUAL GO TO ERROR.                                      
         CLI   0(R4),C'D'        COMPARES CHAR TO THE LETTER 'D'                            
         BE    ER2               ON EQUAL GO TO ERROR.                                      
ER2      XPRNT ERR4,36           PRINT ERROR STAT. # 4.                                     
         B     REDO              BRANCH TO REDO.                                            
*                                                                                           
REDO     DS    0H                                                                           
         L     R3,0(R10)         LOADS TABLE @ FROM BACKUP PARM.                            
         B     LOOP2             BRANCHES TO LOOP2                                          
*exit                                                                                       
EOF      L     R15,=F'4'         LOADS 0 INTO R15                                           
ENDBLD   DS    0H
         ST    R15,0(R10)        STORES RC INTO 0(R10)
         L     R3,0(R10)         LOAD ADDRESS OF TABLE INTO R3.
         STEXT 
BUILDSV  DS    18F               USED TO BACKUP REGISTERS                                   
TEMP     DS    PL4               TEMP VAR USED TO BUILD TABLE.                              
TEMP3    DS    PL4               TEMP VAR USED IN DECIMAL MATH.                             
INPUT    DS    CL80              INPUT BUFFER                                               
         DC    C'*'              DELIMITER
HASHPARM DS    A(0,THESTKNM)                                                                
THESTKNM DS    PL4                                                                          
DBL      DC    D'0'              DOUBLE WORD USED TO BY CVB                                 
ERR1     DC    CL36' STOCK NUMBER ALREADY IN TABLE      '                                   
ERR2     DC    CL36' STOCK NUMBER NOT IN TABLE          '                                   
ERR3     DC    CL36' UNABLE TO INSERT, TABLE FULL       '                                   
ERR4     DC    CL36' STOCK NUMBER NOT IN FULL TABLE     '                                   
*
*
***********************************************************************
*       NAME:           HASH                                          *                     
*       FUNCTION:                                                     *                     
*       INPUT:          A FILE ON DISK                                *                     
*       OUTPUT:         NONE                                          *                     
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *                     
*       REGISTER USE:   R1 - PARM LIST                                *                     
*                       R3 - TABLE ADDRESS                            *                     
*                       R4 - STOCK NUMBER                             *                     
*                       R5 - USED TO CALCULATE HASH @                 *                     
*                       R6 - BACKS UP HASH @ CALCULATED               *                     
*                       R10 - BACKUP OF PARM LIST @                   *                     
*                       R11 - ADDRESS BEING LOOKED AT                 *                     
*       PSEUDOCODE:                                                   *                     
*                                                                     *                     
*       NOTES:          NONE                                          *                     
***********************************************************************                     
HASH     STENT (3,4),BR=12
*BEGIN CODE                                                                                 
*                                                                                           
         L     R3,0(R1)         LOADS @ OF TABLE INTO PARM LIST.                            
         LR    R5,R3            LOADS BEGIN OF TABLE INTO R5                                
         MVC   HASHDBL+4(4),4(R1)  PUTS STOCK NUMBER INTO HASHDBL.                          
         CVB   R5,HASHDBL          CONVERTS STOCK NUMBER TO BINARY.                         
         SR    R4,R4               ZEROES OUT R4                                            
         D     R4,=F'31'           GETS REMAINDER INTO R4                                   
         LR    R5,R4               LOADS REMAINDER INTO R5                                  
         M     R4,=F'64'           MULTIPLIES REMAINDER BY 64                               
         AR    R5,R3               ADDS BEGIN OF TABLE @ TO VAL.                            
         LR    R0,R5            GETS LOCATION OF ENTRY IN TABLE.                            
         LR    R6,R0            BACKS UP LOCATION IN R6                                     
         LR    R11,R0           LOADS VAL OF R0 INTO R11 FOR USE.                           
         LR    R5,R3            LOADS BEGIN OF TABLE INTO R5                                
         A     R5,=F'1984'      ADDS SIZE OF TABLE TO R5 TO GET EOT.                        
CMP      CLC   0(4,R11),=F'-1'  CHECKS FOR EMPTY LOCATION.                                  
         BE    GETLOC           GETS LOCATION.                                              
         CP    4(4,R10),47(4,R11)  COMPARES STOCK NUMBER WITH VAL                           
*                                      IN TABLE.                                            
         BE    MATCH             IF EQUAL, GO TO LABEL MATCH                                
         BNE   KPGOING           ON NOT EQUAL BRANCH TO KEEP GOING.                         
MATCH    MVC   RC(4),=F'0'       MOVES 0 TO RETURN CODE.                                    
         LR    R1,R11            LOADS @ IN R11 INTO R1                                     
         B     ENDHASH           KICKS OUT OF LOOP                                          
GETLOC   MVC   RC(4),=F'4'       MOVES 4 TO RETURN CODE.                                    
         LR    R1,R11            STORES ADDRESS IN R11 INTO R1                              
         B     ENDHASH           KICKS OUT OF LOOP                                          
KPGOING  LA    R11,64(R11)       INCREMENTS TO POINT TO NEXT ENTRY                          
         CR    R11,R5            COMPARES @ TO EOT.                                         
         BE    RESET             ON EQUAL, BRANCH TO RESET.                                 
         BNE   START             ON NOT EQUAL GO TO START                                   
RESET    LR    R11,R3            LOADS @ OF BEGIN OF TABLE INTO R0                          
         B     START             UNCODITIONAL BRANCH TO START.                              
START    CR    R11,R6            COMPARES ADDRESS LOOKED AT WITH                            
*                                ORIGINAL HASH ADDRESS CALCULATED.                          
         BE    FULL              TABLE FULL                                                 
         BNE   CMP               BRANCH BACK TO CMP AND START AGAIN.                        
FULL     MVC   RC(4),=F'8'       LOADS 8 INTO RC                                            
         L     R1,TEXT           LOADS TEXT INTO R1                                         
ENDHASH  DS    0H                NADA.                                                      
         L     R15,RC            LOADS THE RETURN CODE INTO R15
*                                                                                           
* END CODE                                                                                  
*                                                                                           
*EXIT LINKAGE                                                                               
          STEXT (1,15)
HASHSV   DS    18F               USED TO BACKUP REGISTERS.                                  
RC       DC    F'0'              USED TO STORE THE RETURN CODE                              
HASHDBL  DC    D'0'              USED TO CONVERT TO BINARY                                  
TEXT     DC    CL4'FULL'         STORES TEXT FULL TO BE STORED IN R1                        
*
*
***********************************************************************
*       NAME:           PRINT                                         *                     
*       FUNCTION:       TO BUILD THE TABLES                           *                     
*       INPUT:          A FILE ON DISK                                *                     
*       OUTPUT:         NONE                                          *                     
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *                     
*       REGISTER USE:   R1 - PARM LIST                                *                     
*                       R3 -  END OF TABLE ADDRESS                    *                     
*                       R4 - TABLE ADDRESS                            *                     
*                       R5 - STORES VALUE TO BE PRINTED               *                     
*                       R10 - EXIT LINKAGE                            *                     
*       PSEUDOCODE:     DO WHILE NOT EOF                              *                     
*                        PRINT RECORDS OF TABLE.                      *                     
*                       ON EOF, EXIT LOOP AND RETURN TO MAIN.         *                     
*       NOTES:          NONE                                          *                     
***********************************************************************                     
PRT      STENT (3,4),BR=12       ESTABLISHES ENTRY LINKAGE
*                                                                                           
         XPRNT TITLE,77          PRINTS TITLE
         XPRNT HEADING,124       PRINTS HEADING
         MVC   UT+1(123),UT      INITIALIZES UNDERLINE PLINE.                               
         XPRNT UNDER1,124        PRINTS UNDERLINE.
         L     R3,0(R1)          LOADS TABLE @ INTO R3
         LR    R5,R3             LOADS TABLE @ INTO R5
         A     R5,=F'1984'       SETS R5 TO EOT.                                             
CMPPR    CR    R3,R5             COMPARES R3 WITH EOT.
         BE    ENDPRT            BRANCH IF R3 = R5
         CLC   0(4,R3),=F'-1'    COMPARES TABLE ENTRY TO -1S.
         BE    PRTEMP            BRANCH ON EQAUL TO PRTEMP
         B     PRTDATA           BRANCH TO PRINT DATA.
PRTEMP   XPRNT EMPTY,124         PRINT EMPTY
         B     GOAGAIN           BRANCH TO GO AGAIN.
PRTDATA  DS    0H                
         MVC   STKNM2(7),=X'40402020202020' SETS UP MASK                                    
         ED    STKNM2(7),48(R3)  EDITS STOCK NUMBER
         MVC   ARTIST(16),3(R3)  MOVES ARTIST NUMBER IN.
         MVC   TTL(24),24(R3)    MOVES TITLE OF CD.
         MVC   QHAND(6),=X'404020202020'   SETS UP MASK                                             
         ED    QHAND(6),0(R3)    MOVES QUANTITY ON HAND.
         MVC   PRICE(8),=X'40402021204B2020' SETS UP MASK
         EDMK  PRICE(8),51(R3)   MOVES EDITED VAL INTO PLINE
         BCTR  R1,R0             MOVES R1 TO POINT TO CORRECT SLOT.
         MVI   0(R1),C'$'        INSERT $ SIGN
         MVC   ISBN(9),=X'202020202020202020'
         ED    ISBN(9),19(R3)    MOVES ISBN NUMBER IN.
         XPRNT DATA,128          PRINTS DATA.
GOAGAIN  DS    0H                                                                           
         LA    R3,64(R3)        LOOKS AT NEXT ENTRY.                                        
         B     CMPPR            BRANCHES TO CMPPR UNTIL EOT.
*                                                                                           
ENDPRT   DS    0H                                                                           
*EXIT LINKAGE
         STEXT 
*
*
PRTSV    DS    18F               USED TO BACKUP REGISTERS                                   
PRTTEMP  DS    PL4               TEMP VAR USED TO CHECK IF VAL == -1                        
*                                                                                           
***********************************************************************                     
*                                                                     *                     
*                 STORAGE BELOW SETS UP PRINT LINES                   *                     
*                                                                     *                     
***********************************************************************                     
TITLE    DC    C'1'              TITLE PRINT TITLE HEADING                                  
         DC    CL40' '                                                                      
         DC    CL36'   CD EMPIRE STOCK INFORMATION      '                                   
HEADING  DC    C'-'              HEADING PRINTS COLUMN HEADINGS                             
         DC    CL12'STOCK NUMBER'                                                           
         DC    CL8' '                                                                       
         DC    CL19'   ARTIST          '                                                    
         DC    CL8' '                                                                       
         DC    CL12'    CD TITLE'                                                           
         DC    CL12' '                                                                      
         DC    CL12'# IN STOCK  '                                                           
         DC    CL8' '                                                                       
         DC    CL12'  CD PRICE  '                                                           
         DC    CL8' '                                                                       
         DC    CL12'    ISBN    '                                                           
UNDER1   DC    C' '                                                                         
UT       DC    CL123'-'                                                                     
DATA     DC    C' '                                                                         
         DC    CL5' '                                                                       
STKNM2   DS    CL7                STOCK NUMBER OF RECORD                                                          
         DC    CL13' '                                                                      
ARTIST   DC    CL16' '            ARTIST NAME                                                          
         DC    CL8' '                                                                       
TTL      DC    CL24' '            CD TITLE                                                          
         DC    CL1' '                                                                       
QHAND    DC    CL6' '             QUANTITY ON HAND                                                          
         DC    CL14' '                                                                      
PRICE    DC    CL8' '             PRICE OF CD                                                          
         DC    CL13' '                                                                      
ISBN     DC    CL9' '             ISBN NUMBER                                                          
EMPTY    DC    C' '
         DC    CL123'      EMPTY'
*                                                                                           
*                                                                                           
R0       EQU   0                        REGISTER EQUATES FOR BETTER
R1       EQU   1                        UNDERSTANDING THE REGISTER USE
R2       EQU   2
R3       EQU   3
R4       EQU   4
R5       EQU   5
R6       EQU   6
R7       EQU   7
R8       EQU   8
R9       EQU   9
R10      EQU   10
R11      EQU   11
R12      EQU   12
R13      EQU   13
R14      EQU   14
R15      EQU   15
         END   MAIN
/*
//FT05F001 DD DSN=T90MES1.C360(DATA11),DISP=SHR
//

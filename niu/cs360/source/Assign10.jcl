//Z002161A JOB ,'Samir Faci',MSGLEVEL=(1,0)
/*JOBPARM  NOLOG,ROOM=161
// EXEC ASSIST
//SYSIN DD *
         TITLE 'SAMIR FACI CSCI 360 SECTION 1 ASSIGNMENT 10'
***********************************************************************
*                                                                     *                     
*                         CSCI 360 Program 10                         *                     
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
         LR    R12,R15           GETS BASE REGISTER
         LA    R11,4095(,R15)    ESTABLISHES LINKAGE
         LA    R11,1(,R11)       ESTABLISHES LINKAGE
         USING MAIN,R12,R11      USING R15 & R12                                            
         LA    R14,MAINSAVE      GETS STORAGE ADDRESS                                       
         ST    R13,4(R14)       SAVES BACKWARD POINTER                                      
         ST    R14,8(R13)       SAVES FORWARD POINTER                                       
         LR    R13,R14           GET STORAGE @ IN 13
*
* CODE
*
         XREAD INPUT,80         READS 1ST TEST RECORD.
         MVC   CODED(80),INPUT  STORES INPUT RECORD INTO CODED.
         LA    R1,PARM          LOADS ADDRESS OF PARAMETERS LIST
         L     R15,=V(DECODE)   STORES ADDRESS INTO R15                                     
         BALR  R14,R15         BRANCHES TO BUILD AND BUILDS 1ST TABLE
         LA    R1,BLDPARM       LOADS ADDRESS OF PARM INTO R1
         L     R15,=V(BUILDKEY) STORES ADDRESS INTO R15
         BALR  R14,R15          CALLS BUILDKEY FUNCTION.
         LA    R1,MSGPARM       LOADS @ OF MSGPARM INTO R15
         L     R15,=V(BUILDMSG) STORES ADDRESS INTO R15
         BALR  R14,R15          CALLS BUILDMSG FUNCTION
         MVC   COUNT(4),MSGPARM+4 MOVES MSGCOUNT INTO COUNT.
         LA    R1,DECRPARM
         L     R15,=V(DECRYPT)
         BALR  R14,R15
* END CODE
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
MAINSAVE DS    18F               AREA TO SAVE REGISTERS                                     
PARM     DC    A(CODED,DCODED,TRANSTAB) STORES ADDRESS TO BE PASSED
BLDPARM  DC    A(KEYTABLE,TRANSTAB,INPUT)
MSGPARM  DC    A(MSGTABLE,COUNT,INPUT,TRANSTAB)
DECRPARM DC    A(MSGTABLE,COUNT,KEYTABLE,KCNTABLE)
COUNT    DS    F                 KEEPS COUNT OF MSGS
INPUT    DS    CL80              INPUT BUFFER
         DC    C'*'              DELIMITER
CODED    DS    CL80              HAS STRING TO BE DECODED
DCODED   DC    CL48' '           HAS DECODED STRING.
KEYTABLE DC    270F'-1'          STORES DECRYPTION KEYS.
MSGTABLE DC    1200F'-1'         STORES MSGS.
KCNTABLE DC    48F'-1'           STORES COUNT.
TRANSTAB DC    256X'FF'          ENTRY USED TO TRANSLATE CHARACTERS.
         ORG   TRANSTAB+C'/'
         DC    X'00'
         ORG   TRANSTAB+C'+'
         DC    X'01'
         ORG   TRANSTAB+C'0'
         DC    X'02030405060708090A0B'
         ORG   TRANSTAB+C'a'
         DC    X'0C0D0E0F1011121314'
         ORG   TRANSTAB+C'j'
         DC    X'15161718191A1B1C1D'
         ORG   TRANSTAB+C's'
         DC    X'1E1F202122232425'
         ORG   TRANSTAB+C'A'
         DC    X'262728292A2B2C2D2E'
         ORG   TRANSTAB+C'J'
         DC    X'2F3031323334353637'
         ORG   TRANSTAB+C'S'
         DC    X'38393A3B3C3D3E3F'
         ORG
*
*
***********************************************************************
*       NAME:           DECODE                                        *                     
*       FUNCTION:       STRIPS OFF THE 1ST BIT OF THE DATA PASSED IN  *                     
*                       AKA, IT DECODES THE JUNK PASSED IN AFTER IT   *
*                            WAS TRANSLATED.                          *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *
*       REGISTER USE:   R1 - PARM LIST                                *
*                       R3 - CODED STRING                             *
*                       R4 - DCODED STRING                            *
*                       R5 - TRANSTABLE                               *
*       PSEUDOCODE:     CUT OFF THE 1ST BIT OF EVERY BYTE AND         *
*                       TRANSLATE USING THE TRANSTABLE.               *
*                                                                     *
*                                                                     *
*       NOTES:                                                        *
***********************************************************************
DECODE   CSECT                                                                              
*ENTRY                                                                                      
         STM   R14,R12,12(R13)  SAVES ALL REGS.                                             
         LR    R12,R15          GETS BASE REGISTER                                          
         USING DECODE,R12       ESTABLISHES ADDRESIBILITY                                   
         LA    R14,DCDSAVE      LOADS & OF BLDSAVE INTO R14                                 
         ST    R13,4(R14)       SAVES BACKWARD POINTER                                      
         ST    R14,8(R13)       SAVES FORWARD POINTER                                       
         LR    R13,R14          GET STORAGE IN R13                                          
*code
         LM    R3,R5,0(R1)      LOADS PARM INTO REGISTERS.
         MVC   0(6,R4),2(R3)
         MVC   6(6,R4),10(R3)
         MVC   12(6,R4),18(R3)
         MVC   18(6,R4),26(R3)   MVC STATEMENTS CUTS OFF THE 
         MVC   24(6,R4),34(R3)   1ST BIT OF EVERY BYTE
         MVC   30(6,R4),42(R3)
         MVC   36(6,R4),50(R3)
         MVC   42(6,R4),58(R3)
         TR    0(48,R4),0(R5)
*exit
ENDDCODE L     R13,4(R13)        GETS BACKWARD POINTER                                      
         LM    R14,R12,12(R13)   RESTORES REGS.                                             
         BR    R14               BRANCHES BACK TO MAIN                                      
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
DCDSAVE  DS    18F               USED TO BACKUP REGISTERS
*
*
***********************************************************************
*       NAME:           BUILDKEY                                      *                     
*       FUNCTION:       TO BUILD A KEY TABLE                          *                     
*                                                                     *
*                                                                     *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *                     
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *                     
*       REGISTER USE:   R1 - PARM LIST                                *
*                       R3 - KEYTABLE                                 *
*                       R4 - TRANSTAB                                 *
*                       R5 - INPUT BUFFER                             *
*                       R9 - COUNT                                    *
*       PSEUDOCODE:     READS INPUT RECORD UNTIL R9 IS EQUAL TO 25    *
*                       CALING DECODE TO DECODE EACH RECORD READ IN   *
*                       AFTER WHICH IT IS STORED IN A TABLE.          *
*                                                                     *
*       NOTES:                                                        *
***********************************************************************
BUILDKEY CSECT                                                                              
*ENTRY
         STM   R14,R12,12(R13)  SAVES ALL REGS.                                             
         LR    R12,R15          GETS BASE REGISTER                                          
         USING BUILDKEY,R12     ESTABLISHES ADDRESIBILITY                                   
         LA    R14,BLDSAVE      LOADS & OF BLDSAVE INTO R14                                 
         ST    R13,4(R14)       SAVES BACKWARD POINTER                                      
         ST    R14,8(R13)       SAVES FORWARD POINTER                                       
         LR    R13,R14          GET STORAGE IN R13                                          
*code
         LM    R3,R5,0(R1)      LOADS VALS FROM PARM LIST PASSED IN.
         ST    R4,BPARM+8       STORES @ OF TRANSTAB IN PARM LIST.
         LR    R10,R11          BACK UPS R1 INTO R10
         L     R9,=F'1'         LOADS 1 INTO R9
LOOP     C     R9,=F'25'        COMPARES COUNT TO 25
         BC    B'1000',ENDLP    IF EQUAL END LOOP
         XREAD 0(R5),80         READS INPUT INTO INPUT BUFFER.
         A     R9,=F'1'         ADDS 1 TO R9.
         MVC   BLDCODE(80),0(R5) MOVES INPUT RECORD INTO CODE.
         LA    R1,BPARM         LOADS @ OF BPARM INTO R1
         L     R15,=V(DECODE)   BRANCHES TO DECODE
         BALR  R14,R15          EXECUTES DECODE OF KEY.
         MVC   0(45,R3),BLDDCODE MOVES ENTRY INTO TABLE
         LA    R3,45(R3)        LOADS @ OF NEXT TABLE ENTRY
         B     LOOP             BRANCHES TO LOOP TO READ NEXT ENTRY
ENDLP    DS    0H
* end code
*exit
ENDBLD   L     R13,4(R13)        GETS BACKWARD POINTER                                      
         LM    R14,R12,12(R13)   RESTORES REGS.                                             
         BR    R14               BRANCHES BACK TO MAIN                                      
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
BLDSAVE  DS    18F               USED TO BACKUP REGISTERS
BLDCODE  DS    CL80              HAS STRING TO BE DECODED
BLDDCODE DC    CL48' '           HAS DECODED STRING.
BPARM    DC    A(BLDCODE,BLDDCODE,0) PARM PASSED TO DECODE
*
*
***********************************************************************
*       NAME:           BUILDMSG                                      *                     
*       FUNCTION:       TO BUILD A MSG TABLE                          *                     
*                                                                     *
*                                                                     *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *                     
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *                     
*       REGISTER USE:   R1 - PARM LIST                                *
*                       R3 - MSGTABLE                                 *
*                       R4 - COUNT                                    *
*                       R5 - INPUT BUFFER                             *
*                       R6 - TRANSTAB                                 *
*       PSEUDOCODE:     READS RECORD UNTIL EOF CALLING DECODE TO      *
*                       DECODE EACH RECORD BEFORE STORING IN TABLE.   *
*                                                                     *
*                                                                     *
*       NOTES:                                                        *
***********************************************************************
BUILDMSG CSECT                                                                              
*ENTRY
         STM   R14,R12,12(R13)  SAVES ALL REGS.                                             
         LR    R12,R15          GETS BASE REGISTER                                          
         USING BUILDMSG,R12     ESTABLISHES ADDRESIBILITY                                   
         LA    R14,MSGSAVE      LOADS & OF BLDSAVE INTO R14                                 
         ST    R13,4(R14)       SAVES BACKWARD POINTER                                      
         ST    R14,8(R13)       SAVES FORWARD POINTER                                       
         LR    R13,R14          GET STORAGE IN R13                                          
*code
         LM    R3,R6,0(R1)      LOADS VAL FROM PARM LIST.
         LR    R10,R1           BACKS UP @ OF PARM LIST.
         ST    R6,MSGAPARM+8    STORES @ OF TRANSTAB IN PARM LIST.
         L     R6,=F'0'
LP2      XREAD 0(R5),80         READS RECORD
         BC    B'0100',EOF      BRANCH IF EOF.                                              
         A     R6,=F'1'
         MVC   MSGCODE(80),0(R5) MOVES INPUT RECORD INTO CODE.
         LA    R1,MSGAPARM      LOADS @ OF BPARM INTO R1
         L     R15,=V(DECODE)   BRANCHES TO DECODE
         BALR  R14,R15          EXECUTES DECODE OF KEY.
         MVC   0(48,R3),MSGDCODE MOVES ENTRY INTO TABLE
         LA    R3,48(R3)        LOADS @ OF NEXT TABLE ENTRY
         B     LP2
*exit
EOF      ST    R6,4(R10)         SAVES MSG COUNT INTO FULL WORD.
         L     R13,4(R13)        GETS BACKWARD POINTER
         LM    R14,R12,12(R13)   RESTORES REGS.                                             
         BR    R14               BRANCHES BACK TO MAIN                                      
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
MSGSAVE  DS    18F               USED TO BACKUP REGISTERS
MSGCODE  DS    CL80
MSGDCODE DS    CL48
MSGAPARM DC    A(MSGCODE,MSGDCODE,0)
*
*
***********************************************************************
*       NAME:           DECRYPT                                       *                     
*       FUNCTION:       TO DECRYPT THE MSG                            *                     
*                                                                     *
*                                                                     *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *                     
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *                     
*       REGISTER USE:   R1 - PARM LIST                                *
*                       R3 - MSGTABLE                                 *
*                       R4 - COUNT                                    *
*                       R5 - KEYTABLE                                 *
*                       R6 - KCNTABLE                                 *
*       PSEUDOCODE:                                                   *
*                                                                     *
*                                                                     *
*                                                                     *
*       NOTES:                                                        *
***********************************************************************
DECRYPT  CSECT                                                                              
*ENTRY
         STM   R14,R12,12(R13)  SAVES ALL REGS.                                             
         LR    R12,R15          GETS BASE REGISTER                                          
         USING DECRYPT,R12     ESTABLISHES ADDRESIBILITY                                   
         LA    R14,DECRSAVE     LOADS & OF BLDSAVE INTO R14                                 
         ST    R13,4(R14)       SAVES BACKWARD POINTER                                      
         ST    R14,8(R13)       SAVES FORWARD POINTER                                       
         LR    R13,R14          GET STORAGE IN R13                                          
*code
         LM    R3,R6,0(R1)      LOADS PARM INTO REGS.
         XPRNT HEADER,50        
         XPRNT C'-',1           SKIPS THREE LINES.
*
         ST    R5,KEY1          STORES @ OF KEYTABLE INTO KEYADD
         ST    R6,KEY2          PUTS -1 INTO R5
LOOP2    LA    R10,45(R3)       POINTS R10 TO NEXT ENTRY IN MSGTBL
         L     R5,KEY1          LOADS VALUE FROM KEYTADD
         L     R6,KEY2          LOADS VALUE FROM KEYTADD
         LA    R7,R4            LOADS @ OF COUNTER INTO R7
*
LOOP3    LA    R8,X'80'         LOADS A MASK OF 10000000 INTO R8
         LA    R9,R8            LOADS @ OF REG 8 INTO R9
LOOP4    EX    R8,TSTMSK        LOADS TSTMSK INTO R8
         BZ    LOOP5            BRANCH ON ZERO TO DLOOP6
         XC    0(45,R3),0(R5)   XOR THE DATA
         LH    R2,0(R6)         LH VAL IN COUNT TABLE INTO R2
         LA    R2,1(R2)         MOVES @ OFF 1 BYTE
         STH   R2,0(R6)         STH R2 INTO COUNT TABLE
LOOP5    SRL   R8,1             SHIFT RIGHT BY 1
         LA    R6,2(R6)         POINTS @ 2 BYTER LATER.
         LA    R5,45(R5)        POINTS R5 TO NEXT KEY TABLE ENTRY
         BCT   R9,LOOP4         GOTO LOOP4 UNTIL R9 HITS 0
         LA    R10,1(R10)       MOVES R10 TO POINT 1 BIT AFTER IN MSG
*                               TABLE.
         BCT   R7,LOOP3         GOTO LOOP3 UNTIL R7 HITS 0
         XPRNT =C' ',1          PRINT A DOUBLE SPACE.
         MVC   MSG+36(45),0(R3) MOVE MSG INTO MSGTABLE.
         XPRNT MSG,81           PRINT MSG
         LA    R3,48(R3)        LOADS @ OF NEXT ENTRY INTO R3
         BCT   R4,LOOP2         GOES TO LOOP 2 UNTIL R4 IS EQUAL TO 0
*exit
DECREND  L     R13,4(R13)        GETS BACKWARD POINTER                                      
         LM    R14,R12,12(R13)   RESTORES REGS.                                             
         BR    R14               BRANCHES BACK TO MAIN                                      
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
DECRSAVE DS    18F               USED TO BACKUP REGISTERS
TSTMSK   TM    0(R10),X'00'      IS A TEST MASK
KEY1     DS    F             
KEY2     DS    F
HEADER   DC    CL50'1'
         DC    C' HELOOOOOO WORLD '
MSG     DC    CL81' '
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
//FT05F001 DD DSN=T90MES1.C360(DATA10),DISP=SHR
//

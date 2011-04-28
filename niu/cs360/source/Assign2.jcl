//Z002161A JOB ,'Samir Faci',MSGLEVEL=(1,0)
/*JOBPARM  NOLOG,ROOM=161
// EXEC ASSIST
//SYSIN DD *
         TITLE 'SAMIR FACI CSCI 360 SECTION 1 ASSIGNMENT 2'
***********************************************************************
*                                                                     *
*                         CSCI 360 Sample Program                     *
*                                                                     *
* Function:  Reads an unknown number of records then calculate their  *
*            sum and difference                                       *
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
* Usage:                                                              *
*                                                                     *
*                                                                     *
*                                                                     *
* NOTES:                                                              *
***********************************************************************
         EJECT
LOOPS    CSECT
         USING LOOPS,15            ESTABLISH ADDRESSABILITY
         XPRNT HEADING1,61         PRINTS THE HEADING AT TOP OF PAGE
         XPRNT HEADING2,96         PRINTS COLUMN HEADINGS
READER   XREAD BUFFER,80           READS THE INPUT DATA INTO A BUFFER
         BC    B'0100',EOF
         XDECI 2,BUFFER            READS 1ST NUMBER
         XDECI 3,0(,1)             READS 2ND NUMBER
         XDECI 4,0(,1)             READS 3D NUMBER
*
*
         XDECO 2,NM1               LOADS VALUE INTO PRNT LINE VARS
         XDECO 3,NM2               SAME AS ABOVE
         XDECO 4,NM3               SAME AS ABOVE
*
         L     5,NUM1SUM           LOADS VALUE OF NUM1SUM INTO R5
         AR    5,2                 ADDS R5 TO 1ST NUM READ IN
         ST    5,NUM1SUM           STORES R5 INTO NUM1SUM
         L     5,NUM2SUM           LOADS VALUE OF NUM2SUM INTO R5
         AR    5,3                 ADDS R5 TO 2ND NUM READ IN
         ST    5,NUM2SUM           STORES R5 INTO NUM2SUM
         L     5,NUM3SUM           LOADS VALUE OF NUM3SUM INTO R5
         AR    5,4                 ADDS R5 TO 3D VALUE READ IN
         ST    5,NUM3SUM           STORES R5 INTO NUM3SUM
         LR    5,2                 LOAD VALUE OF NUM1 INTO R5
         SR    5,3                 SUBSTRACT VALUE OF NUM2 FROM R5
         SR    5,4                 SUBSTRACT VALUE OF NUM3 FROM R5
         L     6,SUMDIF            LOAD VAL OF SUMDIF INTO R6
         AR    5,6                 ADD REGISTER 5 AND 6 GIVES SUMDIF
         ST    5,SUMDIF            LOAD VALUE OF R5 INTO SUMDIF
*
         LR    5,2                 LOAD VALUE OF NUM1 INTO R5
         AR    5,3                 AD NUM1 AND NUM2
         AR    5,4                 ADD SUM OF NUM1 AND NUM2 TO NUM3
         XDECO 5,SM                PUTS SUM OF NUMS INTO PRINT FIELD
         LR    5,2                 LOAD VAL OF NUM1 INTO R5
         SR    5,3                 SUBSTRACT NUM2 FROM NUM1
         SR    5,4                 SUBSTRACT NUM3 FROM DIF NM1 & NM2
         XDECO 5,DF                LOAD DIFF INTO PRINT FIELD
         XPRNT PRNTLN1,93          PRINT VALUES READ IN AND CALC.
**********************************************************************
**********************************************************************
         SPACE
         L     5,TRANCNT           LOAD VALUE OF TRANCNT INTO R5
         A     5,=F'1'             ADD 1 TO R5
         ST    5,TRANCNT           STORE VAL OF R5 INTO TRANCNT
         BC    B'1111',READER      UNCONDITION LOOP CONDITION
         SPACE         
         SPACE         
EOF      L     5,NUM1SUM           LOAD VAL OF NUM1SUM INTO R5
         L     6,NUM2SUM           LOAD VAL OF NUM2SUM INTO R6
         AR    6,5                 ADD NUM1SUM TO NUM2SUM
         L     5,NUM3SUM           LOAD VAL OF NUM3SUM
         AR    6,5                 ADD SUM OF NUM3SUM TO R6
         ST    6,SUMSUM            STORE VAL OF R6 INTO SUMSUM
         L     5,NUM1SUM           LOAD VAL OF NUM1SUM INTO R5
         XDECO 5,NUM1              STORE VAL OF R5 TO NUM1
         L     5,NUM2SUM           LOAD NUM2SUM INTO R5
         XDECO 5,NUM2              STORE VAL OF R5 INTO NUM1
         L     5,NUM3SUM           LOAD VAL OF NUM3SUM INTO R5
         XDECO 5,NUM3              STORE VAL OF R5 INTO NUM3
         L     5,SUMSUM            LOAD VAL OF SUMSUM INTO R5
         XDECO 5,SSUM              STORE R5 INTO SSUM
         L     5,SUMDIF            LOAD VAL OF SUMDIF INTO R5
         XDECO 5,SDIF              STORE VAL OF R5 INTO SDIF
         L     5,TRANCNT           LOAD VAL OF TRANCNT INTO R5
         XDECO 5,TRNCNT            LOAD VAL OF R5 INTO TRNCNT
*
         XPRNT PRNTLN2,48          PRINT DETAIL LINE 1
         XPRNT HEADING3,121        PRINT HEADING 3
         XPRNT PRNTLN3,121         PRINT DETAIL LINE 2
         BCR   B'1111',14          EXIT PROGRAM
         EJECT
*
*
*
***********************************************************************
BUFFER   DS    CL80                INPUT BUFFER
NUM1SUM  DC    F'0'                SUM OF NUM1S
NUM2SUM  DC    F'0'                SUM OF NUM2S
NUM3SUM  DC    F'0'                SUM OF NUM3S
SUMSUM   DC    F'0'                SUM OF ALL SUMS
SUMDIF   DC    F'0'                SUM OF ALL DIFS
TRANCNT  DC    F'0'                TRANSACTION COUNTER
*
HEADING1 DC    C'1'
         DC    20C' '
         DC    CL40'Addition, Subtraction, and Summation    '
*
HEADING2 DC    C'-'
         DC    CL8' '
         DC    CL4'Num1 '
         DC    CL16' '
         DC    CL4'Num2 '
         DC    CL16' '
         DC    CL4'Num3 '
         DC    CL17' '
         DC    CL4'Sum '
         DC    CL12' '
         DC    CL10'Difference  '
*
PRNTLN1  DC    C'0'
NM1      DS    CL8
         DC    CL12' '
NM2      DS    CL8
         DC    CL12' '
NM3      DS    CL8
         DC    CL12' '
SM       DS    CL8
         DC    CL12' '
DF       DS    CL8
*
PRNTLN2  DC    C'0'
         DC    CL5' '
         DC    CL30'Number of records processed = '
TRNCNT   DS    CL8
HEADING3 DC    C'0'
         DC    12C' '
         DC    CL12'SUM OF NUM1s'
         DC    12C' '
         DC    CL12'SUM OF NUM2s'
         DC    12C' '
         DC    CL12'SUM OF NUM3s'
         DC    12C' '
         DC    CL12'SUM OF SUMs'
         DC    12C' '
         DC    CL12'SUM OF DIFS'
*
PRNTLN3  DC    C'0'
         DC    12C' '
NUM1     DS    CL12
         DC    12C' '
NUM2     DS    CL12
         DC    12C' '
NUM3     DS    CL12
         DC    12C' '
SSUM     DS    CL12
         DC    12C' '
SDIF     DS    CL12
         END   LOOPS
/*
//FT05F001 DD DSN=T90MES1.C360(DATA2),DISP=SHR
//









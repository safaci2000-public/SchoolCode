//Z002161A JOB ,'Samir Faci',MSGLEVEL=(1,0)
/*JOBPARM  NOLOG,ROOM=161
// EXEC ASSIST
//SYSIN DD *
         TITLE 'SAMIR FACI CSCI 360 SECTION 1 ASSIGNMENT 3'
***********************************************************************
*                                                                     *
*                         CSCI 360 Program 3                          *
*                                                                     *
* Function:  Read in a bunch of employee data and calculates various  *
*            information about them                                   *
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
* Usage:       R2      STORES DIGIT ID NUMBER                         *
*              R3      STORES RANK NUMBER                             *
*              R4      STORES HOURS BILLED                            *
*              R5      STORES DEDUCTION RATE                          *
*              R6      USED FOR CALCULATION AND XDECO                 *
*              R7      USED FOR CALCULATIONS (M,D ESPECIALLY)         *
*              R8      USED FOR CALCULATIONS (M,D ESPECIALLY)         *
* NOTES:                                                              *
***********************************************************************
         EJECT
LOOPS    CSECT
         USING LOOPS,15            ESTABLISH ADDRESSABILITY
         XPRNT HEADING,61          PRINTS THE HEADING AT TOP OF PAGE
         XPRNT HEADING2,121        PRINTS THE COLUMN HEADINGS
         XPRNT HEADING3,121         PRINT THE COLUMN HEADINGS
READER   XREAD BUFFER,80           READS THE INPUT BUFFER
         BC    B'0100',EOF         CHECK FOR END OF FILE
         XDECI R2,BUFFER           READS THE 6DIG ID NUM
         XDECI R3,0(,1)            READS THE 2DIG RANK
         XDECI R4,0(,1)            READS THE # OF HRS WORKED
         XDECI R5,0(,1)            READS THE DEDUCTION RATE
         ST    R2,DIGITID          STORES THE DIGIT ID
         ST    R3,RANKID           STORES THE RANK ID
         ST    R4,HRSBIL           STORES THE HRS BILLED
         ST    R5,DEDRATE          STORES THE DEDUCTION RATE
         L     R6,EMPLNUM          LOADS VALE OF EMPL COUNTER INTO R6
         A     R6,=F'1'            ADDS 1 TO R6
         ST    R6,EMPLNUM          STORES VAL OF R6 INTO EMPLNUM
         L     R8,=F'22'           LOADS THE VAL 22 INTO R8
         CR    R3,R8               COMPARES THE 3 AND 8TH REGISTER
         BC    B'1000',EQL         BRANCHES IF 3 == 8
         BC    B'0100',LOWPAY      BRANCES IF 3 < 8
         BC    B'0010',HIGHPAY     BRANCHES IF 3 > 8
EQL      L     R7,=F'12500'        LOAD 12500 INTO R8
         BC    B'1111',BROUT       BRANCHES OUT TO MULTIPLICATION
LOWPAY   L     R7,=F'10000'        LOADS 10000 INTO R8
         BC    B'1111',BROUT       BRANCHES OUT TO MULTIPLICATION
HIGHPAY  L     R7,=F'15000'        LOADS 15000 INTO R8
BROUT    MR    R6,R4               MULTIPLY R6 WITH R4
         ST    R7,GRSINC           STORES R7 INTO GRSINC
         L     R8,DEDRATE          L DEDRATE INTO R8
         MR    R6,R8               MULTIPLY R6 INTO R8
         M     R6,=F'1'            INIT R6 FOR DIVISION
         D     R6,=F'1000'         LOAD THE VALUE 1000 INTO R6
         ST    R7,DEDAMT           ST R7 INTO DEDAMT
         L     R6,GRSINC           LOAD VAL OF GRSINT INTO R6
         L     R7,DEDAMT           LOAD VAL OF DEDAMT INTO R7
         SR    R6,R7               SUBSCTRACT R7 FROM R6
         ST    R6,NETINC           STORE NETINC INTO R6
         L     R8,INCSUM           LOAD INCSUM INTO R8
         AR    R8,R6               ADD R6 TO R8
         ST    R8,INCSUM           STORE R5 INTO INCSUM
*        
*        PREPARES DATA TO BE PRINTED USING XDECO
*
         XDECO R2,DDIGITID         PREPARES R2 TO BE PRINTED
         XDECO R3,DRANKID          PREPARES R3 TO BE PRINTED
         XDECO R4,DHRSBIL          PREPARES R4 TO BE PRINTED
         L     R6,DEDAMT           LOAD VAL OF DEDAMT INTO R6
         XDECO R6,DDEDAMT          PREPARES R6 TO BE PRINTED
         L     R6,GRSINC           LOAD VAL OF GRSINC INTO R6
         XDECO R6,DGRSINC          PREPARES R6 TO BE PRINTED
         L     R6,NETINC           LOAD VAL OF NETINC INTO R6
         XDECO R6,DNETNCM          PREPARES R6 TO BE PRINTED
         XPRNT DET1,121            PRINTS DETAIL LINE 1
*
         BC    B'1111',READER      UNCONDITIONAL BRANCH TO READER
EOF      L     R6,EMPLNUM          LOAD EMPNUM INTO R6
         XDECO R6,DET2EMP          PREPARES R6 TO BE PRINTED
         L     R5,INCSUM           LOAD VAL OF INCSUM INTO R5
         L     R8,EMPLNUM          LOAD VAL OF R8 INTO EMPNUM
         M     R6,=F'1'            INIT. R6
         DR    R6,R8               DIVIDE R6 INTO R8
         ST    R5,INCSUM           STORE R5 INTO INCSUM
         L     R6,INCSUM           LOAD VAL OF INCSUM INTO R6
         XDECO R6,DET3INC          PREPARES R6 TO BE PRINTED
         XPRNT DET2,58             PRINT DETAIL LINE 2
         XPRNT DET3,58             PRINT DETAIL LINE 3
*
         BCR   B'1111',14          RETURNS CONTROL TO R14
         LTORG                     CLEANS MEM OF =F'X'
         EJECT
*
BUFFER   DS    CL80                INPUT FILE
DIGITID  DS    F                   6 DIGIT ID NUMBER
RANKID   DS    F                   RANK ID
HRSBIL   DS    F                   HOURS BILLED
DEDRATE  DS    F                   DEDUCTION RATE
GRSINC   DC    F'0'                GROSS INCOME
DEDAMT   DC    F'0'                DEDUCTION AMOUNT
NETINC   DC    F'0'                NET INCOME
EMPLNUM  DC    F'0'                EMPLOYE COUNTER
INCSUM   DC    F'0'                INCOME SUM/AVG
***********************************************************************
*
*
*
*
***********************************************************************
*
*        HEADING  PRINTS TITLE OF REPORT
*
HEADING  DC    C'1'
         DC    CL20' '
         DC    CL40'DEWEY, CHEATHAM, AND HOWE INCOME REPORT '
*
*              HEADING2 & HEADING 3 PRINTS COLUMN HEADINGS
*
HEADING2 DC    C'0'
         DC    CL5' '
         DC    CL10'   ID     '
         DC    CL12' '
         DC    CL10'  RANK    '
         DC    CL9' '
         DC    CL10'  HOURS   '
         DC    CL11' '
         DC    CL10'DEDUCTION '
         DC    CL6' '
         DC    CL10'  GROSS   '
         DC    CL11' '
         DC    CL10'  NET     '
         DC    CL6' '
HEADING3 DC    C' '
         DC    CL5' '
         DC    CL10' NUMBER   '
         DC    CL12' '
         DC    CL10' NUMBER   '
         DC    CL9' '
         DC    CL10' BILLED   '
         DC    CL11' '
         DC    CL10' AMOUNT   '
         DC    CL6' '
         DC    CL10' INCOME   '
         DC    CL11' '
         DC    CL10' INCOME   '
         DC    CL6' '
*         
*        DETAIL LINE ONE PRINT DATA CALCULATES AND READ IN
*
DET1     DC    C'0'
DDIGITID DS    CL12
         DC    CL8' '
DRANKID  DS    CL12
         DC    CL8' '
DHRSBIL  DS    CL12
         DC    CL8' '
DDEDAMT  DS    CL12
         DC    CL8' '
DGRSINC  DS    CL12
         DC    CL8' '
DNETNCM  DS    CL12
         DC    CL8' '
*
*        DETAIL LINE TWO PRINTS NUMBER OF EMPLOYEES READ
*
DET2     DC    C'-'
         DC    CL20' '
         DC    CL20'NUMBER OF EMPLOYEES:'
         DC    CL5' '
DET2EMP  DS    CL12
*
*        DETAIL LINE THREE PRINTS AVERAGE NET INCOME.
*
DET3     DC    C' '
         DC    CL20' '
         DC    CL20'AVERAGE NET INCOME: '
         DC    CL5' '
DET3INC  DS    CL12
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
         END   LOOPS
/*
//FT05F001 DD DSN=T90MES1.C360(DATA3),DISP=SHR
//





//Z002161A JOB ,'Samir Faci',MSGLEVEL=(1,0)
/*JOBPARM  NOLOG,ROOM=161
// EXEC ASSIST
//SYSIN DD *
         TITLE 'SAMIR FACI CSCI 360 SECTION 1 ASSIGNMENT 4'
***********************************************************************
*                                                                     *
*                         CSCI 360 Program 4                          *
*                                                                     *
* Function:  Read in a bunch of store stock data, stores it in a      *
*            table and prints in a easy to read format                *
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
* Usage:       R2      STORES PARAM ADDRESS                           *
*              R4      STORES ADDRES OF TABLE & END OF TABLE          *
*              R10     USED TO BRANCH TO INTERNAL SUBROUTINES         *
* NOTES:                                                              *
***********************************************************************
         EJECT
MAIN     CSECT
         USING MAIN,R15
         XPRNT TITLE,70        PRINTS TITLE OF PAGE
         XPRNT HEADING,97      PRINTS COLUMN HEADINGS
         XPRNT UNDER,97        PRINTS DASHES UNDER THE HEADINGS
         LA    R2,PARM         LOADS ADDRESS OF PARAMETERS LIST
         L     R4,0(R2)        LOADS THE ADDRESS OF TABLE INTO R4
         BAL   R10,BUILD       BRANCHES TO BUILD AND BUILDS TABLE
         BAL   R10,PRT         BRANCES TO PRT TO PRINT TABLE
         BR    R14             RETURNS TO CALLER
         LTORG                 FREES UP MEMORY TAKEN BY =F''
         SPACE
***********************************************************************
*       NAME:           BUILD                                         *
*       FUNCTION:       TO BUILD THE TABLES                           *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *
*       REGISTER USE:   R2 - PARM LIST                                *
*                       R4 - TABLE ADDRESS                            *
*                       R5 -  STOCK NUMBER                            *
*                       R6 - ARTIST ID                                *
*                       R7 - # IN STOCK                               *
*                       R8 - CD PRICE                                 *
*                       R10 - EXIT LINKAGE                            *
*       PSEUDOCODE:     DO WHILE NOT EOF                              *
*                        ENTER RECORD INTO THE TABLE.                 *
*                       ON EOF, EXIT LOOP AND RETURN TO MAIN.         *
*       NOTES:          NONE                                          *
***********************************************************************
         SPACE 2
BUILD    STM   R0,R15,RSAVE    STORES ALL REGISTERS INTO RSAVE
         XREAD INPUT,80        READS INPUT BUFFER
BLDRD    BC    B'0100',ENDBLD  BRANCES TO ENDBLD ON EOF
         XDECI R5,INPUT        STORES STOCK NUM INTO R5
         XDECI R6,0(,1)        STORES ARTIST ID INTO R6
         XDECI R7,0(,1)        STORES IN STOCK # INTO R7
         XDECI R8,0(,1)        STORES CD PRICE INTO R8
         ST    R5,0(R4)        STORES VALUE IN TABLE
         ST    R6,4(R4)        STORES VALUE IN TABLE
         ST    R7,8(R4)        STORES VALUE IN TABLE
         ST    R8,12(R4)       STORES VALUE IN TABLE
         LA    R4,16(R4)       POSITIONS POINTER TO NEXT RECORD FIELD
         XREAD INPUT,80        READS NEXT RECORD
         BC    B'1111',BLDRD   UNCONDITIONAL BRANCE TO BLDRD
ENDBLD   S     R4,=F'4'        SUBSTRACTS 4 BYTES FROM ADDRESS
         ST    R4,4(R2)        STORE ADDRESS AS A VALUE IN EOT
         LM    R0,R15,RSAVE    RESTORES REGISTERS
         BR    R10             BRANCHES BACK TO MAIN
         LTORG                 FREES UP MEMORY TAKEN BY =F'' 
         SPACE
***********************************************************************
*       NAME:           PRINT                                         *
*       FUNCTION:       TO BUILD THE TABLES                           *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *
*       REGISTER USE:   R2 - PARM LIST                                *
*                       R3 - TABLE ADDRESS                            *
*                       R4 -  END OF TABLE ADDRESS                    *
*                       R5 - STORES VALUE TO LOAD INTO TABLE          *
*                       R10 - EXIT LINKAGE                            *
*       PSEUDOCODE:     DO WHILE NOT EOF                              *
*                        PRINT RECORDS OF TABLE.                      *
*                       ON EOF, EXIT LOOP AND RETURN TO MAIN.         *
*       NOTES:          NONE                                          *
***********************************************************************
PRT      STM   R0,R15,RSAVE    STORES ALL REGISTERS
         L     R3,0(R2)        LOADS ADDRESS OF TABLE INTO R3
         L     R4,4(R2)        STORES ADDRESS OF LAST ENTRY INTO R4
PRTLP    CR    R3,R4           COMPARES ADDRESSES
         BC    B'1011',ENDPRT  BRANCH IF <=
         L     R5,0(R3)        LOADS 1ST VAL FROM TABLE
         XDECO R5,STKNUM       PREPARES FOR PRINT
         L     R5,4(R3)        LOADS 2ND VAL FROM TABLE
         XDECO R5,ARTID        PREPARES FOR PRINT
         L     R5,8(R3)        LOADS 3D VAL FROM TABLE
         XDECO R5,STOCKID      PREPARES FOR PRINT
         L     R5,12(R3)       LOADS 4TH VAL FROM TABLE
         XDECO R5,PRICE        PREPARES FOR PRINT
         LA    R3,16(,R3)      GOES TO NEXT RECORD IN TABLE
         XPRNT DATA,97         PRINTS DATA
         BC    B'1111',PRTLP   UNCONDITIONAL LOOP TO PRTLP
         LM    R0,R15,RSAVE    RESTORES REGISTERS
*
*
ENDPRT   XDUMP TABLE,224
         BR    R10             BRANCHES BACK TO MAIN
         LTORG                 FREES UP MEMORY TAKEN BY =F''
***********************************************************************
*
*                          STORAGE AREA
*
*
***********************************************************************
INPUT    DS    CL80            INPUT BUFFER
         DC    C'*'            DELIMITER
TABLE    DC    80F'-1'         80 FULLWORDS TABLE
EOT      DS    F               ADDRESS OF END OF TABLE
RSAVE    DS    16F             AREA TO SAVE REGISTERS
PARM     DC    A(TABLE,EOT)    STORES ADDRESS OF PARAMETERS
***********************************************************************
*
*                 STORAGE BELOW SETS UP PRINT LINES
*
***********************************************************************
TITLE    DC    C'1'            TITLE PRINT TITLE HEADING
         DC    CL40' '
         DC    CL29'DEKALB DISC STOCK INFORMATION'
HEADING  DC    C'-'            HEADING PRINTS COLUMN HEADINGS
         DC    CL12'STOCK NUMBER'
         DC    CL12' '
         DC    CL12'ARTIST ID   '
         DC    CL12' '
         DC    CL12'# IN STOCK  '
         DC    CL12' '
         DC    CL12'CD PRICE    '
         DC    CL12' '
UNDER    DC    C'0'             UNDER UNDERLINES COLUMN HEADINGS
         DC    CL12'------------'
         DC    CL12' '
         DC    CL12'------------'
         DC    CL12' '
         DC    CL12'------------'
         DC    CL12' '
         DC    CL12'------------'
         DC    CL12' '
DATA     DC    C'0'             DATA PRINTS DATA FROM TABLE
STKNUM   DS    CL12
         DC    CL12' '
ARTID    DS    CL12
         DC    CL12' '
STOCKID  DS    CL12
         DC    CL12' '
PRICE    DS    CL12
         DC    CL12' '
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
//FT05F001 DD DSN=T90MES1.C360(DATA4),DISP=SHR
//

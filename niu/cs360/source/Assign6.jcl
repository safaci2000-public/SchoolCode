//Z002161A JOB ,'Samir Faci',MSGLEVEL=(1,0)
/*JOBPARM  NOLOG,ROOM=161
// EXEC ASSIST
//SYSIN DD *
         TITLE 'SAMIR FACI CSCI 360 SECTION 1 ASSIGNMENT 6'
***********************************************************************
*                                                                     *
*                         CSCI 360 Program 6                          *
*                                                                     *
* Function:  Read in a bunch of store stock data, stores it in 2      *
*            tables and prints in a easy to read format.              *
*            it also sorts the table and updates the table.           *
*            it also merges the 2 tables.
*
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
*              R4      STORES ADDRES OF TABLE                         *
*              R3      STORES EOT/ANA OF TABLE                        *
*              R8      INPUT BUFFER                                   *
*              R10     STORES RETURN ADDRESS OF MAIN SUBROUTINE       *
*              R15     STANDARD LINKAGE                               *
*              R12     STANDARD LINKAGE                               *
* NOTES:                                                              *
***********************************************************************
         EJECT
MAIN     CSECT
         LA    R12,4095(,R15)    ESTABLISHES LINKAGE
         LA    R12,1(,R12)       ESTABLISHES LINKAGE
         USING MAIN,R15,R12      USING R15 & R12
         XPRNT TITLE,77          PRINTS TITLE OF PAGE
         XPRNT HEADING,133       PRINTS COLUMN HEADINGS
         XPRNT UNDER,133         PRINTS DASHES UNDER THE HEADINGS
         LA    R1,PARM           LOADS ADDRESS OF PARAMETERS LIST
         LM    R3,R4,0(R1)       LOAD ADDRESS FOR 1ST TABLE.
         L     R8,8(R1)          SAVES THE @ OF INPUT BUFFER INTO R8
         STM   R0,R15,RSAVE      BACKUPS REGISTERS
         BAL   R10,BUILD         BRANCHES TO BUILD AND BUILDS 1ST TABLE
         LA    R1,PARM           RELOADS THE ADDRESS OF PARM INTO BUILD
         ST    R4,0(R1)          STORE ADDRESS AS A VALUE IN EOT
         MVC   EOT(4),0(R1)      STORES ANA IN EOT FIELD
         LM    R0,R15,RSAVE      LOADS REGISTER VALUES FROM BACKUP
         BAL   R10,SORT          BRANCHES TO SORT THE TABLE.
         BAL   R10,PRT           BRANCES TO PRT TO PRINT TABLE
***********************************************************************
*                                                                     *
*                  START OF TABLE 2 BUILDING/SORTING/PRINTING         *
*                  NEEDS TO ADJUST TO BE ABLE TO USE R8 AS INPUT      *
***********************************************************************
         LA    R1,PARM2          LOADS ADDRESS OF PARAMETERS LIST
         LM    R3,R4,0(R1)       LOAD ADDRESS FOR 1ST TABLE.
         L     R8,8(R1)          SAVES ADDRESS OF INPUT BUFFER INTO R8
         STM   R0,R15,RSAVE      BACKUPS REGISTERS
         BAL   R10,BUILD         BRANCHES TO BUILD AND BUILDS 1ST TABLE
         LA    R1,PARM2          RELOADS THE ADDRESS OF BUILD INTO R1
         ST    R4,0(R1)          STORE ADDRESS AS A VALUE IN EOT
         MVC   EOT2(4),0(R1)     STORES ANA IN EOT FIELD
         LM    R0,R15,RSAVE      LOADS BACKED UP REGS. FROM RSAVE
         BAL   R10,SORT          BRANCHES TO SORT THE TABLE.
         XPRNT TITLE,77          PRINTS TITLE OF PAGE
         XPRNT HEADING,133       PRINTS COLUMN HEADINGS
         XPRNT UNDER,133         PRINTS DASHES UNDER THE HEADINGS
         BAL   R10,PRT           BRANCES TO PRT TO PRINT TABLE
         BAL   R10,MERGE         MERGES THE 2 TABLES INTO ONE TABLE
         LA    R1,PARM4          LOADS 4TH LIST OF PARMS INTO R1
         XPRNT TITLE,77          PRINTS TITLE OF PAGE
         XPRNT HEADING,133       PRINTS COLUMN HEADINGS
         XPRNT UNDER,133         PRINTS DASHES UNDER THE HEADINGS
         BAL   R10,PRT           BRANCES TO PRT TO PRINT TABLE
         LA    R1,PARM4          LOADS ADDRESS OF PARM4 INTO R1
         LM    R3,R4,0(R1)       LOADS R3 THROUGH R4 FROM R1
         XPRNT UPTTL,77          PRINTS TITLE OF PAGE
         XPRNT UPHEAD,133        PRINTS COLUMN HEADINGS
         XPRNT UPUNDER,133       PRINTS DASHES UNDER THE HEADINGS
         BAL   R10,UPDATE        BRANCHES TO UPDATE SUBROUTINE
         LA    R1,PARM4          LOADS ADDRESS OF PARM4 INTO R1
         LM    R3,R4,0(R1)       LOADS TABLE @ AND ANA @
         XPRNT TITLE,77          PRINTS TITLE OF PAGE
         XPRNT HEADING,133       PRINTS COLUMN HEADINGS
         XPRNT UNDER,133         PRINTS DASHES UNDER THE HEADINGS
         L     R5,EOT3           LOADS ANA INTO R5
         MVC   0(R5),=F'-1'      LOADS -1 INTO ANA FIELDS.
         BAL   R10,PRT           PRINTS MERGED TABLE ONE LAST TIME.
         XDUMP TABLE,1280        DUMPS TABLE1
         XDUMP TABLE2,1280       DUMP2 TABLE2
         XDUMP TABLE3,2280       DUMPS TABLE3
         BR    R14               RETURNS TO CALLER
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
***********************************************************************
*       NAME:           BUILD                                         *
*       FUNCTION:       TO BUILD THE 1ST TABLES                       *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *
*       REGISTER USE:   R1 - PARM LIST                                *
*                       R4 - TABLE ADDRESS                            *
*                       R5 -  STOCK NUMBER                            *
*                       R6 - # IN STOCK                               *
*                       R7 - CD PRICE                                 *
*                       R10 - EXIT LINKAGE                            *
*       PSEUDOCODE:     DO WHILE NOT EOF                              *
*                        ENTER RECORD INTO THE TABLE.                 *
*                       ON EOF, EXIT LOOP AND RETURN TO MAIN.         *
*       NOTES:          NONE                                          *
***********************************************************************
BUILD    XREAD 0(R8),80          READS INPUT BUFFER
BLDRD    BC    B'0100',ENDBLD    BRANCES TO ENDBLD ON EOF
         XDECI R5,INPUT          STORES STOCK NUM INTO R5
         C     R5,=F'000000'     COMPARES VALUE OF R5 WITH ZEROS
         BC    B'1000',ENDBLD    BRANCHES TO END OF BUILD ON EQUAL
         MVC   4(24,R4),7(R8)    STORES ARTIST NAME
         MVC   28(24,R4),32(R8)  STORES THE CD TITLE
         XDECI R6,57(R8)         STORES THE NUMBER IN STOCK
         XDECI R7,61(R8)         STORES PRICE OF CD
         ST    R5,0(R4)          STORES VALUE IN TABLE
         ST    R6,52(R4)         STORES VALUE IN TABLE
         ST    R7,56(R4)         STORES VALUE IN TABLE
         MVC   60(4,R4),=F'-1'   MOVES -1 TO ANA.
         LA    R4,64(R4)         POSITIONS POINTER TO NEXT RECORD
*                                FIELD
         XREAD 0(R8),80          READS NEXT RECORD
         BC    B'1111',BLDRD     UNCONDITIONAL BRANCE TO BLDRD
ENDBLD   S     R4,=F'4'          SUBSTRACTS 4 BYTES FROM ADDRESS
         BR    R10               BRANCHES BACK TO MAIN
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         SPACE
         EJECT
***********************************************************************
*       NAME:           SORT                                          *
*       FUNCTION:       TO SORT THE TABLE                             *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *
*       REGISTER USE:   R1 - PARM LIST                                *
*                       R3 - END OF TABLE ADDRESS                     *
*                       R4 - TABLE ADDRESS                            *
*                       R5 - LOW VALUE                                *
*                       R6 - VALUE CURRENTLY BEING LOOKED AT          *
*                       R10 - EXIT LINKAGE                            *
*       PSEUDOCODE:     DO WHILE NOT EOF                              *
*                        SWAP CONTENT OF R5 & R6 UNTIL LOW VALUES ARE *
*                        ON TOP AND HIGH VALUES ON BOTTOM USING       *
*                        INSERTION SORT.                              *
*       NOTES:          NONE                                          *
***********************************************************************         
SORT     L     R3,0(R1)          STORES ADDRESS OF LAST ENTRY INTO R3
SRT      CR    R3,R4             COMPARES EOT WITH TABLE
         BC    B'1100',ENDSRT    BRANCH TO ENDSRT IF R4 >= R3
         LR    R5,R4             SET R5 = BEGIN OF TABLE
         LA    R6,64(R4)         SETS R6 = BEGIN + 1 ENTRY
LP1      CR    R6,R3             COMPARES I AND EOT
         BC    B'0010',ENDLP1    BRANCHES TO ENDLP1 ON <=
         CLC   0(4,R5),0(R6)    COMPARES ARTISTS NAMES
         BC    B'1100',ENDIF     BRANCHES IF R5 <= R6
         LR    R5,R6             SETS LOW = I      
ENDIF    LA    R6,64(R6)         MOVES I TO NEXT RECORD
         BC    B'1111',LP1       UNCONDITIONAL BRANCH TO LP1
ENDLP1   MVC   TEMP(64),0(R4)    MOVES BEGIN TO TEMP STORAGE
         MVC   0(64,R4),0(R5)    MOVES LOW TO TOP OF NONSORTED TABLE
         MVC   0(64,R5),TEMP     MOVES TOP OF TABLE TO R5 (LOW)
         LA    R4,64(R4)         ADVANCES BEGIN TO NEXT FIELD
         BC    B'1111',SRT       UNCONDITIONAL BRANCH TO SRT1
ENDSRT   BR    R10               RETURNS CONTROL TO MAIN.
         LTORG
         EJECT
***********************************************************************
*       NAME:           UPDATE                                        *
*       FUNCTION:       TO UPDATE THE RECORDS IN THE TABLE            *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *
*       REGISTER USE:   R1 - PARM LIST                                *
*                       R3 - END OF TABLE ADDRESS                     *
*                       R4 - TABLE ADDRESS                            *
*                       R6 - HOLDS CD PRICES OF CD SOLD AND USED
*                            IN ARITHMETIC AS WELL.
*                       R7 - STORES VALUE TO PRINT (UPDATED ONES)     *
*                       R10 - EXIT LINKAGE                            *
*       PSEUDOCODE:     DO WHILE NOT EOF                              *
*                        PRINT RECORDS OF TABLE.                      *
*                       ON EOF, EXIT LOOP AND RETURN TO MAIN.         *
*       NOTES:          NONE                                          *
***********************************************************************
UPDATE   LA    R1,PARM4          LOADS PARM LIST INTO R1
         L     R4,4(R1)          RELOADS ADDRESS OF TABLE
         L     R3,0(R1)          RELOADS EOT ADDRESS
         XREAD 0(R8),80          READS INPUT RECORD
         BC    B'0100',EOF       BRANCHES ON EOF
DO1      CLC   0(24,R8),28(R4)  COMPARES CONTENT OF R4 WITH INPUT
         BC    B'1000',ENDDO     BRANCHES TO ENDO ON =
         LA    R4,64(R4)         MOVES R4 TO NEXT RECORD
         CR    R3,R4             COMPARES EOT TO TABLE @
         BC    B'0100',ERR       BRANCH IF R3 > R4
         B     DO1               UNCONDITIONAL BRANCH TO DO1
ENDDO    XDECI R6,24(R8)         XDECI CD SOLD
         L     R7,52(R4)         LOAD CD IN STOCK INTO R7
         SR    R7,R6             SUBSTRACT CD SOLD FROM INSTOCK
         ST    R7,52(R4)         STORE RESULT INTO TABLE
         XDECO R7,UPINSTK        XDECO TO DETAIL LINE
         MVC   UPNAME(24),4(R4)  XDECO TO DETAIL LINE
         MVC   UPCDTTL(24),28(R4) XDECO TO DETAIL LINE
         L     R7,0(R4)          LOADS STOCK NUM INTO R7
         XDECO R7,UPSTKN         XDECO TO DETAIL LINE
         L     R7,56(4)          LOAD CD PRICE INTO R7
         XDECO R7,UPPRC          XDECO TO DETAIL LINE
         XPRNT UPDATA,133        PRINT UPDATED DATA
         B     UPDATE            UNCONDITIONAL BRANCH TO UPDATE.
EOF      BR    R10
         LTORG
         EJECT
***********************************************************************
*       NAME:           ERR                                           *
*       FUNCTION:       TO PRINT ERROR STATEMENTS IF RECORD NOT FOUND *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *
*       REGISTER USE:   R1 - PARM LIST                                *
*                                                                     *
*       PSEUDOCODE:     NONE...PRINT ERROR, THAT'S IT.                *
*                                                                     *
*       NOTES:          NONE                                          *
***********************************************************************
ERR      MVC   ERRNAME(24),0(R8) MOVES NAME NOT FOUND TO PRINT FIELD
         XPRNT ERRDATA,76        PRINTS ERROR MSG.
         B     UPDATE            UNCONDITIONAL BRANCH TO UPDATE
         EJECT
***********************************************************************
*       NAME:           MERGE                                         *
*       FUNCTION:       TO MERGE TWO TABLES                           *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *
*       REGISTER USE:   R1 - PARM LIST                                *
*                       R3 - ANA OF TABLE 1                           *
*                       R4 - BEGIN @ OF TABLE1                        *
*                       R5 - ANA OF TABLE 2                           *
*                       R6 - BEGIN @ OF TABLE2                        *
*                       R7 - EOT OF MERGED TABLE                      *
*                       R8 - BEGIN OF MERGED TABLE                    *
*                       R9 - INPUT RECORD POINTER                     *
*                                                                     *
*       PSEUDOCODE:                                                   *
*                                                                     *
*       NOTES:          NONE                                          *
***********************************************************************
MERGE    LA    R1,PARM3         LOADS PARM LIST INTO R1
         LM    R3,R9,0(R1)      LOADS REGISTER R3 THRU R9
         L     R3,0(R3)         LOADS ANA INTO R3
         L     R5,0(R5)         LOADS ANA INTO R5
CMP      CR    R3,R4            CHECKS FOR END OF TABLE1
         BC    B'1100',INCR1    BRANCHS TO END IF EOT IS REACHED
         BC    B'1111',OVER1    BRANCHES OVER PART OF CODE
INCR1    L     R11,=F'1'        LOADS 1 INTO R11
         ST    R11,FLAG1        STORE 1 INTO FLAG1
OVER1    CR    R5,R6            CHECKS FOR END OF TABLE2
         BC    B'1100',INCR2    BRANCHS TO END IF EOT IS REACHED
         BC    B'1111',OVER2    BRANCHES OVER PART OF CODE
INCR2    L     R11,=F'1'        STORES 1 INTO R11
         ST    R11,FLAG2        STORES 1 INTO FLAG2
OVER2    CLC   FLAG1(4),FLAG2   COMPARES THE VALUES OF THE 2 FLAGS
         BC    B'1000',END      BRANCHES TO END ON EQUAL
         L     R11,0(R4)        LOADS STOCK NUM INTO R11
         L     R13,FLAG2        LOADS VAL OF FLAG2 INTO R13
         C     R13,=F'1'        LOADS 1 INTO R13
         BC    B'1000',OTHCMP   BRANCHES TO OTHER COMPARE ON EQUAL
         BC    B'1111',NORM     BRANCH TO NORMAL COMPARES
OTHCMP   C     R11,TEST         COMPRES R11 W/ TEST VALUE
         BC    B'1111',COND     BRANCHES TO CONDITION TESTS.
NORM     C     R11,0(R6)        COMPARES KEY OF TBL1 WITH KEY OF TBL2
COND     BC    B'0100',CASE1    BRANCH IF R11 < STOCK NUM OF R6
         BC    B'0010',CASE2    BRANCH IF R11 > STOCK NUM OF 6
         BC    B'1000',EQUAL    BRANCH IF EQUAL
CASE1    MVC   0(64,R8),0(R4)   MOVES RECORD TO NEW TABLE
         LA    R4,64(R4)        INCREMENTS TBL1 POINTER BY 1
         BC    B'1111',INCR     BRANCHES OVER OTHER CONDITIONS.
CASE2    MVC   0(64,R8),0(R6)   MOVES RECORD TO NEW TABLE
         LA    R6,64(R6)        INCREMENTS TBL2 POINTER BY 1
         BC    B'1111',INCR     BRANCHES OVER OTHER CONDITIONS.
EQUAL    MVC   0(64,R8),0(R6)   MOVES RECORD TO NEW TABLE
         L     R11,52(R4)       LOADS NUMBER IN STOCK INTO R11
         A     R11,52(R6)       ADD THE 2 VALUES OF STOCK OF CDS
         ST    R11,52(R8)       STORES THE SUM INTO THE NEW TABLE
         L     R11,56(R4)       LOADS THE PRICE OF TABLE 4 INTO R11
         C     R11,56(R6)       COMPARES THE 2 PRICES.
         BC    B'0100',LOW      IF LOW GO TO LOW
         BC    B'0010',HIGH     IF HIGH GO TO HIGH
LOW      MVC   56(4,R8),56(R6)  MOVE PRICE OF R6 INTO R8
         BC    B'1111',OTHER    GOTO OTHER
HIGH     MVC   56(4,R8),56(R4)  MOVE PRICE OF R4 INTO R8
         BC    B'1111',OTHER    GOTO OTHER
OTHER    LA    R4,64(R4)        INCREMENTS TBL1 POINTER BY 1
         LA    R6,64(R6)        INCREMENTS TBL2 POINTER BY 1
INCR     LA    R8,64(R8)        INCREMENTS TBL3 POINTER BY 1
         BC    B'1111',CMP      UNCONDITIONAL BRANCH TO CMP
END      ST    R8,EOT3          STORES ANA INTO EOT3
         BR    R10              BRANCHES BACK TO MAIN.
         LTORG
         EJECT
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
PRT      STM   R0,R15,RSAVE      STORES ALL REGISTERS
         L     R3,0(R1)          STORES ADDRESS OF LAST ENTRY INTO R3
         L     R4,4(R1)          LOADS ADDRESS OF TABLE INTO R4
         STM   R0,R15,RSAVE      BACKUP REGISTER VALUES
PRTLP    CR    R4,R3             COMPARES ADDRESSES
         BC    B'1011',ENDPRT    BRANCH IF <=
         L     R5,0(R4)          LOADS 1ST VAL FROM TABLE
         C     R5,=F'-1'         COMPARES R5 TO -1
         BE    ENDPRT            BRANCHES TO ENDLP ON EQUAL
         C     R5,=F'-423048733' COMPARES TO VAL
         BE    ENDPRT            ENDS LOOP ON EQUAL
         XDECO R5,STKNUM         PREPARES FOR PRINT
         L     R5,4(R4)          LOADS 2ND VAL FROM TABLE
         MVC   ARTNAM(24),4(R4)  LOADS ARTIST NAME INTO DETAIL LINE
         MVC   CDTTL(24),28(R4)  LOADS CD TITLE INTO DETAIL LINE
         L     R5,52(R4)         LOADS 3D VAL FROM TABLE
         XDECO R5,INSTOCK        PREPARES FOR PRINT
         L     R5,56(R4)         LOAD PRICE INTO R5 
         XDECO R5,PRICE          PREPARES FOR PRINT
         LA    R4,64(,R4)        GOES TO NEXT RECORD IN TABLE
         XPRNT DATA,133          PRINTS DATA
         BC    B'1111',PRTLP     UNCONDITIONAL LOOP TO PRTLP
ENDPRT   LM    R0,R15,RSAVE      RESTORES REGISTERS
         BR    R10               BRANCHES BACK TO MAIN
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
***********************************************************************
*
*                          STORAGE AREA
*
*
***********************************************************************
INPUT    DS    CL80              INPUT BUFFER
         DC    C'*'              DELIMITER
         ORG   MAIN+((*-MAIN+31)/32*32)
         DC    CL32'       TABLE 1 STARTS HERE     '
TABLE    DC    320F'-1'
EOT      DS    F
         ORG   MAIN+((*-MAIN+31)/32*32)
         DC    CL32'       TABLE 2 STARTS HERE     '
TABLE2   DC    320F'-1'
EOT2     DS    F                 ADDRESS OF END OF TABLE
         ORG   MAIN+((*-MAIN+31)/32*32)
         DC    CL32'       TABLE 3 STARTS HERE     '
TABLE3   DC    640F'-1'
EOT3     DC    A(EOT3)
RSAVE    DS    16F               AREA TO SAVE REGISTERS
PARM     DC    A(EOT,TABLE,INPUT) STORES ADDRESS TO BE PASSED TO FUNC.
PARM2    DC    A(EOT2,TABLE2,INPUT)
PARM3    DC    A(EOT,TABLE,EOT2,TABLE2,EOT3,TABLE3,INPUT)
PARM4    DC    A(EOT3,TABLE3,INPUT)
TEMP     DC    CL64' '            USED AS A TEMP FOR THE SWAP.
FLAG1    DC    F'9'               USED IN MERGE AS A FLAG
FLAG2    DC    F'5'               USED IN MERGE AS A FLAG
TEST     DC    F'9999999'         USED AS A TEST VALUE IN MERGE
***********************************************************************
*
*                 STORAGE BELOW SETS UP PRINT LINES
*
***********************************************************************
TITLE    DC    C'1'              TITLE PRINT TITLE HEADING
         DC    CL40' '
         DC    CL36'DEKALB DISC SORTED STOCK INFORMATION'
HEADING  DC    C'-'              HEADING PRINTS COLUMN HEADINGS
         DC    CL12'STOCK NUMBER'
         DC    CL12' '
         DC    CL24'        ARTIST          '
         DC    CL12' '
         DC    CL24'       CD TITLE         '
         DC    CL12' '
         DC    CL12'# IN STOCK  '
         DC    CL12' '
         DC    CL12'  CD PRICE  '
UNDER    DC    C'0'              UNDER UNDERLINES COLUMN HEADINGS
         DC    CL12'------------'
         DC    CL12' '
         DC    CL24'------------------------'
         DC    CL12' '
         DC    CL24'------------------------'
         DC    CL12' '
         DC    CL12'------------'
         DC    CL12' '
         DC    CL12'------------'
DATA     DC    C'0'              DATA PRINTS DATA FROM TABLE
STKNUM   DS    CL12              STOCK NUMBER
         DC    CL12' '
ARTNAM   DS    CL24              ARTISTS NAME
         DC    CL12' '
CDTTL    DS    CL24              CD TITLE
         DC    CL12' '
INSTOCK  DS    CL12              NUMBER OF COPIES IN STOCK
         DC    CL11' '
PRICE    DS    CL12              PRICE OF CD.
*********************************************************************
*                                                                   *
*                 STORAGE BELOW SETS UP UPDATE PRINT LINES          *
*                                                                   *
*********************************************************************
UPTTL    DC    C'1'             TITLE PRINT UPDATE TITLE HEADING
         DC    CL40' '
         DC    CL30'DEKALB DISC TRANSACTION REPORT'
UPHEAD   DC    C'-'             HEADING PRINTS COLUMN HEADINGS
         DC    CL24'        ARTIST          '
         DC    CL12' '
         DC    CL24'       CD TITLE         '
         DC    CL12' '
         DC    CL12'STOCK NUMBER'
         DC    CL12' '         
         DC    CL12'# IN STOCK  '
         DC    CL12' '
         DC    CL12'  CD PRICE  '
UPUNDER  DC    C'0'              UNDER UNDERLINES COLUMN HEADINGS
         DC    CL24'------------------------'
         DC    CL12' '
         DC    CL24'------------------------'
         DC    CL12' '
         DC    CL12'------------'
         DC    CL12' '
         DC    CL12'------------'
         DC    CL12' '
         DC    CL12'------------'
UPDATA   DC    C'0'              UPDATA PRINTS UPDATED DATA
UPNAME   DS    CL24              ARTIST NAME
         DC    CL12' '
UPCDTTL  DS    CL24              CD TITLE
         DC    CL12' '
UPSTKN   DS    CL12              STOCK NUMBER
         DC    CL12' '
UPINSTK  DS    CL12              UPDATED COPIES IN STOCK
         DC    CL11' '
UPPRC    DS    CL12              PRICE OF CD.
ERRDATA  DC    C'0'              ERRDATA PRINTS ERROR MSG
ERRNAME  DS    CL24              ARTIST WHICH WAS NOT FOUND
         DC    CL12' '
         DC    CL40' ******   ERR:  ARTIST NOT FOUND  ******'
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
//FT05F001 DD DSN=T90MES1.C360(DATA6),DISP=SHR
//

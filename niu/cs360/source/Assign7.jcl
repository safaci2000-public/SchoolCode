//Z002161A JOB ,'Samir Faci',MSGLEVEL=(1,0)
/*JOBPARM  NOLOG,ROOM=161
// EXEC ASSIST
//SYSIN DD *
         TITLE 'SAMIR FACI CSCI 360 SECTION 1 ASSIGNMENT 7'
***********************************************************************
*                                                                     *
*                         CSCI 360 Program 7                          *
*                                                                     *
* Function:                                                           *
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
*              R4      STORES ADDRES OF TABLE                         *
*              R3      STORES EOT/ANA OF TABLE                        *
*              R8      INPUT BUFFER                                   *
* NOTES:                                                              *
***********************************************************************
         EJECT
MAIN     CSECT
         LA    R12,4095(,R15)    ESTABLISHES LINKAGE
         LA    R12,1(,R12)       ESTABLISHES LINKAGE
         USING MAIN,R15,R12      USING R15 & R12
*         XPRNT TITLE,77          PRINTS TITLE OF PAGE
*         XPRNT HEADING,102       PRINTS COLUMN HEADINGS
*         XPRNT UNDER,101         PRINTS DASHES UNDER THE HEADINGS
         LA    R1,PARM           LOADS ADDRESS OF PARAMETERS LIST
         L     R8,8(R1)          SAVES THE @ OF INPUT BUFFER INTO R8
         LM    R3,R4,0(R1)       LOADS PARM LIST INTO REGISTERS
LOOP     BAL   R10,BUILD        BRANCHES TO BUILD AND BUILDS 1ST TABLE
         C     R5,=F'1'
         BE    ENDLP            BRANCHES TO END OF LOOP ON EQUAL
         BAL   R10,SORT         BRANCHES TO SORT THE TABLE.
         BAL   R10,PRT          BRANCES TO PRT TO PRINT TABLE
         LM     R3,R4,0(R1)     LOADS PARMS FROM R1
         LR     R4,R3            LOADS ANA INTO R4 TO CONTINUE
*                                BUILDING TABLE
         B     LOOP             UNCONDITIONAL BRANCH TO LOOP
ENDLP    XDUMP TABLE,2080
         LM    R3,R4,0(R1)
         BAL   R10,UPDATE
*         BAL   R10,PRT
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
         CLC   0(6,R8),TEST2
         BE    ENDBLD2
         PACK  TEMP2(4),0(6,R8)
         CP    TEMP2(4),=P'10'     COMPRES TO FLAG
         BL    ENDBLD
         PACK  0(4,R4),0(6,R8)
         MVC   4(16,R4),7(R8)    STORES ARTIST NAME
         PACK  20(5,R4),58(9,R8) ISBN NUMBER
         MVC   25(23,R4),24(R8)  STORES THE CD TITLE
         PACK  48(3,R4),52(5,R8) PRICE
         PACK  51(2,R4),48(3,R8) NUM OF COPIES
         BC    B'1000',ENDBLD    BRANCHES TO END OF BUILD ON EQUAL
         LA    R4,64(,R4)         POSITIONS POINTER TO NEXT RECORD
*                                 FIELD
         XREAD 0(R8),80          READS NEXT RECORD
         BC    B'1111',BLDRD     UNCONDITIONAL BRANCE TO BLDRD
ENDBLD2  L     R5,=F'1'          LOADS FLAG INTO R5
         ST    R4,0(R1)          STORES ANA ADDRESS IN PARM LIST
         BR    R10               BRANCHES BACK TO MAIN.
         LTORG
         SPACE 2
ENDBLD   ST    R4,0(R1)          STORES ANA INTO PARM LIST.
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
SORT     LA    R1,PARM
         LM    R3,R4,0(R1)       STORES ADDRESS OF LAST ENTRY INTO R3
         S     R3,=F'64'         POINTS ANA TO LAST ENTRY.
SRT      CR    R3,R4             COMPARES EOT WITH TABLE
         BC    B'1100',ENDSRT    BRANCH TO ENDSRT IF R4 >= R3
         LR    R5,R4             SET R5 = BEGIN OF TABLE
         LA    R6,64(R4)         SETS R6 = BEGIN + 1 ENTRY
LP1      CR    R6,R3             COMPARES I AND EOT
         BC    B'0010',ENDLP1    BRANCHES TO ENDLP1 ON <=
         CP    0(4,R5),0(4,R6)   COMPARES STOCK ID.
         BC    B'1100',ENDIF     BRANCHES IF R5 <= R6
         LR    R5,R6             SETS LOW = I      
ENDIF    LA    R6,64(R6)         MOVES I TO NEXT RECORD
         B     LP1               UNCONDITIONAL BRANCH TO LP1
ENDLP1   MVC   TEMP(64),0(R4)    MOVES BEGIN TO TEMP STORAGE
         MVC   0(64,R4),0(R5)    MOVES LOW TO TOP OF NONSORTED TABLE
         MVC   0(64,R5),TEMP     MOVES TOP OF TABLE TO R5 (LOW)
         LA    R4,64(R4)         ADVANCES BEGIN TO NEXT FIELD
         B     SRT               UNCONDITIONAL BRANCH TO SRT1
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
UPDATE   LA    R1,PARM           SHOULD BE LINE BELOW
         LM    R3,R4,0(R1)       LOADS ADDRESS INTO FROM PARM.
         XREAD 0(R8),80          READS INPUT RECORD
         BC    B'0100',EOF       BRANCHES ON EOF
         CLC   34(1,R8),C'S'
         BE    EOF
         B     UPDATE
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
PRT      XPRNT TITLE,77
         XPRNT HEADING,102
         XPRNT UNDER,101
         LA    R1,PARM
         STM   R0,R15,RSAVE      STORES ALL REGISTERS
         LM    R3,R4,0(R1)       LOADS ADDRESS FROM PARM
         ZAP   TOTAL(6),=P'0'    INITIALIZES TOTAL TO ZERO
         ZAP   TOTCDS(4),=P'0'   INTIIALIZES TOTCDS TO ZERO
PRTLP    CR    R4,R3             COMPARES ADDRESSES
         BC    B'1011',ENDPRT    BRANCH IF <=
         BE    ENDPRT            BRANCHES TO ENDLP ON EQUAL
         ZAP   TEMP3(6),48(3,R4) STORES CD PRICE INTO TEMP3
         MP    TEMP3(6),51(2,R4) MULTIPLIES PRICE BY QUANTITY
         AP    TOTAL(6),TEMP3(6) STORES TOTAL INV. VAL IN TOTAL
         AP    TOTCDS(4),51(2,R4) STORES TOT CDS IN INV. IN TOTCDS
         SPACE 2
         MVC   STKNUM(8),=X'4020202020202020'  SETS UP THE MASK
         ED    STKNUM(8),0(R4)
         MVC   ARTNAM(16),4(R4)
         MVC   CDTTL(23),25(R4)
         MVC   INSTOCK(4),=X'40202120'
         ED    INSTOCK(4),51(R4)
         MVC   PRICE(8),=X'40402021204B2020'
         EDMK  PRICE(8),48(R4)
         BCTR  R1,R0
         MVI   0(R1),C'$'
         MVC   ISBN(12),=X'404040202020202020202020'
         ED    ISBN(12),20(R4)
         LA    R4,64(,R4)        GOES TO NEXT RECORD IN TABLE
         XPRNT DATA,101          PRINTS DATA
         BC    B'1111',PRTLP     UNCONDITIONAL LOOP TO PRTLP
ENDPRT   MVC   INVVAL(15),=X'402020206B2020206B2120204B2020'
         EDMK  INVVAL(15),TOTAL
         BCTR  R1,R0
         MVI   0(R1),C'$'
         XPRNT DATA2,43
         MVC   INVCDS(4),=X'40402020'
         ED    INVCDS(4),TOTCDS
         XPRNT DATA3,32
         ZAP   AVG(8),TOTAL(6)
         SRP   AVG(8),1,0
         DP    AVG(8),TOTCDS(4)
         MVC   AVGCDS(13),=X'40206B20202020206B2120204B2020'
         EDMK  AVGCDS(13),AVG
         BCTR  R1,R0
         MVI   0(R1),C'$'
         XPRNT DATA4,41
         LM    R0,R15,RSAVE      RESTORES REGISTERS
         DC    X'F5F5F5'
         BR    R10               BRANCHES BACK TO MAIN
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
         SPACE
         TITLE 'STORAGE AREA     '
***********************************************************************
*
*                          STORAGE AREA
*
*
***********************************************************************
INPUT    DS    CL80              INPUT BUFFER
         DC    C'*'              DELIMITER
         DC    CL32'       TABLE 1 STARTS HERE     '
TABLE    DC    520F'-1'
EOT      DS    F
RSAVE    DS    16F               AREA TO SAVE REGISTERS
PARM     DC    A(EOT,TABLE,INPUT) STORES ADDRESS TO BE PASSED TO FUNC.
TEMP     DC    CL64' '            USED AS A TEMP FOR THE SWAP.
TEMP2    DS    PL4
TEMP3    DC    PL6'0'
TOTAL    DC    PL6'0'
TOTCDS   DS    PL4
AVG      DS    PL8
FLAG1    DC    F'9'               USED IN MERGE AS A FLAG
FLAG2    DC    F'5'               USED IN MERGE AS A FLAG
TEST     DC    F'9999999'         USED AS A TEST VALUE IN MERGE
TEST2    DC    CL6'    0T'
***********************************************************************
*
*                 STORAGE BELOW SETS UP PRINT LINES
*
***********************************************************************
TITLE    DC    C'1'              TITLE PRINT TITLE HEADING
         DC    CL40' '
         DC    CL36'   SORTED CD STOCK FOR CD EMPIRE    '
HEADING  DC    C'-'              HEADING PRINTS COLUMN HEADINGS
         DC    CL12'STOCK NUMBER'
         DC    CL5' '
         DC    CL19'   ARTIST          '
         DC    CL5' '
         DC    CL21'    CD TITLE         '
         DC    CL5' '
         DC    CL4' #  '
         DC    CL5' '
         DC    CL10'CD PRICE  '
         DC    CL5' '
         DC    CL10'ISBN #    '
UNDER    DC    C'0'              UNDER UNDERLINES COLUMN HEADINGS
         DC    CL12'------------'
         DC    CL5' '
         DC    CL16'----------------'
         DC    CL5' '
         DC    CL23'-----------------------'
         DC    CL5' '
         DC    CL4'----'
         DC    CL5' '
         DC    CL10'----------'
         DC    CL5' '
         DC    CL10'----------'
DATA     DC    C'0'              DATA PRINTS DATA FROM TABLE
STKNUM   DC    CL12' '            STOCK NUMBER
         DC    CL5' '
ARTNAM   DC    CL16' '           ARTISTS NAME
         DC    CL5' '
CDTTL    DC    CL23' '           CD TITLE
         DC    CL5' '
INSTOCK  DC    CL4' '              NUMBER OF COPIES IN STOCK
         DC    CL5' '
PRICE    DC    CL8' '           PRICE OF CD.
         DC    CL5' '
ISBN     DC    CL12' '
DATA2    DC    C'-'
         DC    CL27'TOTAL INVENTORY VALUE:     '
INVVAL   DC    CL15' '
DATA3    DC    C'0'
         DC    CL27'TOTAL NUMBER OF CDS  :     '
INVCDS   DC    CL4' '
DATA4    DC    C'0'
         DC    CL27'AVERAGE CD VALUE     :     '
AVGCDS   DC    CL13' '
*********************************************************************
*                                                                   *
*                 STORAGE BELOW SETS UP UPDATE PRINT LINES          *
*                                                                   *
*********************************************************************
UPTTL    DC    C'1'             TITLE PRINT UPDATE TITLE HEADING
         DC    CL40' '
         DC    CL32'TRANSACTION REPORT FOR CD EMPIRE'
UPHEAD   DC    C'-'             HEADING PRINTS COLUMN HEADINGS
         DC    CL24'        ARTIST          '
         DC    CL12' '
         DC    CL24'       CD TITLE         '
         DC    CL12' '
         DC    CL12'  QUANTITY  '
         DC    CL12' '
         DC    CL12'  RETURN    '
         DC    CL12' '
         DC    CL12'  AMOUNT    '
         DC    CL12' '
         DC    CL12'  QUANTITY  '
UPHEAD2  DC    C' '
         DC    CL72' '
         DC    CL12'  ON HAND   '
         DC    CL12' '
         DC    CL12'   OR       '
         DC    CL36' '
         DC    CL12'  ON HAND   '
UPHEAD3  DC    C' '
         DC    CL72' '
         DC    CL12'  BEFORE    '
         DC    CL12' '
         DC    CL12'  SALE      '
         DC    CL36' '
         DC    CL12'  AFTER     '
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
//FT05F001 DD DSN=T90MES1.C360(DATA7),DISP=SHR
//

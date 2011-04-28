//Z002161A JOB ,'Samir Faci',MSGLEVEL=(1,0)
/*JOBPARM  NOLOG,ROOM=161
// EXEC ASSIST
//SYSIN DD *
         TITLE 'SAMIR FACI CSCI 360 SECTION 1 ASSIGNMENT 5'
***********************************************************************
*                                                                     *
*                         CSCI 360 Program 5                          *
*                                                                     *
* Function:  Read in a bunch of store stock data, stores it in a      *
*            table and prints in a easy to read format.               *
*            it also sorts the table and updates the table.           *
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
*              R4      STORES ADDRES OF TABLE                         *
*              R10     STORES RETURN ADDRESS OF MAIN SUBROUTINE       *
* NOTES:                                                              *
***********************************************************************
         EJECT
MAIN     CSECT
         USING MAIN,R15
         XPRNT TITLE,77          PRINTS TITLE OF PAGE
         XPRNT HEADING,133       PRINTS COLUMN HEADINGS
         XPRNT UNDER,133         PRINTS DASHES UNDER THE HEADINGS
         LA    R2,PARM           LOADS ADDRESS OF PARAMETERS LIST
         L     R4,0(R2)          LOADS THE ADDRESS OF TABLE INTO R4
         BAL   R10,BUILD         BRANCHES TO BUILD AND BUILDS TABLE
         BAL   R10,SORT          BRANCHES TO SORT THE TABLE.
         BAL   R10,PRT           BRANCES TO PRT TO PRINT TABLE
         XPRNT UPTTL,71          PRINTS UPDATED TITLE
         XPRNT UPHEAD,133        PRINTS UPDATED HEADINGS
         XPRNT UPUNDER,133       UNDERLINES HEADINGS
         BAL   R10,UPDATE        BRANCHES TO UPDATE SUBROUTINE
         XPRNT TITLE,77          PRINTS TITLE OF PAGE
         XPRNT HEADING,133       PRINTS COLUMN HEADINGS
         XPRNT UNDER,133         PRINTS DASHES UNDER THE HEADINGS
         BAL   R10,PRT           BRANCHES TO PRINT SUBROUTINE TO PRINT
         XDUMP TABLE,1280        DUMPS TABLE
         BR    R14               RETURNS TO CALLER
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
***********************************************************************
*       NAME:           BUILD                                         *
*       FUNCTION:       TO BUILD THE TABLES                           *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *
*       REGISTER USE:   R2 - PARM LIST                                *
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
BUILD    STM   R0,R15,RSAVE      STORES ALL REGISTERS INTO RSAVE
         XREAD INPUT,80          READS INPUT BUFFER
BLDRD    BC    B'0100',ENDBLD    BRANCES TO ENDBLD ON EOF
         XDECI R5,INPUT          STORES STOCK NUM INTO R5
         C     R5,=F'000000'     COMPARES VALUE OF R5 WITH ZEROS
         BC    B'1000',ENDBLD    BRANCHES TO END OF BUILD ON EQUAL
         MVC   4(24,R4),INPUT+7  STORES ARTIST NAME
         MVC   32(24,R4),INPUT+32 STORES THE CD TITLE
         XDECI R6,INPUT+57       STORES THE NUMBER IN STOCK
         XDECI R7,INPUT+61       STORES PRICE OF CD
         ST    R5,0(R4)          STORES VALUE IN TABLE
         ST    R6,52(R4)         STORES VALUE IN TABLE
         ST    R7,56(R4)         STORES VALUE IN TABLE
         MVC   60(4,R4),=F'-1'
         LA    R4,64(R4)         POSITIONS POINTER TO NEXT RECORD
*                                FIELD
         XREAD INPUT,80          READS NEXT RECORD
         BC    B'1111',BLDRD     UNCONDITIONAL BRANCE TO BLDRD
ENDBLD   S     R4,=F'4'          SUBSTRACTS 4 BYTES FROM ADDRESS
         ST    R4,4(R2)          STORE ADDRESS AS A VALUE IN EOT
         LM    R0,R15,RSAVE      RESTORES REGISTERS
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
*       REGISTER USE:   R2 - PARM LIST                                *
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
SORT     L     R3,4(R2)          STORES EOT INTO ADDRESS IN R3
         L     R4,0(R2)          STORES TABLE @ INTO R4
SRT1     CR    R3,R4             COMPARES EOT WITH TABLE
         BL    ENDSRT            BRANCH TO ENDSRT IF R4 >= R3
         LR    R5,R4             SET R5 = BEGIN OF TABLE
         LA    R6,64(R4)         SETS R6 = BEGIN + 1 ENTRY
LP1      CR    R6,R3             COMPARES I AND EOT
         BC    B'0010',ENDLP1    BRANCHES TO ENDLP1 ON <=
         CLC   4(24,R5),4(R6)    COMPARES ARTISTS NAMES
         BC    B'1100',ENDIF     BRANCHES IF R5 <= R6
         LR    R5,R6             SETS LOW = I      
ENDIF    LA    R6,64(R6)         MOVES I TO NEXT RECORD
         BC    B'1111',LP1       UNCONDITIONAL BRANCH TO LP1
ENDLP1   MVC   TEMP(64),0(R4)    MOVES BEGIN TO TEMP STORAGE
         MVC   0(64,R4),0(R5)    MOVES LOW TO TOP OF NONSORTED TABLE
         MVC   0(64,R5),TEMP     MOVES TOP OF TABLE TO R5 (LOW)
         LA    R4,64(R4)         ADVANCES BEGIN TO NEXT FIELD
         BC    B'1111',SRT1      UNCONDITIONAL BRANCH TO SRT1
ENDSRT   BR    R10               RETURNS CONTROL TO MAIN.
         LTORG
         EJECT
***********************************************************************
*       NAME:           UPDATE                                        *
*       FUNCTION:       TO UPDATE THE RECORDS IN THE TABLE            *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *
*       REGISTER USE:   R2 - PARM LIST                                *
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
UPDATE   L     R4,0(R2)          LOADS TABLE @ INTO R4
         L     R3,4(R2)          LOADS EOT @ INTO R3
         XREAD INPUT,80          READS INPUT RECORD
         BC    B'0100',EOF       BRANCHES ON EOF
DO1      CLC   4(24,R4),INPUT    COMPARES CONTENT OF R4 WITH INPUT
         BC    B'1000',ENDDO     BRANCHES TO ENDO ON =
         LA    R4,64(R4)         MOVES R4 TO NEXT RECORD
         CR    R3,R4             COMPARES EOT TO TABLE @
         BC    B'0100',ERR       BRANCH IF R3 > R4
         B     DO1               UNCONDITIONAL BRANCH TO DO1
ENDDO    XDECI R6,INPUT+24       XDECI CD SOLD
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
*       REGISTER USE:   R2 - PARM LIST                                *
*
*       PSEUDOCODE:     NONE...PRINT ERROR, THAT'S IT.                *
*
*       NOTES:          NONE                                          *
***********************************************************************
ERR      MVC   ERRNAME(24),INPUT MOVES NAME NOT FOUND TO PRINT FIELD
         XPRNT ERRDATA,76        PRINTS ERROR MSG.
         B     UPDATE            UNCONDITIONAL BRANCH TO UPDATE
         EJECT
***********************************************************************
*       NAME:           PRINT                                         *
*       FUNCTION:       TO BUILD THE TABLES                           *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *
*       REGISTER USE:   R2 - PARM LIST                                *
*                       R3 - TABLE ADDRESS                            *
*                       R4 -  END OF TABLE ADDRESS                    *
*                       R5 - STORES VALUE TO BE PRINTED               *
*                       R10 - EXIT LINKAGE                            *
*       PSEUDOCODE:     DO WHILE NOT EOF                              *
*                        PRINT RECORDS OF TABLE.                      *
*                       ON EOF, EXIT LOOP AND RETURN TO MAIN.         *
*       NOTES:          NONE                                          *
***********************************************************************         
PRT      STM   R0,R15,RSAVE      STORES ALL REGISTERS
         L     R3,0(R2)          LOADS ADDRESS OF TABLE INTO R3
         L     R4,4(R2)          STORES ADDRESS OF LAST ENTRY INTO R4
PRTLP    CR    R3,R4             COMPARES ADDRESSES
         BC    B'1011',ENDPRT    BRANCH IF <=
         L     R5,0(R3)          LOADS 1ST VAL FROM TABLE
         XDECO R5,STKNUM         PREPARES FOR PRINT
         L     R5,4(R3)          LOADS 2ND VAL FROM TABLE
         MVC   ARTNAM(24),4(R3)  LOADS ARTIST NAME INTO DETAIL LINE
         MVC   CDTTL(24),28(R3)  LOADS CD TITLE INTO DETAIL LINE
         L     R5,52(R3)         LOADS 3D VAL FROM TABLE
         XDECO R5,INSTOCK        PREPARES FOR PRINT
         L     R5,56(R3)         LOAD PRICE INTO R5 
         XDECO R5,PRICE          PREPARES FOR PRINT
         LA    R3,64(,R3)        GOES TO NEXT RECORD IN TABLE
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
TABLE    DC    320F'-1'          80 FULLWORDS TABLE
EOT      DS    F                 ADDRESS OF END OF TABLE
RSAVE    DS    16F               AREA TO SAVE REGISTERS
PARM     DC    A(TABLE,EOT,INPUT)     STORES ADDRESS OF PARAMETERS
TEMP     DC    CL64' '
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
         DC    CL12' '
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
         DC    CL12' '
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

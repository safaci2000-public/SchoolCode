//Z002161A JOB ,'Samir Faci',MSGLEVEL=(1,0)
/*JOBPARM  NOLOG,ROOM=161
// EXEC ASSIST
//SYSIN DD *
         TITLE 'SAMIR FACI CSCI 360 SECTION 1 ASSIGNMENT 8'
***********************************************************************
*                                                                     *
*                         CSCI 360 Program 8                          *
*                                                                     *
* Function:  Read in a bunch of store stock data, stores it in 2      *
*            tables and prints in a easy to read format.              *
*            it also sorts the table and updates the table.           *
*            it also merges the 2 tables.                             *
*            NEW FEATURE:  now using external subroutines             *
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
*              R15     STANDARD LINKAGE                               *
*              R11     STANDARD LINKAGE                               *
*
*         R14,R13,R15  USED FOR EXTERNAL SUBROUTINES LINKING          *
* NOTES:                                                              *
***********************************************************************
         EJECT
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
*BUILD
         LA    R1,PARM           LOADS ADDRESS OF PARAMETERS LIST
         L     R15,=V(BUILD)    STORES ADDRESS INTO R15
         BALR  R14,R15          BRANCHES TO BUILD AND BUILDS 1ST TABLE
*SORT
         LA    R1,PARM          LOADS ADDRESS OF PARM INTO R1
         L     R15,=V(SORT)     STORES ADDRESS OF SORT INTO R15
         BALR  R14,R15          BRANCHES TO SORT.
*PRINT FIRST TABLE
         LA    R1,PARM          LOADS ADDRESS OF PARM INTO R1
         L     R15,=V(PRT)      STORES & OF PRT INTO R15
         BALR  R14,R15          BRANCHES TO PRT.
*
*BUILD
         LA    R1,PARM2          LOADS ADDRESS OF PARAMETERS LIST
         L     R15,=V(BUILD)     STORES & OF BUILD INTO R15
         BALR  R14,R15          BRANCHES TO BUILD AND BUILDS 2ND TABLE
*SORT
         LA    R1,PARM2          LOADS ADDRESS OF PARM LIST INTO R1
         L     R15,=V(SORT)      STORES ADDRESS OF SORT INTO R15
         BALR  R14,R15           BRANCH TO SORT.
*PRINT SECOND TABLE
         LA    R1,PARM2          LOADS ADDRESS OF PARM2 TO R1
         L     R15,=V(PRT)       LOADS ADDRESS OF PRT INTO R15
         BALR  R14,R15           BRANCHES TO PRT.
*MERGE
         LA    R1,PARM3          LOADS ADDRESS OF PARM3 INTO R1
         MVC   0(4,R1),PARM      STORES ANA OF TBL1 INTO PARM3
         MVC   8(4,R1),PARM2     STORES ANA OF TBL2 INTO PARM3
         L     R15,=V(MERGE)     LOADS ADDRESS OF MERGE INTO R15
         BALR  R14,R15           BRANCHES TO MERGE.
*
*PRINT MERGED TABLE
         LA    R1,PARM4         LOAD & OF PARM4 INTO R1
         MVC   0(4,R1),PARM3+16 STORES ANA INTO PARM4
         L     R15,=V(PRT)      LOADS & OF PRT INTO R15
         BALR  R14,R15          BRANCHES TO PRT
*
*UPDATE
         LA    R1,PARM4         LOADS ADDRESS OF PARM4 INTO R1
         L     R15,=V(UPDATE)   STORES & OF UPDATE INTO R15
         BALR  R14,R15          BRANCHES TO UPDATE.
*
*PRINT MERGE TABLE ONCE UPDATED.
         LA    R1,PARM4         LOAD & OF PARM4 INTO R1
         L     R15,=V(PRT)      LOADS & OF PRT INTO R15
         BALR  R14,R15          BRANCHES TO PRT
*
         XDUMP TABLE,920        DUMPS 1ST TABLE
         XDUMP TABLE2,920       DUMPS 2ND TABLE
         XDUMP TABLE3,2400      DUMPS MERGED TABLE
*
*
*EXIT LINKAGE
         L     R13,4(R13)
         LM    R14,R12,12(R13)
         BR    R14               RETURNS TO CALLER
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
         TITLE 'MAIN STORAGE'
***********************************************************************
*
*                          STORAGE AREA
*
*
***********************************************************************
         ORG   MAIN+((*-MAIN+31)/32*32)
         DC    CL32'       TABLE 1 STARTS HERE     '
TABLE    DC    230F'-1'
EOT      DS    F
         ORG   MAIN+((*-MAIN+31)/32*32)
         DC    CL32'       TABLE 2 STARTS HERE     '
TABLE2   DC    230F'-1'
EOT2     DS    F                 ADDRESS OF END OF TABLE
         ORG   MAIN+((*-MAIN+31)/32*32)
         DC    CL32'       TABLE 3 STARTS HERE     '
TABLE3   DC    600F'-1'
EOT3     DC    A(EOT3)
MAINSAVE DS    18F               AREA TO SAVE REGISTERS
PARM     DC    A(EOT,TABLE,INPUT) STORES ADDRESS TO BE PASSED TO FUNC.
PARM2    DC    A(EOT2,TABLE2,INPUT)
PARM3    DC    A(EOT,TABLE,EOT2,TABLE2,EOT3,TABLE3)
PARM4    DC    A(EOT3,TABLE3,INPUT)
***********************************************************************
*       NAME:           BUILD                                         *
*       FUNCTION:       TO BUILD THE 1ST TABLES                       *
*       INPUT:          A FILE ON DISK                                *
*       OUTPUT:         NONE                                          *
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *
*       REGISTER USE:   R1 - PARM LIST                                *
*                       R4 - TABLE ADDRESS                            *
*                       R5 - INPUT BUFFER                             *
*       PSEUDOCODE:     DO WHILE NOT EOF                              *
*                        ENTER RECORD INTO THE TABLE.                 *
*                       ON EOF, EXIT LOOP AND RETURN TO MAIN.         *
*                                                                     *
*       NOTES:          CVB/CVD ARE USED IN UPDATE/MERGE SINCE TABLE  *
*                       IS STORED AS PACKARD DECIMAL INSTEAD OF BINARY*
***********************************************************************
BUILD    CSECT
*ENTRY
         STM   R14,R12,12(R13)  SAVES ALL REGS.
         LR    R12,R15          GETS BASE REGISTER
         USING BUILD,R12        ESTABLISHES ADDRESIBILITY
         LA    R14,BLDSAVE      LOADS & OF BLDSAVE INTO R14
         ST    R13,4(R14)       SAVES BACKWARD POINTER
         ST    R14,8(R13)       SAVES FORWARD POINTER
         LR    R13,R14          GET STORAGE IN R13
*code
         LM    R3,R5,0(R1)       LOADS PARM INTO REGS.
         XREAD 0(R5),80          READS INPUT BUFFER
BLDRD    BC    B'0100',ENDBLD    BRANCES TO ENDBLD ON EOF
         PACK  TEMP2(4),0(6,R5)  PACKS STOCK NUM INTO TEMP2
         CP    TEMP2(4),=P'0'    COMPARES TO 0
         BE    ENDBLD            BRANCHES ON EQAUL
         PACK  0(4,R4),0(6,R5)   PACKS STOCK NUM INTO TABLE
         MVC   4(24,R4),7(R5)    STORES ARTIST NAME
         MVC   28(24,R4),32(R5)  STORES THE CD TITLE
         PACK  52(2,R4),57(2,R5) PACKS THE NUMBER IN STOCK
         PACK  54(3,R4),61(4,R5) PACKS THE PRICE OF CDS.
         LA    R4,64(R4)         POSITIONS POINTER TO NEXT RECORD
*                                FIELD
         XREAD 0(R5),80          READS NEXT RECORD
         BC    B'1111',BLDRD     UNCONDITIONAL BRANCE TO BLDRD
ENDBLD   DS    0H
         ST    R4,0(R1)          STORES ANA INTO 0(R1)
*exit 
         L     R13,4(R13)        GETS BACKWARD POINTER
         LM    R14,R12,12(R13)   RESTORES REGS.
         BR    R14               BRANCHES BACK TO MAIN
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         SPACE
         EJECT
BLDSAVE  DS    18F               USED TO BACKUP REGISTERS
TEMP2    DS    PL4               TEMP VAR USED TO BUILD TABLE.
INPUT    DS    CL80              INPUT BUFFER
         DC    C'*'              DELIMITER
*
*
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
*       PSEUDOCODE:     DO WHILE NOT EOF                              *
*                        SWAP CONTENT OF R5 & R6 UNTIL LOW VALUES ARE *
*                        ON TOP AND HIGH VALUES ON BOTTOM USING       *
*                        INSERTION SORT.                              *
*       NOTES:          NONE                                          *
***********************************************************************         
SORT     CSECT
*
*EMTRY LINKAGE
         STM   R14,R12,12(R13)  SAVES ALL REGS
         LR    R12,R15          GETS BASE REGISTER
         USING SORT,R12         ESTABLISHES ADDRESSIBILITY
         LA    R14,SORTSAVE     LOADS @ OF SOFTSAVE INTO R14
         ST    R13,4(R14)       SAVE BACKWARD POINTER
         ST    R14,8(R13)       SAVE FORWARD POINTER
         LR    R13,R14          GET STORAGE @ R13
*
         LM    R3,R4,0(R1)
SRT      CR    R3,R4             COMPARES EOT WITH TABLE
         BC    B'1100',ENDSRT    BRANCH TO ENDSRT IF R4 >= R3
         LR    R5,R4             SET R5 = BEGIN OF TABLE
         LA    R6,64(R4)         SETS R6 = BEGIN + 1 ENTRY
LP1      CR    R6,R3             COMPARES I AND EOT
         BC    B'1010',ENDLP1    BRANCHES TO ENDLP1 ON <=
         CP    0(4,R5),0(4,R6)   COMPARES STOCK NUMBER
         BC    B'1100',ENDIF     BRANCHES IF R5 <= R6
         LR    R5,R6             SETS LOW = I      
ENDIF    LA    R6,64(R6)         MOVES I TO NEXT RECORD
         BC    B'1111',LP1       UNCONDITIONAL BRANCH TO LP1
ENDLP1   MVC   TEMP(64),0(R4)    MOVES BEGIN TO TEMP STORAGE
         MVC   0(64,R4),0(R5)    MOVES LOW TO TOP OF NONSORTED TABLE
         MVC   0(64,R5),TEMP     MOVES TOP OF TABLE TO R5 (LOW)
         LA    R4,64(R4)         ADVANCES BEGIN TO NEXT FIELD
         BC    B'1111',SRT       UNCONDITIONAL BRANCH TO SRT1
ENDSRT   DS    0H
*EXIT LINKAGE         
         L     R13,4(R13)        GETS BACKWARD POINTER
         LM    R14,R12,12(R13)   RESTORES ALL REGS.
         BR    R14               RETURNS CONTROL TO MAIN.
         LTORG
         EJECT
SORTSAVE DS    18F                USED TO BACKUP REGISTERS.
TEMP     DC    CL64' '            USED AS A TEMP FOR THE SWAP.
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
PRT      CSECT
*
*ENTRY LINKAGE
         STM   R14,R12,12(R13)   BACKS UP ALL REGISTERS.
         LR    R12,R15           GETS BASE ADDRESS
         USING PRT,R12           ESTABLISHES ADDRESSIBILITY
         LA    R14,PRNTSAVE      STORES @ OF PRNTSAVE INTO R14
         ST    R13,4(R14)        STORES BACKWARD POINTER INTO R13
         ST    R14,8(R13)        STORES FORWARD POINTER INTO R14
         LR    R13,R14           GET STORAGE IN R13
*
         LM    R3,R4,0(R1)
         XPRNT TITLE,77          PRINTS TITLE OF PAGE
         XPRNT HEADING,119       PRINTS COLUMN HEADINGS
         XPRNT UNDER,118         PRINTS DASHES UNDER THE HEADINGS
PRTLP    CR    R4,R3             COMPARES ADDRESSES
         BC    B'1011',ENDPRT    BRANCH IF <=
         MVC   PRTTEMP(4),0(R4)  MOVES STOCK NUM TO PRTTEMP
         CP    PRTTEMP,=P'-1'    COMPARES STOCK NUM W/ -1S.
         BE    ENDPRT            BRANCHES TO ENDLP ON EQUAL
         MVC   STKNUM(7),=X'40202020202020' SETS UP MASK
         ED    STKNUM(7),0(R4)   STORES STKNUM IN PLINE
         MVC   ARTNAM(24),4(R4)  LOADS ARTIST NAME INTO DETAIL LINE
         MVC   CDTTL(24),28(R4)  LOADS CD TITLE INTO DETAIL LINE
         MVC   INSTOCK(4),=X'40202120' SETS UP MASK
         ED    INSTOCK(4),52(R4)       LOADS INSTOCK INTO PLINE
         MVC   PRICE(8),=X'40402021204B2020' SETS UP MASK
         EDMK  PRICE(8),54(R4)   MOVES EDITED VAL INTO PLINE
         BCTR  R1,R0             MOVES R1 TO POINT TO CORRECT SLOT.
         MVI   0(R1),C'$'        INSERT $ SIGN
         LA    R4,64(R4)         GOES TO NEXT RECORD IN TABLE
         XPRNT DATA,115          PRINTS DATA
         BC    B'1111',PRTLP     UNCONDITIONAL LOOP TO PRTLP
ENDPRT   DS    0H
*EXIT LINKAGE
         L     R13,4(R13)        GET BACKWARD POINTER
         LM    R14,R12,12(R13)   RESTORES REGISTERS
         BR    R14               BRANCHES BACK TO MAIN
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
*********************************************************************
*            Print subroutine storage
*********************************************************************
PRNTSAVE DS    18F               USED TO BACKUP REGISTERS
PRTTEMP  DS    PL4               TEMP VAR USED TO CHECK IF VAL == -1
***********************************************************************
*                                                                     *
*                 STORAGE BELOW SETS UP PRINT LINES                   *
*                                                                     *
***********************************************************************
TITLE    DC    C'1'              TITLE PRINT TITLE HEADING
         DC    CL40' '
         DC    CL36'DEKALB DISC SORTED STOCK INFORMATION'
HEADING  DC    C'-'              HEADING PRINTS COLUMN HEADINGS
         DC    CL12'STOCK NUMBER'
         DC    CL8' '
         DC    CL19'   ARTIST          '
         DC    CL12' '
         DC    CL24'       CD TITLE         '
         DC    CL12' '
         DC    CL12'# IN STOCK  '
         DC    CL8' '
         DC    CL12'  CD PRICE  '
UNDER    DC    C'0'              UNDER UNDERLINES COLUMN HEADINGS
         DC    CL12'------------'
         DC    CL7' '
         DC    CL19'-------------------'
         DC    CL12' '
         DC    CL24'------------------------'
         DC    CL12' '
         DC    CL12'------------'
         DC    CL8' '
         DC    CL12'------------'
DATA     DC    C'0'              DATA PRINTS DATA FROM TABLE
STKNUM   DS    CL7               STOCK NUMBER
         DC    CL12' '
ARTNAM   DS    CL24              ARTISTS NAME
         DC    CL12' '
CDTTL    DS    CL24              CD TITLE
         DC    CL12' '
INSTOCK  DS    CL4               NUMBER OF COPIES IN STOCK
         DC    CL11' '
PRICE    DS    CL8               PRICE OF CD.
*
*
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
*                                                                     *
*       PSEUDOCODE:                                                   *
*                                                                     *
*       NOTES:          NONE                                          *
***********************************************************************
MERGE    CSECT
*ENTRY LINKAGE
         STM   R14,R12,12(R13)  SAVES ALL REGISTERS
         LR    R12,R15          GETS BASE REGISTER
         USING MERGE,R12        ESTABLISHES ADDRESSIBILITY
         LA    R14,MGSAVE       LOADS @ OF MGSAVE INTO R14
         ST    R13,4(R14)       SAVES BACKWARD POINTER
         ST    R14,8(R13)       SAVES FORWARD POINTER
         LR    R13,R14          GETS STORAGE @ R13
*
         LM    R3,R8,0(R1)
CMP      CR    R3,R4            CHECKS FOR END OF TABLE1
         BC    B'1100',INCR1    BRANCHS TO END IF EOT IS REACHED
         BC    B'1111',OVER1    BRANCHES OVER PART OF CODE
INCR1    L     R9,=F'1'         LOADS 1 INTO R9
         ST    R9,FLAG1         STORE 1 INTO FLAG1
OVER1    CR    R5,R6            CHECKS FOR END OF TABLE2
         BC    B'1100',INCR2    BRANCHS TO END IF EOT IS REACHED
         BC    B'1111',OVER2    BRANCHES OVER PART OF CODE
INCR2    L     R9,=F'1'         STORES 1 INTO R9
         ST    R9,FLAG2         STORES 1 INTO FLAG2
OVER2    CLC   FLAG1(4),FLAG2   COMPARES THE VALUES OF THE 2 FLAGS
         BC    B'1000',END      BRANCHES TO END ON EQUAL
         MVC   MRGTEST(4),0(R4) LOADS STOCK NUM INTO MRGTEST
         L     R10,FLAG2        LOADS VAL OF FLAG2 INTO R13
         C     R10,=F'1'        LOADS 1 INTO R13
         BC    B'1000',OTHCMP   BRANCHES TO OTHER COMPARE ON EQUAL
         BC    B'1111',NORM     BRANCH TO NORMAL COMPARES
OTHCMP   CP    MRGTEST(4),TEST(4) TESTS MRGTEST VAL W/ TEST VALUE
         BC    B'1111',COND     BRANCHES TO CONDITION TESTS.
NORM     CP    MRGTEST(4),0(4,R6) COMPARES KEY OF TBL1 WITH KEY OF TBL2
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
         MVC   DOUBLE(8),=D'0'     ZEROS DOUBLE
         MVC   DOUBLE+6(2),52(R4) LOADS STOCK NUMBER
         CVB   R9,DOUBLE        LOADS NUMBER IN STOCK INTO R9
         MVC   DOUBLE(8),=D'0'   RE-INITIALIZES DOUBLE
         MVC   DOUBLE+6(2),52(R6) LOADS TOCK # INTO DOUBLE
         CVB   R10,DOUBLE       LOADS NUMBER IN STOCK FROM TBL2
         AR    R9,R10           ADDS THE NUMBER IN STOCKS.
         CVD   R9,DOUBLE        CONVERTS R9 TO PD
         MVC   52(2,R8),DOUBLE+6 STORES VAL INTO TABLE.
         MVC   DOUBLE(8),=D'0'          ZEROS DOUBLE
         MVC   DOUBLE+5(3),54(R4)       STORES INTO TABLE
         CVB   R9,DOUBLE        LOADS PRICE OF TBL1 INTO R9
         MVC   DOUBLE(8),=D'0'          ZEROS DOUBLE
         MVC   DOUBLE+5(3),54(R6)       STORES PRICE INTO TABLE
         CVB   R10,DOUBLE       LOADS PRICE OF TBL2 INTO R10
         MVC   DOUBLE(8),=D'0'  STORES 0 INTO DOUBLE
         CR    R9,R10           COMPARES THE 2 PRICES.
         BC    B'0100',LOW      IF LOW GO TO LOW
         BC    B'0010',HIGH     IF HIGH GO TO HIGH
LOW      CVD   R10,DOUBLE        CONVERTS R10 TO PD
         MVC   54(3,R8),DOUBLE+5 MOVE PRICE OF R6 INTO R8
         BC    B'1111',OTHER    GOTO OTHER
HIGH     CVD   R9,DOUBLE         CONVERTS R9 TO PD
         MVC   54(3,R8),DOUBLE+5 MOVE PRICE OF R4 INTO R8
         BC    B'1111',OTHER    GOTO OTHER
OTHER    LA    R4,64(R4)        INCREMENTS TBL1 POINTER BY 1
         LA    R6,64(R6)        INCREMENTS TBL2 POINTER BY 1
INCR     LA    R8,64(R8)        INCREMENTS TBL3 POINTER BY 1
         B     CMP              UNCONDITIONAL BRANCH TO CMP
END      DS    0H
         ST    R8,16(R1)        STORES ANA INTO EOT3
         L     R13,4(R13)       GETS BACKWARD POINTER
         LM    R14,12,12(R13)   RESTORES ALL REGISTERS
         BR    R14              BRANCHES BACK TO MAIN.
         LTORG
         EJECT
MGSAVE   DS    18F                USED TO BACKUP REGS.
FLAG1    DC    F'9'               USED IN MERGE AS A FLAG
FLAG2    DC    F'5'               USED IN MERGE AS A FLAG
TEST     DC    P'9999999'         USED AS A TEST VALUE IN MERGE
DOUBLE   DC    D'0'               USED W/ CVB/CVD
MRGTEST  DS    PL4                USED AS A TEST VAR.
*
*
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
UPDATE   CSECT
*ENTRY LINKAGE
         STM   R14,R12,12(R13)  SAVES ALL REGISTERS
         LR    R12,R15          GETS BASE REGISTER
         USING UPDATE,R12       ESTABLISHES ADDRESSIBILITY
         LA    R14,UPSAVE       LOADS @ OF UPSAVE INTO R14
         ST    R13,4(R14)       SAVES BACKWARD POINTER
         ST    R14,8(R13)       SAVES FORWARD POINTER
         LR    R13,R14          GETS STORAGE @ R13
*
*
         XPRNT UPTTL,77          PRINTS TITLE OF PAGE
         XPRNT UPHEAD,121        PRINTS COLUMN HEADINGS
         XPRNT UPUNDER,121       PRINTS DASHES UNDER THE HEADINGS
UPT      LM    R3,R5,0(R1)       LOADS ADDRESSES INTO REGS.
         LR    R2,R1             BACKUP REG1 INTO R2
         XREAD 0(R5),80          READS INPUT RECORD
         BC    B'0100',EOF       BRANCHES ON EOF
DO1      CLC   0(24,R5),28(R4)   COMPARES CONTENT OF R4 WITH INPUT
         BC    B'1000',ENDDO     BRANCHES TO ENDO ON =
         LA    R4,64(R4)         MOVES R4 TO NEXT RECORD
         CR    R3,R4             COMPARES EOT TO TABLE @
         BC    B'0100',ERR       BRANCH IF R3 > R4
         B     DO1               UNCONDITIONAL BRANCH TO DO1
ENDDO    MVC   UPTEMP(4),=F'0'    MOVES 0 TO UPTEMP
         PACK  UPTEMP(2),28(2,R5) PACKS STOCK NUM INTO TEMP2
         MVC   UPDBL+6(2),UPTEMP MOVES THE PACKED NUM INTO UPDBL
         CVB   R6,UPDBL          LOADS # CD SOLD IN INTO R6
         MVC   UPDBL(8),=D'0'    MOVES 0 INTO UPDBL
         MVC   UPDBL+6(2),52(R4)  STORES VAL IN TABLE.
         CVB   R7,UPDBL          LOAD CD IN STOCK INTO R7
         SR    R7,R6             SUBSTRACT CD SOLD FROM INSTOCK
         MVC   UPDBL(8),=D'0'    ZEROS UPDBL
         CVD   R7,UPDBL          CONVERT TO PD
         MVC   52(2,R4),UPDBL+6  STORE RESULT INTO TABLE
         MVC   UPSTKN(7),=X'40202020202020' SETS UP MASK
         ED    UPSTKN(7),0(R4)   STORES STKNUM IN PLINE
         MVC   UPNAME(24),4(R4)  LOADS ARTIST NAME INTO DETAIL LINE
         MVC   UPCDTTL(24),28(R4)  LOADS CD TITLE INTO DETAIL LINE
         MVC   UPINSTK(4),=X'40202120' SETS UP MASK
         ED    UPINSTK(4),52(R4)       LOADS INSTOCK INTO PLINE
         MVC   UPPRC(8),=X'40402021204B2020' SETS UP MASK
         EDMK  UPPRC(8),54(R4)   MOVES EDITED VAL INTO PLINE
         BCTR  R1,R0             MOVES R1 TO POINT TO CORRECT SLOT.
         MVI   0(R1),C'$'        INSERT $ SIGN
         XPRNT UPDATA,115        PRINT UPDATED DATA
         LR    R1,R2             RESTORES REG1 FROM REG2.
         B     UPT               UNCONDITIONAL BRANCH TO UPDATE.
EOF      L     R13,4(R13)        GETS BACKWARD POINTER
         LM    R14,R12,12(R13)   RESTORES REGISTERS
         BR    R14               BRANCHES BACK TO MAIN.
         LTORG
         EJECT
UPTEMP   DS    PL2               USED TO READ FROM INPUT.
UPDBL    DC    D'0'              USED BY CVB/CVD
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
ERR      MVC   ERRNAME(24),0(R5) MOVES NAME NOT FOUND TO PRINT FIELD
         XPRNT ERRDATA,76        PRINTS ERROR MSG.
         B     UPT               UNCONDITIONAL BRANCH TO UPDATE
         EJECT
UPSAVE   DS    18F               USED TO SAVE REGISTER VALS.
*********************************************************************
*                                                                   *
*                 STORAGE BELOW SETS UP UPDATE PRINT LINES          *
*                                                                   *
*********************************************************************
UPTTL    DC    C'1'             TITLE PRINT UPDATE TITLE HEADING
         DC    CL40' '
         DC    CL30'DEKALB DISC TRANSACTION REPORT'
UPHEAD   DC    C'-'             HEADING PRINTS COLUMN HEADINGS
         DC    CL19'   ARTIST          '
         DC    CL12' '
         DC    CL24'       CD TITLE         '
         DC    CL12' '
         DC    CL12'STOCK NUMBER'
         DC    CL12' '         
         DC    CL12'# IN STOCK  '
         DC    CL5' '
         DC    CL12'  CD PRICE  '
UPUNDER  DC    C'0'              UNDER UNDERLINES COLUMN HEADINGS
         DC    CL24'------------------------'
         DC    CL12' '
         DC    CL24'------------------------'
         DC    CL7' '
         DC    CL12'------------'
         DC    CL12' '
         DC    CL12'------------'
         DC    CL5' '
         DC    CL12'------------'
UPDATA   DC    C'0'              UPDATA PRINTS UPDATED DATA
UPNAME   DS    CL24              ARTIST NAME
         DC    CL12' '
UPCDTTL  DS    CL24              CD TITLE
         DC    CL12' '
UPSTKN   DS    CL7               STOCK NUMBER
         DC    CL12' '
UPINSTK  DS    CL4               UPDATED COPIES IN STOCK
         DC    CL11' '
UPPRC    DS    CL8               PRICE OF CD.
ERRDATA  DC    C'0'              ERRDATA PRINTS ERROR MSG
ERRNAME  DS    CL24              ARTIST WHICH WAS NOT FOUND
         DC    CL12' '
         DC    CL40' ******   ERR:  ARTIST NOT FOUND  ******'
*
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
//FT05F001 DD DSN=T90MES1.C360(DATA8),DISP=SHR
//

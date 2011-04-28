//Z002161A JOB ,'Samir Faci',REGION=2048K,LINES=5
/*JOBPARM ROOM=161
//*
//*******************************************************************
//* step sorts the products file in ascending order and puts the 
//* output in a temp file called PRODS
//* 
//*******************************************************************
//STEP0   EXEC  PGM=SYNCSORT,PARM='CMP=CLC'
//SORTIN  DD    DSN=T90RAZ1.ASS5.PRODUCTS,DISP=SHR
//SORTOUT DD    DSN=&&PRODS,UNIT=PUB,DISP=(NEW,PASS,DELETE),
//      SPACE=(TRK,(1,1))
//SYSOUT  DD    SYSOUT=*
//SORTWK01 DD   DSN=&&SORTWK,UNIT=PUB,DISP=(NEW,DELETE),
//      SPACE=(TRK,(1,1))
//SYSIN    DD   *
  SORT   FIELDS=(1,8,CH,A)
/*
//*
//*******************************************************************
//* sorts the sales file and puts data into a temp file called 
//* sales.
//* 
//*******************************************************************
//*
//*
//STEP1   EXEC  PGM=SYNCSORT,PARM='CMP=CLC'
//SORTIN  DD    DSN=T90RAZ1.ASS5.SALES,DISP=SHR
//SORTOUT DD    DSN=&&SALES,UNIT=PUB,DISP=(NEW,PASS,DELETE),
//      SPACE=(TRK,(1,1))
//SYSOUT  DD    SYSOUT=*
//SORTWK01 DD   DSN=&&SORTWK,UNIT=PUB,DISP=(NEW,DELETE),
//      SPACE=(TRK,(1,1))
//SYSIN    DD   *
  SORT   FIELDS=(1,8,CH,A)
/*
//*******************************************************************
//* Purpose of this jobs is to execute the cobol main pgm and print
//* out reports concerning the tiddly-wins tournament
//* aka. step below calls the IGYCRCTL cobol compiler
//*******************************************************************
//STEP2   EXEC PGM=IGYCRCTL,REGION=2048K,
//      PARM='APOST,FLAG(I,I),TEST,MAP,OFFSET'
//*******************************************************************
//* STEPLIB:  INPUT:  LOCATION OF THE COBOL COMPILER.
//* SYSLIN    OUTPUT:    OBJECT MODULE TO PASS TO LOADER           
//* SYSPRINT  OUTPUT:    SOURCE LISTING AND DIAGNOSTIC MESSAGES    
//*
//*******************************************************************
//STEPLIB DD  DSN=SYS2.ADCOBOL.V110.SIGYCOMP,DISP=SHR
//SYSLIN  DD  DSN=&&MAIN,UNIT=PUB,
//        SPACE=(TRK,(3,3)),DISP=(NEW,PASS,DELETE)
//SYSPRINT DD SYSOUT=*
//*******************************************************************
//*                                                                 *
//*  THE FOLLOWING DATA SETS ARE REQUIRED BY THE COMPILER.          *
//*                                                                 *
//*******************************************************************
//SYSUT1   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT2   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT3   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT4   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT5   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT6   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT7   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSIN    DD  *
         TITLE 'SAMIR FACI CSCI 465 SECTION 1 ASSIGNMENT 5'
      *******************************************************************
      * Module Name:   Assign5                                          *
      *                                                                 *
      * Function:      This program produces a report, like everything  *
      *                other program we have ever written in cobol.     *
      *                calls an ASM subprogram to build the prodts table*
      *                after which main builds the sales table then     *
      *                calls the calcentry asm entry to calc the net    *
      *                cost.                                            *
      *                it then prints a nice little report *barf*       *
      *                                                                 *
      *                                                                 *
      * Input:        SALES and PRODUCTS.                               *
      *                                                                 *
      *                                                                 *
      * Output:        Formatted Report.                                *
      *                                                                 *
      * Notes:                                                          *
      *                                                                 *
      *******************************************************************
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  ASSIGN5.
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRINT-FILE     ASSIGN      TO PRINTER.
           SELECT PRODUCTS-FILE  ASSIGN      TO PRODUCTS.
           SELECT SALES-FILE     ASSIGN      TO SALES.


 
           EJECT

       DATA DIVISION.
 
       FILE SECTION.

      ****************************************************************
      * PRODUCTS-FILE contains data on product such as ID & 
      *                  description.
      ****************************************************************
       FD  PRODUCTS-FILE       
           RECORDING MODE IS F
           DATA RECORD IS SCORE-INFO.

       01  PRODUCTS-INFO.
           05 PR-PRODUCT-ID            PIC 9(8).
           05 PRODUCT-DESCRIPTION      PIC X(25).

              

      ****************************************************************
      * SALES-FILE  contains sales information.
      * 
      ****************************************************************
       FD  SALES-FILE
           RECORDING MODE IS F.

       01  SALES-INFO.
           05 PRODUCT-ID               PIC 9(8).
           05 PRODUCT-COST             PIC 9(4)V99.
           05 DEVELOPMENT-COST         PIC 9(4)V99.
           05 ADVERTISING-COST         PIC 9(4)V99.

      *******************************************************************
      * The PRINT-FILE holds the output.  PRINT-RECORD is written
      * from detail lines defined in WORKING-STORAGE.
      *******************************************************************

       FD  PRINT-FILE
           LABEL RECORDS ARE OMITTED
           RECORDING MODE IS F.
 
       01  PRINT-LINE                  PIC X(132).


           EJECT

       WORKING-STORAGE SECTION.

      *******************************************************************
      * VARIABLE DICTIONARY                                             *
      *                                                                 *
      * varTEM-DATE-AND-TIME   gets system dates and time.              *
      *                                                                 *
      * VAR:                                                            *
      *   EOF-FLAG             checks for end of file.                  *
      *   pg-cnt               keeps track of the page #                *
      *   LINE-CNT             keeps track of the line #                *
      *                                                                 *
      * GROUP2:                                                         *
      *   PRODUCT-COUNT        # OF RECORDS  IN PRODUCT TABLE           *
      *   SALES-COUNT          # OF RECORDS IN SALES TABLE              *
      *   NUMBER-MERGED        # OF RECORDS IN MERGED TABLE             *
      *                                                                 *
      * PRODUCTS-TBL           TABLE OF PRODUCTS                        *
      * SALES-TBL              TABLE OF SALES                           *
      * MERGED-TBL             MERGED TABLE                             *
      *                                                                 *
      *******************************************************************


       01  VARS.
           05  EOF-FLAG                PIC X            VALUE IS 'N'.
           05  PG-CNT                  PIC 9(8)     VALUE IS 1.
           05  LINE-CNT                PIC 99    VALUE IS 20. 


       01  GROUP2.
           05  PRODUCT-COUNT           PIC 99     COMP  VALUE IS 0.
           05  SALES-COUNT             PIC 99     COMP  VALUE IS 0.
           05  NUMBER-MERGED           PIC 99     COMP  VALUE IS 0.


       01  PRODS-TBL.
           05  PRODUCTS-NFO            OCCURS 60 TIMES
                                        INDEXED BY PROD-NDX.
               10  PRODUCTS-ENTRY      PIC 9(8)   COMP.
               10  PRODUCTS-NAME       PIC X(25).

       01  SALES-TBL.
           05  SALES-NFO               OCCURS 60 TIMES
                                         INDEXED BY SALES-NDX.
               10  SL-PROD-ID          PIC 9(8)  COMP.
               10  PROD-COST           PIC 9(4)V99 COMP-3.
               10  DEVLOP-COST         PIC 9(4)V99 COMP-3.
               10  ADVERT-COST         PIC 9(4)V99 COMP-3.
               10  NET-COST            PIC 9(4)V99 COMP-3.

       01  MERGED-TBL.
           05  MERGE-INFO              OCCURS 60 TIMES
                                        INDEXED BY MERGE-NDX.
               10 MRG-PROD-ID          PIC 9(8) COMP.
               10 MRG-PROD-DESC        PIC X(25).
               10 MRG-PROD-COST        PIC 9(4)V99 COMP-3.
               10 MRG-DEVL-COST        PIC 9(4)V99 COMP-3.
               10 MRG-ADV-COST         PIC 9(4)V99 COMP-3.
               10 MRG-NET-COST         PIC 9(4)V99 COMP-3.

           EJECT


      *******************************************************************
      *                                                                 *
      *                       BEGIN DETAIL LINES.                       *
      *                                                                 *
      * DETAIL-TITLE            PRINT TITLE OF REPORT.                  *
      * DETAIL-HEAD*            PRINTS THE HEADERS OF THE REPORT        *
      * DASHED-LINE             PRINTS A DASHED LINE.                   *
      * DETAIL-DATA             PRINTS THE DETAIL                       *
      *******************************************************************

       01  DETAIL-TITLE.
           05 DET-MONTH          PIC 99       VALUE IS 99.
           05                    PIC X        VALUE IS '/'.
           05 DET-DAY            PIC 99       VALUE IS 99.
           05                    PIC X        VALUE IS '/'.
           05 DET-YEAR           PIC 99       VALUE IS 99.
           05                    PIC X(45)    VALUE IS SPACES.
           05                                   PIC X(25)
                VALUE IS 'PRODUCT AND SALES DATA'.
           05                    PIC X(40)    VALUE IS SPACES.
           05                    PIC X(5)    VALUE IS 'PAGE '.
           05  DET-PGNUM         PIC ZZZZ9.

       01  DETAIL-HEAD.
           05                    PIC X(15)    VALUE IS 'PRODUCT'.
           05                    PIC X(5)     VALUE IS SPACES.
           05                    PIC X(15)    VALUE IS 'PRODUCT'.
           05                    PIC X(20)    VALUE IS SPACES.
           05                    PIC X(15)    VALUE IS 'DEVELOPMENT'.
           05                    PIC X(5)     VALUE IS SPACES.
           05                    PIC X(15)    VALUE IS 'ADVERTISING'.
           05                    PIC X(5)     VALUE IS SPACES.
           05                    PIC X(15)    VALUE IS 'NET'.
           
       01  DETAIL-HEAD2.
           05                    PIC X(15)    VALUE IS '    ID  '.
           05                    PIC X(5)     VALUE IS SPACES.
           05                    PIC X(15)    VALUE IS 'DESCRIPTION'.
           05                    PIC X(20)    VALUE IS SPACES.
           05                    PIC X(15)    VALUE IS '   COST  '.
           05                    PIC X(5)     VALUE IS SPACES.
           05                    PIC X(15)    VALUE IS '   COST  '.
           05                    PIC X(5)     VALUE IS SPACES.
           05                    PIC X(15)    VALUE IS 'COST'.


       01  DASHED-LINE          PIC X(132)  VALUE ALL '-'.
       
       01  DETAIL-DATA.
           05  DATA-ID-NUM       PIC 9(8)     VALUE IS 0.
           05                    PIC X(12)    VALUE IS SPACES.
           05  DATA-DESC         PIC X(25)    VALUE IS SPACES.
           05                    PIC X(10)    VALUE IS SPACES.
           05  DATA-PROD-COST    PIC $$,$$$.99.
           05                    PIC X(10)    VALUE IS SPACES.
           05  DATA-DEV-COST     PIC $$,$$$.99.
           05                    PIC X(10)    VALUE IS SPACES.
           05  DATA-ADV-COST     PIC $$,$$$.99.
           05                    PIC X(10)    VALUE IS SPACES.
           05  DATA-NET-COST     PIC $$,$$$.99.

       01  DETAIL-DATA2.
           05                    PIC X(30)
                        VALUE IS 'NUMBER OF MERGED RECORDS:  '.
           05  DET2-NUM          PIC ZZZ9.

           EJECT

       LINKAGE SECTION.


       01  EXEC-PARMS.
           05  PARM-LENGTH             PIC S9(4)  COMP SYNC.
           05  PARM-DAY                PIC 99.
           05  PARM-MONTH              PIC 99.
           05  PARM-YEAR               PIC 99.



       PROCEDURE DIVISION USING EXEC-PARMS.
 
      *******************************************************************
      * 000-MAIN controls the flow of the program.                      *
      * calls 2 functions to read in data from 2 files after which it   *
      * calls 3 other functions that calculate misc info and prints     *
      * detailed reports.                                               *
      *******************************************************************
 
       000-MAIN.
 

           IF PARM-LENGTH EQUAL TO ZERO
              MOVE 99 TO RETURN-CODE

           ELSE

              IF PARM-MONTH > 0 AND PARM-MONTH < 12
                 MOVE PARM-MONTH TO DET-MONTH
              END-IF

              IF PARM-DAY > 0 AND PARM-DAY < 31
                MOVE PARM-DAY TO DET-DAY
              END-IF

              IF PARM-YEAR EQUAL TO 02
                MOVE PARM-YEAR TO DET-YEAR
              END-IF


           CALL 'ASMPGM' USING PRODS-TBL GROUP2

           OPEN  INPUT  SALES-FILE
                 OUTPUT PRINT-FILE


           READ SALES-FILE
           PERFORM VARYING SALES-NDX FROM 1 BY 1
                UNTIL EOF-FLAG EQUAL 'Y'

                    ADD 1 TO SALES-COUNT

                    MOVE PRODUCT-ID TO SL-PROD-ID(SALES-NDX)
                    MOVE PRODUCT-COST TO PROD-COST(SALES-NDX)
                    MOVE DEVELOPMENT-COST TO DEVLOP-COST(SALES-NDX)
                    MOVE ADVERTISING-COST TO ADVERT-COST(SALES-NDX)

                     
                    READ SALES-FILE
                        AT END MOVE 'Y' TO EOF-FLAG
                    END-READ


           END-PERFORM

           CALL 'CALCNET' USING SALES-TBL GROUP2

           CALL 'MERGEPGM' USING GROUP2 PRODS-TBL
                                 SALES-TBL MERGED-TBL

           PERFORM VARYING MERGE-NDX FROM 1 BY 1
                   UNTIL MERGE-NDX >= NUMBER-MERGED

                   MOVE PG-CNT TO DET-PGNUM

                   IF LINE-CNT = 20
                           WRITE PRINT-LINE FROM DETAIL-TITLE
                                AFTER ADVANCING PAGE
                           WRITE PRINT-LINE FROM DETAIL-HEAD
                           WRITE PRINT-LINE FROM DETAIL-HEAD2
                           WRITE PRINT-LINE FROM DASHED-LINE
                           MOVE 0 TO LINE-CNT
                           ADD 1 TO PG-CNT
                   END-IF

                   MOVE MRG-PROD-ID(MERGE-NDX) TO DATA-ID-NUM
                   MOVE MRG-PROD-DESC(MERGE-NDX) TO DATA-DESC
                   MOVE MRG-PROD-COST(MERGE-NDX) TO DATA-PROD-COST
                   MOVE MRG-DEVL-COST(MERGE-NDX) TO DATA-DEV-COST
                   MOVE MRG-ADV-COST(MERGE-NDX) TO DATA-ADV-COST
                   MOVE MRG-NET-COST(MERGE-NDX) TO DATA-NET-COST

                   WRITE PRINT-LINE FROM DETAIL-DATA
                          AFTER ADVANCING 2 LINES

                   ADD 1 TO LINE-CNT

           END-PERFORM

           MOVE NUMBER-MERGED TO DET2-NUM
           WRITE PRINT-LINE FROM DETAIL-DATA2
                AFTER ADVANCING 2 LINES

           CLOSE  SALES-FILE
                  PRINT-FILE

           END-IF.
           STOP RUN.

           EJECT

//*******************************************************************
//STEP3   EXEC PGM=IGYCRCTL,REGION=2048K,
//      PARM='APOST,FLAG(I,I),TEST,MAP,OFFSET'
//*******************************************************************
//* STEPLIB:  INPUT:  LOCATION OF THE COBOL COMPILER.
//* SYSLIB:   INPUT:  TEMPORARY FILE WHICH STORES THE SOURCE'S 
//*                   OBJECT MODULE
//* SYSIN:    INPUT:  SOURCE CODE
//*
//* SYSLIN    OUTPUT:    OBJECT MODULE TO PASS TO LOADER           
//* SYSPRINT  OUTPUT:    SOURCE LISTING AND DIAGNOSTIC MESSAGES    
//*
//*******************************************************************
//STEPLIB DD  DSN=SYS2.ADCOBOL.V110.SIGYCOMP,DISP=SHR
//SYSLIN  DD  DSN=&&MERGE,UNIT=PUB,
//        SPACE=(TRK,(3,3)),DISP=(NEW,PASS,DELETE)
//SYSPRINT DD SYSOUT=*
//*******************************************************************
//*                                                                 *
//*  THE FOLLOWING DATA SETS ARE REQUIRED BY THE COMPILER.          *
//*                                                                 *
//*******************************************************************
//SYSUT1   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT2   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT3   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT4   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT5   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT6   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT7   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSIN    DD  *



      *******************************************************************
      * Module Name:   mergepgm                                         *
      *                                                                 *
      * Function:      This program merges the sales table and the      *
      *                products table into one nice big table for the   *
      *                use the main program.                            *
      *                                                                 *
      *                                                                 *
      * Input:        NONE.                                             *
      *                                                                 *
      *                                                                 *
      * Output:        NONE.                                            *
      *                                                                 *
      * Notes:                                                          *
      *                                                                 *
      *******************************************************************
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  MERGEPGM.
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRINT-FILE     ASSIGN      TO PRINTER.
 
           EJECT

       DATA DIVISION.


       FILE SECTION.

      *******************************************************************
      * The PRINT-FILE holds the output.  PRINT-RECORD is written
      * from detail lines defined in WORKING-STORAGE.
      *******************************************************************

       FD  PRINT-FILE
           LABEL RECORDS ARE OMITTED
           RECORDING MODE IS F.
 
       01  PRINT-LINE                  PIC X(132).


           EJECT

       WORKING-STORAGE SECTION.

      *******************************************************************
      * VARIABLE DICTIONARY                                             *
      *                                                                 *
      *                                                                 *
      * NO VARS                IN WORKING STORAGE                       *
      * PRM-GROUP ARE COUNTERS OF TABLE ENTRIES.                        *
      * SALES-TBL IS THE SALES TABLE                                    *
      * PROD-TBL IS THE PRODUCTS TABLE.                                 *
      * MERGED-TBL IS THE RESULTING MERGED TABLE.                       *
      *                                                                 *
      *******************************************************************
       LINKAGE SECTION.

       01  PRM-GROUP.
           05  PRM-PROD-CNT            PIC 99     COMP.
           05  PRM-SALE-CNT            PIC 99     COMP.
           05  PGM-MERG-CNT            PIC 99     COMP.

       01  PRODS-TBL.
           05  PRODUCTS-NFO            OCCURS 60 TIMES
                                        INDEXED BY PROD-NDX.
               10  PRODUCTS-ENTRY      PIC 9(8)   COMP.
               10  PRODUCTS-NAME       PIC X(25).

       01  SALES-TBL.
           05  SALES-NFO               OCCURS 60 TIMES
                                         INDEXED BY SALES-NDX.
               10  SL-PROD-ID          PIC 9(8)  COMP.
               10  PROD-COST           PIC 9(4)V99 COMP-3.
               10  DEVLOP-COST         PIC 9(4)V99 COMP-3.
               10  ADVERT-COST         PIC 9(4)V99 COMP-3.
               10  NET-COST            PIC 9(4)V99 COMP-3.

       01  MERGED-TBL.
           05  MERGE-INFO              OCCURS 60 TIMES
                                        INDEXED BY MERGE-NDX.
               10 MRG-PROD-ID          PIC 9(8) COMP.
               10 MRG-PROD-DESC        PIC X(25).
               10 MRG-PROD-COST        PIC 9(4)V99 COMP-3.
               10 MRG-DEVL-COST        PIC 9(4)V99 COMP-3.
               10 MRG-ADV-COST         PIC 9(4)V99 COMP-3.
               10 MRG-NET-COST         PIC 9(4)V99 COMP-3.



       PROCEDURE DIVISION USING PRM-GROUP PRODS-TBL
                          SALES-TBL MERGED-TBL.

      *******************************************************************
      * 000-MAIN controls the flow of the program.                      *
      * merges the 2 tables and sets the merged-count to the correct    *
      * value.                                                          *
      *                                                                 *
      *******************************************************************
 
       000-MAIN.
 
           SET PROD-NDX TO 1.
           SET SALES-NDX TO 1.

           PERFORM VARYING PROD-NDX FROM 1 BY 1
                   UNTIL PROD-NDX >= PRM-PROD-CNT

                SET  SALES-NDX TO PROD-NDX
                SET  MERGE-NDX TO PROD-NDX
                ADD 1 TO PGM-MERG-CNT
                MOVE PRODUCTS-ENTRY(PROD-NDX) TO
                                MRG-PROD-ID(MERGE-NDX)
                MOVE PRODUCTS-NAME(PROD-NDX) TO
                                MRG-PROD-DESC(MERGE-NDX)
                MOVE PROD-COST(SALES-NDX) TO
                                MRG-PROD-COST(MERGE-NDX)
                MOVE DEVLOP-COST(SALES-NDX) TO
                                MRG-DEVL-COST(MERGE-NDX)
                MOVE ADVERT-COST(SALES-NDX) TO
                                MRG-ADV-COST(MERGE-NDX)
                MOVE NET-COST(SALES-NDX) TO
                                MRG-NET-COST(MERGE-NDX)

           END-PERFORM.

           ADD 1 TO PGM-MERG-CNT.
           GOBACK.

           EJECT

//*******************************************************************
//*     runs the assemble compilers or assembler if u prefer.
//*
//*
//*******************************************************************
//STEP4    EXEC PGM=ASMA90,REGION=512K
//*******************************************************************
//* SYSLIB:   INPUT:  LIBRARIES USED BY THE COMPILERS        
//* SYSIN:    INPUT:  SOURCE CODE
//*
//* SYSLIN    OUTPUT:    OBJECT MODULE TO PASS TO LOADER           
//* SYSPRINT  OUTPUT:    SOURCE LISTING AND DIAGNOSTIC MESSAGES    
//*
//*******************************************************************
//SYSLIB   DD   DSN=SYS2.MACLIB,DISP=SHR
//         DD   DSN=SYS1.MACLIB,DISP=SHR
//         DD   DSN=T90CSCI.CSCI464.MACLIB,DISP=SHR
//SYSLIN   DD   DSN=&&ASMMOD,UNIT=PUB,SPACE=(TRK,(3,3)),
//       DISP=(NEW,PASS,DELETE)
//SYSPRINT DD   SYSOUT=*
//*******************************************************************
//*                                                                 *
//*  THE FOLLOWING DATA SETS ARE REQUIRED BY THE COMPILER.          *
//*                                                                 *
//*******************************************************************
//SYSUT1   DD   DSN=&&SYSUT1,UNIT=PUB,SPACE=(CYL,(1,1))
//SYSIN    DD   *

***********************************************************************
*                                                                     *
* Function:  BUILDS a sales table based on the parameters passed in.  *
*                                                                     *
* Input:     parm list passed in.                                     *
*                                                                     *
* Output:    never never land.                                        *
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
*              R2      @ OF TABLE TO BUILD                            *
*              R3      STORES EOT/ANA OF TABLE                        *
*              R4      PRODUCT-NUM                                    *
*              R5      ENTRY NUMBER                                   *
* NOTES:                                                              *
***********************************************************************
ASMPGM   CSECT
         ENTRY CALCNET
*ENTRY LINKAGE
         STM   R14,R12,12(R13)   SAVES ALL REGS.                                            
         LR    R12,R15           GETS BASE REGISTER                                                   LA    R11,4095(,R15)    ESTABLISHES LINKAGE                                        
         USING ASMPGM,R12        USING R15 & R12                                            
         LA    R14,MAINSAVE      GETS STORAGE ADDRESS                                       
         ST    R13,4(R14)        SAVES BACKWARD POINTER                                      
         ST    R14,8(R13)        SAVES FORWARD POINTER                                       
         LR    R13,R14           GET STORAGE @ IN 13
         PRINT NOGEN             DOES NOT EXPEND MACROS.
         PGMDUMP                 DOES THE FUNKY DANCE IF PGM ABENDS
         DS    0H                BUILT.
         LM    R2,R3,0(R1)       LOADS ADDRESS OF TABLE WHICH SHALL BE
         LR    R10,R1            BACKUP PARM LIST INTO R10.
         LH    R4,0(R3)          LOADS PRODUCT-NUM INTO R4
         OPEN  (INPROD,(INPUT))   OPENS NAME FILE
         GET   INPROD                 READ NEXT RECORD
         DO WHILE,(CLI,EOFFLAG,NE,C'Y') WHILE !EOF DO LOOP
            MVC   DBL(8),=D'0'           REINITIALIZES DOUBLE WORD.
            A     R4,=F'1'               ADDS ONE TO COUNTER.
            PACK  DBL(8),0(8,R1)         PACKS ENTRY INTO TEMP VAR.
            CVB   R5,DBL                 CONVERTS PACKED # TO DECIMAL
            ST    R5,0(R2)               STORES PRODUCT-ID IN TABLE
            MVC   4(25,R2),8(R1)         STORES PRODUCT-DESC IN TBL.
            LA    R2,29(R2)              LOADS NEXT ADDRESS INTO R2
            GET   INPROD                 READ NEXT RECORD
         ENDDO                           END LOOP
         CLOSE INPROD                     CLOSE NAME FILE
         STH   R4,0(R3)

*EXIT LINKAGE
         L     R13,4(R13)        GETS BACKWARD POINTER
         LM    R14,R12,12(R13)   RESTORES REGISTERS...
         BR    R14               RETURNS TO CALLER                                          
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
*               END ASMPGM  ...   BEGIN CALCNET                *

***********************************************************************                     
*                                                                                           
*                          STORAGE AREA                                                     
*                                                                                           
***********************************************************************                     
MAINSAVE DS    18F                      SAVES REGS
EOFFLAG  DC    C'N'             USED TO SIGNAL END OF FILE.
DBL      DC    D'0'             DOUBLE WORD USED BY CVB/CVD

EOFRTN   DS    0H
         MVI   EOFFLAG,C'Y'
         BR    R14


INPROD   DCB   DDNAME=PRODUCTS,                                        X
               DEVD=DA,                                                X
               DSORG=PS,                                               X
               MACRF=GL,                                               X
               RECFM=FB,                                               X
               LRECL=33,                                               X
               BLKSIZE=3300,                                           X
               EODAD=EOFRTN


***********************************************************************
*       NAME:           CALCNET                                       *
*       FUNCTION:       CALCULATES THE NET COST                       *
*       INPUT:          PARMS PASSED IN FROM MAIN.                    *
*       OUTPUT:         NONE                                          *
*       ENTRY CONDS:    NONE                                          *
*       REGISTER USE:   R1 - PARM LIST                                *
*                       R4 - SALES COUNT                              *
*                       R5 -  COUNTER AS WE TRAVERSE TABLE.           *
*                       R6 -  ADVERTISING COST                        *
*                       R7 -  DEVELOPMENT COST                        *
*                       R8 -  PRODUCTION COST                         *

*       PSEUDOCODE:     DO WHILE NOT EOF                              *
*                        CALC THE NET COST                            *
*                       ON EOF, EXIT LOOP AND RETURN TO MAIN.         *
*       NOTES:          NONE                                          *
***********************************************************************
CALCNET     DS     0H
*ENTRY LINKAGE
         STM   R14,R12,12(R13)   SAVES ALL REGS.
         LR    R12,R15           GETS BASE REGISTER                                                   LA    R11,4095(,R15)    ESTABLISHES LINKAGE                                        
         USING CALCNET,R12       USING R15 & R12                                            
         LA    R14,CALCSAVE      GETS STORAGE ADDRESS                                       
         ST    R13,4(R14)        SAVES BACKWARD POINTER                                      
         ST    R14,8(R13)        SAVES FORWARD POINTER                                       
         LR    R13,R14           GET STORAGE @ IN 13
*BEGIN CODE
         LM    R2,R3,0(R1)       LOADS PARM LIST.
         LH    R4,2(R3)          LOADS SALES COUNT TO R4
         L     R5,=F'0'          USED AS A PROCESS COUNT.
         
         DO WHILE,(CR,R5,NE,R4) WHILE REGS. NOT EQUAL

                 L     R7,8(R2)
                 MVC   NETDBL+4(4),8(R2) MOVES PACKED # INTO DBL
                 CVB   R7,NETDBL         LOADS DEVELPMENT COST IN R7
                 MVC   NETDBL(8),=D'0'   RESETS NETCVB TO 0
                 MVC   NETDBL+4(4),4(R2) MOVES PACKED # INTO DBL
                 CVB   R8,NETDBL         LOADS PROD-COST INTO R8
                 MVC   NETDBL(8),=D'0'   RESETS NETCVB TO 0
                 MVC   NETDBL+4(4),12(R2) MOVES PACKED # INTO DBL
                 CVB   R6,NETDBL         LOADS ADV-COST INTO R6
                 AR    R7,R6             ADDS ADV-COST TO R7
                 SR    R8,R7             SR PROD-COST - (DEV-COST
*                                            + ADVCST)
                 MVC   NETDBL,=D'0'      RESETS NETCVB TO 0
                 CVD   R8,NETDBL
                 MVC   16(4,R2),NETDBL+4  STORES VALUE IN NET-COST.
                 LA    R2,20(R2)         LOADS NEXT TABLE ENTRY
                 A     R5,=F'1'          INCREMENTS COUNTER BY 1

         ENDDO

*END CODE
*EXIT LINKAGE
         L     R13,4(R13)        GETS BACKWARD POINTER
         LM    R14,R12,12(R13)   RESTORES REGISTERS...
         BR    R14               RETURNS TO CALLER
         DROP  R12
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT

***********************************************************************                     
*                                                                                           
*                          STORAGE AREA                                                     
*                                                                                           
***********************************************************************                     
CALCSAVE DS    18F                      SAVES REGS
NETDBL   DC    D'0'             DOUBLE USED W/ CVB/CVD

 
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
         END   ASMPGM
/*
//****************************************************************
//* step5 executes the object modules, and runs the program.      
//*                                                               
//*                                                               
//****************************************************************
//STEP5   EXEC PGM=HEWL,REGION=1024K,
//        COND=(0,GT),PARM='MAP,LIST,AMODE(24)'
//****************************************************************
//* SYSLIN   INPUT:  object modules to be linked and run
//* SYSLIB   INPUT:  library files needed by loader.
//* SYSLMOD  OUTPUT: a temporary pds
//****************************************************************
//SYSLIN  DD  DSN=&&MAIN,DISP=(OLD,DELETE,DELETE)
//        DD  DSN=&&ASMMOD,DISP=(OLD,DELETE,DELETE)
//        DD  DSN=&&MERGE,DISP=(OLD,DELETE,DELETE)
//*
//SYSLIB  DD  DSN=SYS2.LE370.V111.SCEELKED,DISP=SHR
//SYSLMOD DD  DSN=&&MYPDS(MEM1),DISP=(NEW,PASS,DELETE),
//      UNIT=PUB,SPACE=(1024,(50,20,1))
//SYSPRINT DD SYSOUT=*
//SYSUT1   DD UNIT=PUB,SPACE=(TRK,(10,10))
//*******************************************************************
//*                                                                 *
//*  THE FOLLOWING DATA SETS ARE REQUIRED BY THE XSNAP AND PGMDUMP  *
//*  MACROS.                                                        *
//*                                                                 *
//*  XSNAPOUT  OUTPUT:   OUTPUT FROM XSNAP MACRO                    *
//*  SYS$DUMP  OUTPUT:   MESSAGES FROM PGMDUMP                      *
//*  SPX$DUMP  OUTPUT:   PROGRAM DUMP                               *
//*                                                                 *         
//*******************************************************************
//SYS$DUMP DD    SYSOUT=*
//SPX$DUMP DD    SYSOUT=*
//XSNAPOUT DD    SYSOUT=*
//****************************************************************
//*   runs the program using the fetch step.
//*   with no parameters passed in.
//*
//****************************************************************
//STEP6 EXEC PGM=MEM1,REGION=1024K
//STEPLIB   DD DSN=&&MYPDS,DISP=(OLD,PASS)
//          DD DSN=SYS2.LE370.V111.SCEERUN,DISP=SHR
//****************************************************************
//*                                                              *
//*  THE FOLLOWING DATA SETS ARE REQUIRED BY THE COBOL PROGRAM.  *
//*                                                              *
//*  NAME       INPUT:     NAME OF TEAMS AND SCHOOLS             *
//*  SCORE      INPUT:     SCORES RECORD AND OBTAINED IN TOURN.  *
//*                                                              *
//*  PRINTER    OUTPUT:    USED IN PROGRAM TO WRITE REPORT.      *
//*                                                              *
//****************************************************************
//PRODUCTS  DD    DSN=&&PRODS,UNIT=PUB,DISP=(OLD,PASS,DELETE),
//      SPACE=(TRK,(1,1))
//SALES    DD  DSN=&&SALES,UNIT=PUB,DISP=(OLD,PASS,DELETE),
//      SPACE=(TRK,(1,1))
//PRINTER  DD  SYSOUT=*
//****************************************************************
//*   runs the program using the fetch step.
//*   with date parameters         
//*
//****************************************************************
//STEP7 EXEC PGM=MEM1,REGION=1024K,PARM='200302'
//STEPLIB   DD DSN=&&MYPDS,DISP=(OLD,DELETE)
//          DD DSN=SYS2.LE370.V111.SCEERUN,DISP=SHR
//****************************************************************
//*                                                              *
//*  THE FOLLOWING DATA SETS ARE REQUIRED BY THE COBOL PROGRAM.  *
//*                                                              *
//*  NAME       INPUT:     NAME OF TEAMS AND SCHOOLS             *
//*  SCORE      INPUT:     SCORES RECORD AND OBTAINED IN TOURN.  *
//*                                                              *
//*  PRINTER    OUTPUT:    USED IN PROGRAM TO WRITE REPORT.      *
//*                                                              *
//****************************************************************
//PRODUCTS  DD    DSN=&&PRODS,UNIT=PUB,DISP=(OLD,DELETE,DELETE),
//      SPACE=(TRK,(1,1))
//SALES    DD  DSN=&&SALES,UNIT=PUB,DISP=(OLD,DELETE,DELETE),
//      SPACE=(TRK,(1,1))
//PRINTER  DD  SYSOUT=*
//


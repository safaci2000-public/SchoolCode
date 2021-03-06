//Z002161A JOB ,'Samir Faci',REGION=2048K,LINES=5
/*JOBPARM ROOM=161
//*
//*******************************************************************
//* Purpose of this jobs is to execute the cobol main pgm and print
//* out reports concerning the tiddly-wins tournament
//* aka. step below calls the IGYCRCTL cobol compiler
//*******************************************************************
//STEP1   EXEC PGM=IGYCRCTL,REGION=2048K,
//      PARM='LIB,APOST,FLAG(W,W),TEST,MAP,OFFSET'
//*******************************************************************
//* STEPLIB:  INPUT:  LOCATION OF THE COBOL COMPILER.
//* SYSLIN    OUTPUT:    OBJECT MODULE TO PASS TO LOADER           
//* SYSPRINT  OUTPUT:    SOURCE LISTING AND DIAGNOSTIC MESSAGES    
//*
//*******************************************************************
//STEPLIB DD  DSN=SYS2.ADCOBOL.V110.SIGYCOMP,DISP=SHR
//SYSLIN  DD  DSN=&&MAIN,UNIT=PUB,
//        SPACE=(TRK,(3,3)),DISP=(NEW,PASS,DELETE)
//SYSLIB  DD  DSN=T90RAZ1.C465S02.COPYLIB,DISP=SHR
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
         TITLE 'SAMIR FACI CSCI 465 SECTION 1 ASSIGNMENT 6'
      *******************************************************************
      * Module Name:   Assign6                                          *
      *                                                                 *
      * Function:      This program produces a report, like everything  *
      *                else we ever wrote in this god forsaken class.   *
      *                calls sort to sort the two files followed by     *
      *                merge to merge 'em.                              *
      *                                                                 *
      * Input:         BOOK1-FILE BOOK2-FILE                            *
      *                                                                 *
      *                                                                 *
      * Output:        wild guess... a formatted pukey report.          *
      *                                                                 *
      * Notes:                                                          *
      *                                                                 *
      *******************************************************************

       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  ASSIGN6.
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRINT-FILE     ASSIGN      TO PRINTER.
           SELECT BOOK1-FILE     ASSIGN      TO BOOK1.
           SELECT BOOK2-FILE     ASSIGN      TO BOOK2.
           SELECT SORTWORK1      ASSIGN      TO WKFILE.
           SELECT SORTWORK2      ASSIGN      TO WKFILE2.
           SELECT SORTED-BOOK1   ASSIGN      TO SORT1.
           SELECT SORTED-BOOK2   ASSIGN      TO SORT2.
           SELECT MERGED-FILE    ASSIGN      TO MERGE1.
           SELECT MERGED-WORK    ASSIGN      TO WKFILE3.


 
           EJECT

       DATA DIVISION.

       FILE SECTION.

      ****************************************************************
      * BOOK1-FILE.    contains data on books. such as author, isbn
      *                title,etc.
      ****************************************************************
       COPY FDFILE1.


      ****************************************************************
      * BOOK2-FILE.    contains data on books. such as author, isbn
      *                title,etc.
      ****************************************************************

       COPY FDFILE2.


      *******************************************************************
      * The PRINT-FILE holds the output.  PRINT-RECORD is written
      * from detail lines defined in WORKING-STORAGE.
      *******************************************************************

       FD  PRINT-FILE
           LABEL RECORDS ARE OMITTED
           RECORDING MODE IS F.
 
       01  PRINT-LINE                  PIC X(132).

      *******************************************************************
      * SORTWORK1 temporary files used to sort bookfile 1
      * 
      *******************************************************************
       SD  SORTWORK1.


       01  SD-BOOK-REC.
           02  SD-BOOK1-DATA.
               03  SD-B1-ISBN                   PIC X(8).
               03  SD-B1-AUTHOR                 PIC X(25).
               03  SD-B1-TITLE                  PIC X(40).
               03  SD-B1-CODE                   PIC X(6).
               03  SD-B1-QUANTITY               PIC 9(3).
               03  SD-B1-PGNUM                  PIC 9(3).


      *******************************************************************
      * temporary work files used to sort the second book file.
      * 
      *******************************************************************
       SD  SORTWORK2.

       01  SD-BOOK2-REC.
           02  SD-B2-ISBN                       PIC X(8).
           02  SD-B2-AUTHOR                     PIC X(25).
           02  SD-B2-TITLE                      PIC X(40).
           02  SD-B2-CODE                       PIC X(6).
           02  SD-B2-QUANTITY                   PIC 9(3).
           02  SD-B2-PGNUM                      PIC 9(3).


      *******************************************************************
      * temp files used to merge the two sorted files.
      * 
      *******************************************************************
       SD  MERGED-WORK.

       01  SD-MRG-RECORD.
           02  SD-MRG-ISBN                       PIC X(8).
           02  SD-MRG-AUTHOR                     PIC X(25).
           02  SD-MRG-TITLE                      PIC X(40).
           02  SD-MRG-CODE                       PIC X(6).
           02  SD-MRG-QUANTITY                   PIC 9(3).
           02  SD-MRG-PGNUM                      PIC 9(3).

      *******************************************************************
      * output of 1st sort routine.
      * 
      *******************************************************************
       FD  SORTED-BOOK1.

       01  SORTED1-RECORD.
           05  SR1-ISBN                           PIC X(8).
           05  SR1-AUTHOR                         PIC X(25).
           05  SR1-TITLE                          PIC X(40).
           05  SR1-CODE                           PIC X(6).
           05  SR1-QUANTITY                       PIC 9(3).
           05  SR1-PGNUM                          PIC 9(3).

      *******************************************************************
      * output of 2nd sort call.
      * 
      *******************************************************************


       FD  SORTED-BOOK2.

       01  SORTED2-RECORD.
           05  SR2-ISBN                           PIC X(8).
           05  SR2-AUTHOR                         PIC X(25).
           05  SR2-TITLE                          PIC X(40).
           05  SR2-CODE                           PIC X(6).
           05  SR2-QUANTITY                       PIC 9(3).
           05  SR2-PGNUM                          PIC 9(3).

      *******************************************************************
      * output of merge call.
      * 
      *******************************************************************

       FD  MERGED-FILE.

       01  MERGED-RECORD.
           05  MRG-ISBN                           PIC X(8).
           05  MRG-AUTHOR                         PIC X(25).
           05  MRG-TITLE                          PIC X(40).
           05  MRG-CODE                           PIC X(6).
           05  MRG-QUANTITY                       PIC 9(3).
           05  MRG-PGNUM                          PIC 9(3).


           EJECT

       WORKING-STORAGE SECTION.

      *******************************************************************
      * VARS:                                                           *
      *   EOF-FLAG              VAR USED TO TRACK END OF FILE STATUS    *
      *   SYS-DATE              CAPTURES SYSTEM DATE FROM MVS SYSTEM.   *
      *   PAGE-NUM              COUNTS # OF PAGES.                      *
      *   LINE-COUNT            COUNTS # OF LINES PRINTED SO FAR.       *
      * NUM-PAGES               USED BY EXTERNAL PROGRAM.               *
      * WS-MRG-RECORD           WS TEMP USED BY MERGE OUTPUT ROUTINE.   *
      *                                                                 *
      * TITLE1                  PRINTS TITLE OF REPORT.                 *
      * HEADER1                 PRINTS A HEADER TO THE REPORT.          *
      * DASHED-LINE             UNDER LINES EVERYTHING.                 *
      * DETAIL-LINE1            PRINTS INFO FROM THE 3000 CALLS TO SORT *
      *                         MERGE AND THE EXT. PGM.                 *
      *                                                                 *
      *******************************************************************
       01  VARS.
           05  EOF-FLAG                         PIC X VALUE IS 'N'.
           05  SYS-DATE                         PIC X(6).
           05  PAGE-NUMBER                      PIC 99 VALUE IS 1.
           05  LINE-COUNT                       PIC 99 VALUE IS 21.
           05  PROG-NAME                        PIC X(10).


       01  NUM-PAGES                            PIC 999 VALUE IS 0.

       01  WS-MRG-RECORD.
           02  WS-MRG-ISBN                       PIC X(8).
           02  WS-MRG-AUTHOR                     PIC X(25).
           02  WS-MRG-TITLE                      PIC X(40).
           02  WS-MRG-CODE                       PIC X(6).
           02  WS-MRG-QUANTITY                   PIC 9(3).
           02  WD-MRG-PGNUM                      PIC 9(3).


       01  TITLE1.
           05 TT-MONTH                          PIC 99   VALUE IS 0.
           05                                   PIC X VALUE IS '/'.
           05 TT-DAY                            PIC 99   VALUE IS 0.
           05                                   PIC X VALUE IS '/'.
           05 TT-YEAR                           PIC 99 VALUE IS 0.
           05                            PIC X(47) VALUE IS SPACES.
           05           PIC X(20) VALUE IS 'MERGED BOOK FILE'.
           05                            PIC X(45) VALUE IS SPACES.
           05                              PIC X(5) VALUE IS 'PAGE '.
           05 TT-PAGE                           PIC Z9.
                
       01  HEADER1.
           05 HD-ISBN                   PIC X(10) VALUE IS '  ISBN'.
           05                           PIC X(5) VALUE IS SPACES.
           05 HD-AUTHOR                 PIC X(25) VALUE IS 'AUTHOR'.
           05                           PIC X(5) VALUE IS SPACES.
           05 HD-TITLE                  PIC X(40) VALUE IS 'TITLE'.
           05                           PIC X(5) VALUE IS SPACES.
           05 HD-CODE                   PIC X(10) VALUE IS 'CODE'.
           05                           PIC X(5) VALUE IS SPACES.
           05 HD-QUANTIY                PIC X(10) VALUE IS 'QUANTITY'.
           05                           PIC X(5) VALUE IS SPACES.
           05 HD-PGNUM                  PIC X(10) VALUE IS 'PAGES'.
                                              
       01  DASHED-LINE          PIC X(132)  VALUE ALL '-'.

       01  DETAIL-LINE1.
           05 DT-ISBN                    PIC X(8)  VALUE IS SPACES.
           05                            PIC X(7)  VALUE IS SPACES.
           05 DT-AUTHOR                  PIC X(25) VALUE IS SPACES.
           05                            PIC X(5)  VALUE IS SPACES.
           05 DT-TITLE                   PIC X(40) VALUE IS SPACES.
           05                            PIC X(5)  VALUE IS SPACES.
           05 DT-CODE                    PIC X(6)  VALUE IS SPACES.
           05                            PIC X(9)  VALUE IS SPACES.
           05 DT-QUANTITY                PIC ZZ9.
           05                            PIC X(12) VALUE IS SPACES.
           05 DT-PAGENUM                 PIC Z99.

       PROCEDURE DIVISION.
 
      *******************************************************************
      * 000-MAIN controls the flow of the program.                      *
      * calls 2 SORTS to sort the data in the file                      *
      * calls 1 merge to merge the data after which a subroutine prints *
      * all the junk                                                    *
      *******************************************************************
       000-MAIN.
 
           SORT SORTWORK1
              ON ASCENDING KEY SD-B1-ISBN IN SORTWORK1
              INPUT PROCEDURE IS 100-SORT1-IN
              OUTPUT PROCEDURE 150-SORT1-OUT.


           IF SORT-RETURN NOT EQUAL TO ZEROES
              DISPLAY 'ERROR: UNSUCCESSFUL SORT  #1'
           END-IF. 

           MOVE 'N' TO EOF-FLAG.
           
           CANCEL 'SUBPGM'.

           SORT SORTWORK2
              ASCENDING KEY SD-B2-ISBN IN SORTWORK2
              WITH DUPLICATES IN ORDER
              INPUT PROCEDURE 200-SORT2-IN
              OUTPUT PROCEDURE 250-SORT2-OUT.


           IF SORT-RETURN NOT EQUAL TO ZEROES
              DISPLAY 'ERROR: UNSUCCESSFUL SORT  #2'
           END-IF. 

           MOVE 'N' TO EOF-FLAG.

           MERGE MERGED-WORK
                 ON ASCENDING KEY SD-MRG-ISBN
                 USING SORTED-BOOK1 SORTED-BOOK2
                 OUTPUT PROCEDURE IS 300-MERGE-OUT.


           IF SORT-RETURN NOT EQUAL TO ZEROES
              DISPLAY 'ERROR: UNSUCCESSFUL MERGE'
           END-IF.


           ACCEPT SYS-DATE FROM DATE.

           MOVE SYS-DATE(1:2) TO TT-MONTH.
           MOVE SYS-DATE(3:2) TO TT-DAY.
           MOVE SYS-DATE(5:2) TO TT-YEAR.


           OPEN INPUT MERGED-FILE
                OUTPUT PRINT-FILE.

           MOVE 'N' TO EOF-FLAG.

           PERFORM 400-PRINT-REPORT.

           CLOSE MERGED-FILE
                 PRINT-FILE.

           STOP RUN.

           EJECT

      *******************************************************************
      * 100-SORT-IN sort subroutine which sorts any records that have
      *    a quantity greater or equal to 10.
      *******************************************************************
       100-SORT1-IN.

           OPEN INPUT BOOK1-FILE.

           READ BOOK1-FILE
                AT END MOVE 'Y' TO EOF-FLAG.

           PERFORM UNTIL EOF-FLAG = 'Y'
              IF B1-QUANTITY >= 10
                 RELEASE SD-BOOK-REC FROM BOOK1-DATA
              END-IF
              READ BOOK1-FILE
                   AT END MOVE 'Y' TO EOF-FLAG
              END-READ
           END-PERFORM.

           MOVE 'N' TO EOF-FLAG.
           CLOSE BOOK1-FILE.

           EJECT

      *******************************************************************
      * 150-SORT1-OUT calls external program to increment page # and 
      *    write output to sorted file.
      *******************************************************************
       150-SORT1-OUT.


           OPEN OUTPUT SORTED-BOOK1.

           MOVE 0 TO NUM-PAGES.
           MOVE 'SUBPGM' TO PROG-NAME.

           RETURN SORTWORK1
                AT END MOVE 'Y' TO EOF-FLAG.

           
           PERFORM UNTIL EOF-FLAG = 'Y'
           
               CALL PROG-NAME USING NUM-PAGES
               MOVE NUM-PAGES TO SD-B1-PGNUM

               WRITE SORTED1-RECORD FROM SD-BOOK-REC
           
               RETURN SORTWORK1
                    AT END MOVE 'Y' TO EOF-FLAG
               END-RETURN
           
           END-PERFORM.
                      

           CLOSE SORTED-BOOK1.


           EJECT


      *******************************************************************
      * 200-SORT2-IN used as an input procedure for the second sort
      *    gets rid of the 10 bytes of slack data and releases the 
      *    record.
      *******************************************************************
       200-SORT2-IN.

           OPEN INPUT BOOK2-FILE.

           READ BOOK2-FILE
                AT END MOVE 'Y' TO EOF-FLAG.

           PERFORM UNTIL EOF-FLAG = 'Y'
              
              MOVE B2-ISBN TO SD-B2-ISBN
              MOVE B2-AUTHOR TO SD-B2-AUTHOR
              MOVE B2-TITLE TO SD-B2-TITLE
              MOVE B2-CODE TO SD-B2-CODE
              MOVE B2-QUANTITY TO SD-B2-QUANTITY

              RELEASE SD-BOOK2-REC

              READ BOOK2-FILE
                   AT END MOVE 'Y' TO EOF-FLAG
              END-READ
           END-PERFORM.

           MOVE 'N' TO EOF-FLAG.
           CLOSE BOOK2-FILE.

           EJECT


      *******************************************************************
      * 250-SORT2-OUT calls external routine and writes data to sorted 
      *    file.
      *******************************************************************
       250-SORT2-OUT.


           OPEN OUTPUT SORTED-BOOK2.

           MOVE 0 TO NUM-PAGES.
           MOVE 'SUBPGM' TO PROG-NAME.

           RETURN SORTWORK2
                AT END MOVE 'Y' TO EOF-FLAG.

           
           PERFORM UNTIL EOF-FLAG = 'Y'
           
              CALL PROG-NAME USING NUM-PAGES
               MOVE NUM-PAGES TO SD-B2-PGNUM

               WRITE SORTED2-RECORD FROM SD-BOOK2-REC
           
               RETURN SORTWORK2
                    AT END MOVE 'Y' TO EOF-FLAG
               END-RETURN
           
           END-PERFORM.

           CLOSE SORTED-BOOK2.
                      

           EJECT


      *******************************************************************
      * 300-MERGE-OUT writes output to the merged file and removes 
      *    duplicates.
      *******************************************************************
       300-MERGE-OUT.


           OPEN OUTPUT MERGED-FILE.

           RETURN MERGED-WORK INTO WS-MRG-RECORD
                AT END MOVE 'Y' TO EOF-FLAG.

           PERFORM UNTIL EOF-FLAG EQUAL TO 'Y'

             RETURN MERGED-WORK
                AT END MOVE 'Y' TO EOF-FLAG
             END-RETURN

             IF WS-MRG-ISBN IS EQUAL TO SD-MRG-ISBN
                MOVE SD-MRG-RECORD TO WS-MRG-RECORD

             ELSE
                WRITE MERGED-RECORD FROM WS-MRG-RECORD
                MOVE SD-MRG-RECORD TO WS-MRG-RECORD

             END-IF

           END-PERFORM.
           
           WRITE MERGED-RECORD FROM WS-MRG-RECORD.

           CLOSE MERGED-FILE.


           EJECT

      *******************************************************************
      * 400-PRINT-REPORT prints the report in a nice user-friendly 
      *    format.
      *******************************************************************
       400-PRINT-REPORT.

           READ MERGED-FILE
                AT END MOVE 'Y' TO EOF-FLAG
           END-READ.

           PERFORM UNTIL EOF-FLAG = 'Y'

              IF LINE-COUNT > 20

                MOVE PAGE-NUMBER TO TT-PAGE
                WRITE PRINT-LINE FROM TITLE1
                      AFTER ADVANCING PAGE
                WRITE PRINT-LINE FROM HEADER1
                      AFTER ADVANCING 3 LINES
                WRITE PRINT-LINE FROM DASHED-LINE
                    AFTER ADVANCING 2 LINES

                MOVE 1 TO LINE-COUNT
                ADD 1 TO PAGE-NUMBER
 
              END-IF


              MOVE MRG-ISBN TO DT-ISBN
              MOVE MRG-AUTHOR TO DT-AUTHOR
              MOVE MRG-TITLE TO DT-TITLE
              MOVE MRG-CODE TO DT-CODE
              MOVE MRG-QUANTITY TO DT-QUANTITY
              MOVE MRG-PGNUM TO DT-PAGENUM

              WRITE PRINT-LINE FROM DETAIL-LINE1
                    AFTER ADVANCING 2 LINES
              ADD 1 TO LINE-COUNT


              READ MERGED-FILE
                 AT END MOVE 'Y' TO EOF-FLAG
              END-READ

           END-PERFORM.

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
//SYSLIN  DD  DSN=&&SUBPGM,UNIT=PUB,
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
      * Module Name:   EXT                                              *
      *                                                                 *
      * Function:     to be an absolutely pointless waste of paper      *
      *               and space.  actually it increments the page count *
      *               by 20.                                            *
      *                                                                 *
      * Input:        NONE.                                             *
      *                                                                 *
      *                                                                 *
      * Output:        NONE.                                            *
      *                                                                 *
      * Notes:        POINTLESSSSSS                                     *
      *                                                                 *
      *******************************************************************
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  SUBPGM.
 
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
      * PAGE-COUNT         KEEPS TRACK OF # OF PAGES (INCREMENTED)      *
      *                                                                 *
      *******************************************************************
       LINKAGE SECTION.


       01  PAGE-COUNT                  PIC 999.

       PROCEDURE DIVISION USING PAGE-COUNT.


      *******************************************************************
      * 000-MAIN controls the flow of the program.                      *
      * merges the 2 tables and sets the merged-count to the correct    *
      * value.                                                          *
      *                                                                 *
      *******************************************************************
 
       000-MAIN.
 
           ADD 20 TO PAGE-COUNT.


           GOBACK.

           EJECT



//****************************************************************
//* step4 creates the load module.
//*                                                               
//*                                                               
//****************************************************************
//STEP4   EXEC PGM=HEWL,REGION=1024K,
//        COND=(0,GT),PARM='MAP,LIST,AMODE(24)'
//****************************************************************
//* SYSLIN   INPUT:  object modules to be linked and run
//* SYSLIB   INPUT:  library files needed by loader.
//* SYSLMOD  OUTPUT: a temporary pds
//****************************************************************
//SYSLIN  DD  DSN=&&MAIN,DISP=(OLD,DELETE,DELETE)
//*
//SYSLIB  DD  DSN=SYS2.LE370.V111.SCEELKED,DISP=SHR
//SYSLMOD DD  DSN=Z002161.MYPDS(MEM1),DISP=(NEW,PASS,DELETE),
//      UNIT=DISK,VOL=SER=ACA301,SPACE=(1024,(50,20,1))
//SYSPRINT DD SYSOUT=*
//SYSUT1   DD UNIT=PUB,SPACE=(TRK,(10,10))
//****************************************************************
//* step5 creates load module for subprogram.
//****************************************************************
//STEP5   EXEC PGM=HEWL,REGION=1024K,
//        COND=(0,GT),PARM='MAP,LIST,AMODE(24)'
//****************************************************************
//* SYSLIN   INPUT:  object modules to be linked and run
//* SYSLIB   INPUT:  library files needed by loader.
//* SYSLMOD  OUTPUT: a temporary pds
//****************************************************************
//SYSLIN  DD  DSN=&&SUBPGM,DISP=(OLD,DELETE,DELETE)
//*
//SYSLIB  DD  DSN=SYS2.LE370.V111.SCEELKED,DISP=SHR
//SYSLMOD DD  DSN=Z002161.MYPDS(SUBPGM),DISP=(MOD,PASS,DELETE),
//      UNIT=DISK,VOL=SER=ACA301,SPACE=(1024,(50,20,1))
//SYSPRINT DD SYSOUT=*
//SYSUT1   DD UNIT=PUB,SPACE=(TRK,(10,10))
//****************************************************************
//*   runs the program using the fetch step.
//*   with no parameters passed in.
//*
//****************************************************************
//STEP6 EXEC PGM=MEM1,REGION=1024K
//STEPLIB   DD DSN=Z002161.MYPDS(MEM1),DISP=(OLD,DELETE,DELETE)
//          DD DSN=Z002161.MYPDS(SUBPGM),DISP=(OLD,DELETE,DELETE)
//          DD DSN=SYS2.LE370.V111.SCEERUN,DISP=SHR
//****************************************************************
//*                                                              *
//*  THE FOLLOWING DATA SETS ARE REQUIRED BY THE COBOL PROGRAM.  *
//*                                                              *
//*  BOOK1      INPUT:     1ST RECORD OF BOOKS INFO              *
//*  BOOK2      INPUT:     2ND RECORD OF BOOKS INFO              *
//*  WKFILE     TEMP:      USED IN SORTING                       *
//*  WKFILE2    TEMP:      USED IN THE 2ND SORT                  *
//*  WKFILE3    TEMP:      USED IN MERGE OF RECORD               *
//*  MERGE      IN/OUT:    PRODUCT OF MERGE                      *
//*                                                              *
//*  PRINTER    OUTPUT:    USED IN PROGRAM TO WRITE REPORT.      *
//*                                                              *
//****************************************************************
//BOOK1    DD  DSN=T90RAZ1.C465S02.A6BOOKS1,DISP=SHR
//BOOK2    DD  DSN=T90RAZ1.C465S02.A6BOOKS2,DISP=SHR
//PRINTER  DD  SYSOUT=*
//WKFILE   DD  DSN=&&WKFILE,DISP=NEW,UNIT=PUB
//WKFILE2  DD  DSN=&&WKFILE2,DISP=NEW,UNIT=PUB
//SORT1    DD  DSN=&&SORT1,DISP=NEW,UNIT=PUB
//SORT2    DD  DSN=&&SORT2,DISP=NEW,UNIT=PUB
//MERGE1   DD  DSN=&&MERGE,DISP=NEW,UNIT=PUB
//WKFILE3  DD  DSN=&&WKFILE3,DISP=NEW,UNIT=PUB
//

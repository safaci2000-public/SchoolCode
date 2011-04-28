//Z002161A JOB ,'Samir Faci',REGION=2048K,LINES=5
/*JOBPARM ROOM=161
//*******************************************************************
//*        CATALOGED LIBRARY FOR THE COMPILE AND LINKED PROCEDURES  *
//*******************************************************************
//STEP0  JCLLIB  ORDER=(Z002161.CS465.LIB2)
//*******************************************************************
//*        DELETES THE PRECEDING VSAM CLUSTERS WHICH WERE CREATED   *
//*******************************************************************
//STEP1 EXEC PGM=IDCAMS,COND=EVEN
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
   DELETE -
   Z002161.C465S02.VSAM.KSDS
   DELETE -
   Z002161.C465S02.VSAM.ESDS
/*
//*******************************************************************
//*        SORTS THE INPUT DATA AND PUTS OUTPUT IN A TEMP FILE      *
//*******************************************************************
//STEP2   EXEC  PGM=SYNCSORT,PARM='CMP=CLC',COND=EVEN
//SORTIN  DD    DSN=T90RAZ1.C465S02.A9DATA,DISP=SHR,
//    UNIT=DISK,VOL=SER=ACA301
//SORTOUT DD    DSN=&&SORTED,UNIT=PUB,DISP=(NEW,PASS,DELETE),
//      SPACE=(TRK,(1,1))
//SORTOUT DD    SYSOUT=*
//SYSOUT   DD    SYSOUT=*
//SORTWK01 DD   DSN=&&SORTWK,UNIT=PUB,DISP=(NEW,DELETE),
//      SPACE=(TRK,(1,1))
//SYSIN    DD   *
  SORT   FIELDS=(1,9,ZD,A)
/*
//*******************************************************************
//* THIS STEP DEFINES A KSDS CLUSTER FOR THE MASTER FILE.
//*
//*******************************************************************
//STEP3 EXEC PGM=IDCAMS,COND=(0,NE,STEP2)
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
   DEFINE CLUSTER(-
   NAME(Z002161.C465S02.VSAM.KSDS)-
   INDEXED-
   VOLUMES(ACA301)-
   TRACKS(1 1)-
   KEYS(9  0) )
/*
//*******************************************************************
//* LOADS DATA INTO KSDS CLUSTER.
//*******************************************************************
//STEP4  EXEC PGM=IDCAMS,COND=(0,NE,STEP3)
//SYSPRINT DD SYSOUT=*
//INMAST  DD DSN=&&SORTED,DISP=SHR
//SYSIN DD *
   REPRO-
    INFILE(INMAST)-
    OUTDATASET(Z002161.C465S02.VSAM.KSDS)
/*
//*******************************************************************
//* DEFINES ALTERNATE INDEX A UNIQUE ALTERNATE KEY, AKA EMPLYEE #
//*******************************************************************
//STEP5  EXEC PGM=IDCAMS,COND=(0,NE,STEP4)
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
   DEFINE AIX (-
   NAME (Z002161.C465S02.VSAM.KSDS.AIX1)-
   RELATE (Z002161.C465S02.VSAM.KSDS)-
   VOLUMES (ACA301)-
   RECORDSIZE (15 19)-
   KEYS (5 9)-
   UNIQUEKEY-
   UPGRADE-
   TRACKS (1 1) )

   DEFINE PATH (-
   NAME (Z002161.C465S02.VSAM.KSDS.PATH1)-
   PATHENTRY (Z002161.C465S02.VSAM.KSDS.AIX1))
/*
//*******************************************************************
//* THIS STEP BUILDS THE UNIQUE INDEX FOR KSDS CLUSTER
//*******************************************************************
//STEP6   EXEC PGM=IDCAMS,COND=(0,NE,STEP5)
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
   BLDINDEX-
       INDATASET (Z002161.C465S02.VSAM.KSDS)-
       OUTDATASET (Z002161.C465S02.VSAM.KSDS.AIX1)
/*
//*******************************************************************
//* DEFINES ALTERNATE INDEX A NONUNIQUE ALTERNATE KEY,
//*                     AKA EMPLYEE LAST NAME
//*******************************************************************
//STEP7   EXEC PGM=IDCAMS,COND=(0,NE,STEP6)
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
     DEFINE AIX (-
       NAME (Z002161.C465S02.VSAM.KSDS.AIX2)-
       RELATE (Z002161.C465S02.VSAM.KSDS)-
       VOLUMES (ACA301)-
       RECORDSIZE(47 74)-
       KEYS (15 14)-
       NONUNIQUEKEY-
       UPGRADE-
       TRACKS (1 1) )

     DEFINE PATH (-
       NAME (Z002161.C465S02.VSAM.KSDS.PATH2)-
       PATHENTRY (Z002161.C465S02.VSAM.KSDS.AIX2))
/*
//*******************************************************************
//* THIS STEP BUILDS THE NONUNIQUE INDEX FOR KSDS CLUSTER
//*******************************************************************
//STEP8   EXEC PGM=IDCAMS,COND=(0,NE,STEP7)
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
   BLDINDEX-
       INDATASET (Z002161.C465S02.VSAM.KSDS)-
       OUTDATASET (Z002161.C465S02.VSAM.KSDS.AIX2)
/*
//*******************************************************************
//*        DEFINES A ESDS CLUSTER                                   *
//*******************************************************************
//STEP9   EXEC PGM=IDCAMS,COND=(0,LT,STEP8)
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
   DEFINE CLUSTER (-
   NAME (Z002161.C465S02.VSAM.ESDS)-
   VOLUMES(ACA301)-
   NONINDEXED-
   RECORDS(70 10)-
   RECORDSIZE(82 82) )
/*
//*******************************************************************
//* LOADS DATA INTO THE ESDS CLUSTER
//*******************************************************************
//STEP10 EXEC PGM=IDCAMS,COND=(0,LT,STEP9)
//SYSPRINT DD SYSOUT=*
//INTRAN  DD DSN=T90RAZ1.C465S02.A9TRANS,UNIT=DISK,VOL=SER=ACA301,
//        DISP=SHR
//SYSIN DD *
   REPRO-
   INFILE(INTRAN)-
   OUTDATASET(Z002161.C465S02.VSAM.ESDS)
/*
//*******************************************************************
//* PRINT IS USED FOR PRINTING THE CLUSTERS IN CHARACTER
//*******************************************************************
//DUMPCLS EXEC PGM=IDCAMS,COND=(0,LT,STEP10)
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
     PRINT INDATASET(Z002161.C465S02.VSAM.KSDS)-
     CHAR
     PRINT INDATASET(Z002161.C465S02.VSAM.ESDS)-
     CHAR
     PRINT INDATASET(Z002161.C465S02.VSAM.KSDS.AIX1)-
     CHAR
     PRINT INDATASET(Z002161.C465S02.VSAM.KSDS.AIX2)-
     CHAR
/*
//STEP11 EXEC COMPILE,CREG=2048K,
//    CPARM='LIB,APOST,FLAG(W,W),TEST,MAP,OFFSET',COBJ=&&MAIN
//SYSIN DD *
         TITLE 'SAMIR FACI CSCI 465 SECTION 1 ASSIGNMENT 9'
      *******************************************************************
      * Module Name:   Assign9                                          *
      *                                                                 *
      * Function:      This program loads the RRDS cluster by           *
      *                calculating a hashed value, which the program    *
      *                uses for setting relative key of the RRDS file.  *
      *                                                                 *
      * Input:         unsorted input file                              *
      *                                                                 *
      * Output:        the loaded RRDS cluster                          *
      * Notes:                                                          *
      *******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    ASSIGN09.
       DATE-COMPILED.

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT MASTER-FILE ASSIGN TO DA-MASTER
           ORGANIZATION IS INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS SSS-NO
           ALTERNATE RECORD KEY IS EMP-NO
           ALTERNATE RECORD KEY IS EMP-L-NAME
           WITH DUPLICATES
           FILE STATUS IS STATUS-CODE.


           SELECT TRAN-FILE ASSIGN TO DA-AS-TRANS
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS STATUS-CODE.

           SELECT PRINT-FILE ASSIGN TO PRINTER.



       DATA DIVISION.
       FILE SECTION.
      ****************************************************************
      * MASTER-FILE IS A KSDS FILE USED AS INPUT AND OUTPUT FILE.
      ****************************************************************
       FD  MASTER-FILE
           RECORD CONTAINS 77 CHARACTERS.

       01  MASTER-RECORD.
           05 SSS-NO                       PIC X(9).
           05 EMP-NO                       PIC X(5).
           05 EMP-L-NAME                   PIC X(15).
           05 EMP-F-NAME                   PIC X(10).
           05 EMP-ADDRESS                  PIC X(27).
           05 EMP-DEP                      PIC X(3).
           05 EMP-YEAR-WORK                PIC 9(2).
           05 EMP-SALARY                   PIC 9(5).
           05 RETIRE-STATUS                PIC X.

      ****************************************************************
      * TRAN-FILE IS A ESDS FILE USED AS INPUT FILE.
      ****************************************************************

       FD  TRAN-FILE
           RECORD CONTAINS 81 CHARACTERS.

       01  TRAN-RECORD.
           05 TRAN-CODE                PIC X(4).
           05 TRAN-INFO                PIC X(77).
              05 ADD-INFO REDEFINES TRAN-INFO.
                 10 TRAN-ADD-SSS-NO          PIC X(9).
                 10 TRAN-ADD-EMP-NO          PIC X(5).
                 10 TRAN-ADD-EMP-L-NAME      PIC X(15).
                 10 TRAN-ADD-EMP-F-NAME      PIC X(10).
                 10 TRAN-ADD-EMP-ADDRESS     PIC X(27).
                 10 TRAN-ADD-EMP-DEP         PIC X(3).
                 10 TRAN-ADD-EMP-YEAR-WORK   PIC 9(2).
                 10 TRAN-ADD-EMP-SALARY      PIC 9(5).
                 10 TRAN-ADD-RETIRE-STATUS   PIC X.

              05 EMPN-INFO REDEFINES TRAN-INFO.
                 10 TRAN-EMPN-NO              PIC 9(5).
                 10 FILLER                    PIC X(72).
              05 INCR-INFO REDEFINES TRAN-INFO.
                 10 TRAN-INCR-KEY          PIC X(9).
                 10 TRAN-INCR-AMT          PIC 9(5).
                 10 FILLER                 PIC X(63).

              05 NAME-INFO REDEFINES TRAN-INFO.
                 10 TRAN-L-NAME            PIC X(15).
                 10 FILLER                 PIC X(62).
              05 PNAM-INFO REDEFINES TRAN-INFO.
                 10 TRAN-PNAM-LEN          PIC 9.
                 10 TRAN-PNAM-NAME         PIC X(7).
                 10 FILLER                 PIC X(69).
              05 DELT-INFO REDEFINES TRAN-INFO.
                 10 TRAN-DELT-KEY          PIC X(9).
                 10 FILLER                 PIC X(68).
              05 RETR-INFO REDEFINES TRAN-INFO.
                 10 TRAN-RETR-BLANKS       PIC X(77).
              05 SEQ-INFO REDEFINES TRAN-INFO.
                 10 TRAN-SEQ-BLANKS        PIC X(77).

      *******************************************************************
      * The PRINT-FILE holds the output.  PRINT-RECORD is written
      * from detail lines defined in WORKING-STORAGE.
      *******************************************************************

       FD  PRINT-FILE
           LABEL RECORDS ARE OMITTED
           RECORDING MODE IS F.

       01  PRINT-LINE                  PIC X(132).

       WORKING-STORAGE SECTION.

      *******************************************************************
      * VARS:                                                           *
      *   TRAN-EOF              TRANSACTION FILE EOF FLAG               *
      *   MAST-EOF              MASTER FILE EOF FLAG.                   *
      *   RETR-FLAG             FLAGS IF PERSON IS RETIRED              *
      * VARIABLES:                                                      *
      *   STATUS-CODE           STATUS CODE ON OPEN/CLOSE OF FILES      *
      *   LINE-CNT              COUNTS # OF LINES PER PAGE              *
      *   PAGE-CNT              COUNTS # OF PAGES IN REPORT             *
      *   WS-PNAM-KEY           WORKING STORAGE VALUE                   *
      * THE-DATE                                                        *
      *   RET-DATE              RETURNED DATE                           *
      *   MY-DATE               EDITED DATE.
      *******************************************************************
       01  FLAGS.
           05 TRAN-EOF                         PIC X   VALUE 'N'.
           05 MAST-EOF                         PIC X   VALUE 'N'.
           05 RETR-FLAG                        PIC X.

       01  VARIABLES.
           05 STATUS-CODE                      PIC XX.
           05 LINE-CNT                         PIC 99  VALUE 16.
           05 PAGE-CNT                         PIC 99.
           05 WS-PNAM-KEY                      PIC X(07).


       01  THE-DATE.
           05  RET-DATE                             PIC 9(6).
           05  MY-DATE.
               10  MY-MONTH                         PIC 9(2).
               10           PIC X  VALUE IS '/'.
               10  MY-DAY                           PIC 9(2).
               10           PIC X  VALUE IS '/'.
               10  MY-YEAR                          PIC 9(2).



      *******************************************************************
      *                     BEGIN PRINT-LINES.                          *
      *******************************************************************

      *******************************************************************
      * TTL-HEADER          PRINTS A REPORT TITLE AND DATE              *
      * HEADER*             PRINTS A HEADER FOR ALL THESE PUKEY REPORTS *
      * DETAIL-LINE1        DETAIL LINE FOR REPORTS                     *
      * DETAIL-LINE2        DETAIL LINE FOR ERRORS.                     *
      * DASHED-LINE         UNDER LINE.
      *******************************************************************

       01  TTL-HEADER.
           05  TTL-DATE                             PIC X(8).
           05                               PIC X(48) VALUE IS SPACES.
           05  TTL-TITLE                            PIC X(20)
                    VALUE IS 'TRANSACTION REPORT'.
           05                             PIC X(48) VALUE IS SPACES.
           05  TTL-PAGE                   PIC X(5) VALUE IS 'PAGE '.
           05  TTL-PAGENUM                PIC Z9.

       01  HEADER1.
           05  HD-CODE                      PIC X(5) VALUE IS 'CODE'.
           05                               PIC X(5) VALUE IS SPACES.
           05  HD-SSN                       PIC X(10) VALUE IS 'SSN/'.
           05                               PIC X(5) VALUE IS SPACES.
           05  HD-EMPNUM                    PIC X(5) VALUE IS 'EMP #'.
           05                               PIC X(5) VALUE IS SPACES.
           05  HD-LAST                      PIC X(15) VALUE IS
                                'LAST NAME'.
           05                               PIC X(5) VALUE IS SPACES.
           05  HD-FIRST                     PIC X(10) VALUE IS
                                'FIRST NAME'.
           05                               PIC X(5) VALUE IS SPACES.
           05  HD-ADDRESS                   PIC X(27)
                            VALUE IS 'ADDRESS'.
           05                               PIC X(5) VALUE IS SPACES.
           05  HD-DEPT                      PIC X(4) VALUE IS 'DEPT'.
           05                               PIC X(5) VALUE IS SPACES.
           05  HD-YEARS                     PIC X(5) VALUE IS 'YEARS'.
           05                               PIC X(2) VALUE IS SPACES.
           05  HD-SALARY                    PIC X(8)
                            VALUE IS 'SALARY'.
           05  HD-STATUS                    PIC X(4)
                            VALUE IS 'STAT'.

       01  HEADER2.
           05                               PIC X(10) VALUE IS SPACES.
           05                        PIC X(10) VALUE IS 'TRAN CODE'.


       01  DASHED-LINE          PIC X(132)  VALUE ALL '-'.

       01  DETAIL-LINE1.
           05  DET1-CODE                    PIC X(5) VALUE IS SPACES.
           05                               PIC X(5) VALUE IS SPACES.
           05  DET1-SSN                     PIC X(10) VALUE IS SPACES.
           05                               PIC X(5) VALUE IS SPACES.
           05  DET1-EMPNUM                  PIC X(5) VALUE IS SPACES.
           05                               PIC X(5) VALUE IS SPACES.
           05  DET1-LAST                    PIC X(15) VALUE IS SPACES.
           05                               PIC X(5) VALUE IS SPACES.
           05  DET1-FIRST                   PIC X(10) VALUE IS SPACES.
           05                               PIC X(5) VALUE IS SPACES.
           05  DET1-ADDRESS                 PIC X(27) VALUE IS SPACES.
           05                               PIC X(5) VALUE IS SPACES.
           05  DET1-DEPT                    PIC X(4) VALUE IS SPACES.
           05                               PIC X(5) VALUE IS SPACES.
           05  DET1-YEARS                   PIC Z9.
           05                               PIC X(5) VALUE IS SPACES.
           05  DET1-SALARY                  PIC $ZZ,ZZ9.
           05                               PIC X(5) VALUE IS SPACES.
           05  DET1-STATUS                  PIC X    VALUE IS SPACES.

       01  DETAIL-LINE2.
           05  DET2-CODE                    PIC X(5) VALUE IS SPACES.
           05                               PIC X(5) VALUE IS SPACES.
           05  DET2-SSN                     PIC X(10) VALUE IS SPACES.
           05  DET2-MSG                     PIC X(100)
                        VALUE IS SPACES.

      *******************************************************************
      *                     END PRINT-LINES.                            *
      *******************************************************************


           EJECT

       PROCEDURE DIVISION.

      *******************************************************************
      * 000-MAIN controls the flow of the program.                      *
      *  OPENS MASTER-FILE, THEN OPENS TRAN FILE.  FIXES DATE.          *
      *   THEN DOES CALLS A FUNCTION TO DRIVE THE PROGRAM UNTIL         *
      *   TRAN FILE IS DONE.                                            *
      *******************************************************************
       000-MAIN.

           OPEN I-O MASTER-FILE
                INPUT TRAN-FILE
                OUTPUT PRINT-FILE.


           IF STATUS-CODE NOT = '00'
              DISPLAY 'ERROR IN OPENING FILES'
              STOP RUN
           ELSE
                ACCEPT RET-DATE FROM DATE

                MOVE RET-DATE(1:2) TO MY-YEAR
                MOVE RET-DATE(3:2) TO MY-MONTH
                MOVE RET-DATE(5:2) TO MY-DAY

                MOVE 1 TO TTL-PAGENUM
                MOVE MY-DATE TO TTL-DATE

                PERFORM UNTIL TRAN-EOF = 'Y'
                    READ TRAN-FILE
                      AT END
                        MOVE 'Y' TO TRAN-EOF
                      NOT AT END
                        PERFORM 50-PROCESS-TRANSACTION-CODE
                    END-READ
                END-PERFORM
                MOVE ZEROES TO RETURN-CODE
           END-IF.

           PERFORM 10-DO-HEADERS.

           CLOSE MASTER-FILE
                 TRAN-FILE
                 PRINT-FILE.

           STOP RUN.
           EJECT



      ***************************************************************
      * PRINTS SOME DISGUSTING COBOL HEADERS.
      *
      ***************************************************************
       10-DO-HEADERS.


           IF LINE-CNT > 15
                ADD 1 TO PAGE-CNT
                MOVE PAGE-CNT TO TTL-PAGENUM
                WRITE PRINT-LINE FROM TTL-HEADER
                        AFTER ADVANCING PAGE
                END-WRITE
                WRITE PRINT-LINE FROM HEADER1
                WRITE PRINT-LINE FROM HEADER2
                WRITE PRINT-LINE FROM DASHED-LINE
                        AFTER ADVANCING 2 LINES
                END-WRITE

                MOVE 1 TO LINE-CNT
           END-IF.


           EJECT

      ***************************************************************
      * 50-PROCESS-TRANSACTION-CODE evaluates the TRAN-CODE read in
      * and calls the appropriate function, if an invalid TRAN-CODE
      * is read in, then it displays an error msg.
      ***************************************************************
       50-PROCESS-TRANSACTION-CODE.

           EVALUATE TRUE
              WHEN TRAN-CODE = 'ADD'
                   PERFORM 100-ADD-PROCESS
              WHEN TRAN-CODE = 'EMPN'
                   PERFORM 200-EMP-NO-PROCESS
              WHEN TRAN-CODE = 'INCR'
                   PERFORM 300-INCR-PROCESS
              WHEN TRAN-CODE = 'NAME'
                   PERFORM 400-NAME-PROCESS
              WHEN TRAN-CODE = 'PNAM'
                   PERFORM 500-PNAM-PROCESS
              WHEN TRAN-CODE = 'DELT'
                   PERFORM 600-DELETE-PROCESS
              WHEN TRAN-CODE = 'RETR'
                   PERFORM 700-RETR-PROCESS
              WHEN TRAN-CODE = 'SEQ'
                   PERFORM 800-SEQ-PROCESS

              WHEN OTHER
                   DISPLAY 'ERROR IN TRANSACTION CODE'
              END-EVALUATE.

           EJECT

      ***************************************************************
      * 100-ADD-PROCESS Adds a record to the Master file based on
      * tran code read in.
      ***************************************************************
       100-ADD-PROCESS.

           MOVE TRAN-ADD-SSS-NO TO SSS-NO.

           READ MASTER-FILE KEY IS SSS-NO
           INVALID KEY
             MOVE TRAN-ADD-SSS-NO TO SSS-NO
             MOVE TRAN-ADD-EMP-NO TO EMP-NO

             MOVE TRAN-ADD-EMP-L-NAME TO EMP-L-NAME
             MOVE TRAN-ADD-EMP-F-NAME TO EMP-F-NAME
             MOVE TRAN-ADD-EMP-ADDRESS TO EMP-ADDRESS
             MOVE TRAN-ADD-EMP-DEP TO EMP-DEP
             MOVE TRAN-ADD-EMP-YEAR-WORK  TO EMP-YEAR-WORK
             MOVE TRAN-ADD-EMP-SALARY TO EMP-SALARY
             MOVE TRAN-ADD-RETIRE-STATUS TO RETIRE-STATUS
             WRITE MASTER-RECORD
             INVALID KEY
               PERFORM 10-DO-HEADERS
               MOVE TRAN-CODE TO DET2-CODE
               MOVE TRAN-ADD-SSS-NO TO DET2-SSN
               MOVE '*** ERROR- RECORD ALREADY EXISTS ***' TO DET2-MSG
               WRITE PRINT-LINE FROM DETAIL-LINE2
                        AFTER ADVANCING 2 LINES
               ADD 1 TO LINE-CNT
             NOT INVALID KEY
               PERFORM 10-DO-HEADERS
               MOVE TRAN-CODE TO DET2-CODE
               MOVE TRAN-ADD-SSS-NO TO DET2-SSN
               MOVE '*** NEW RECORD HAS BEEN ADDED ***' TO DET2-MSG
               WRITE PRINT-LINE FROM DETAIL-LINE2
                    AFTER ADVANCING 2 LINES
               END-WRITE
               ADD 1 TO LINE-CNT
             END-WRITE
           NOT INVALID KEY
             PERFORM 10-DO-HEADERS
             MOVE TRAN-CODE TO DET2-CODE
             MOVE TRAN-ADD-SSS-NO TO DET2-SSN
             MOVE 'ERROR:  DUPLICATE SSN FOUND!' TO DET2-MSG
             WRITE PRINT-LINE FROM DETAIL-LINE2
                        AFTER ADVANCING 2 LINES
             END-WRITE
             ADD 1 TO LINE-CNT
               
           END-READ.

           EJECT




      ***************************************************************
      * 200-EMP-NO-PROCESS searches for the record matching the empl
      * no given.  if found it prints the record, else
      * an error msgs. is printed.
      ***************************************************************
       200-EMP-NO-PROCESS.


           MOVE TRAN-EMPN-NO TO EMP-NO.

           READ MASTER-FILE KEY IS EMP-NO
            INVALID KEY
                PERFORM 10-DO-HEADERS
                MOVE TRAN-CODE TO DET2-CODE
                MOVE TRAN-EMPN-NO TO DET2-SSN
                MOVE 'ERROR: COULD NOT READ FROM MASTER FILE'
                    TO DET2-MSG
                WRITE PRINT-LINE FROM DETAIL-LINE2
                      AFTER ADVANCING 2 LINES
                ADD 1 TO LINE-CNT

            NOT INVALID KEY
                PERFORM 10-DO-HEADERS
                MOVE TRAN-CODE TO DET1-CODE
                MOVE SSS-NO TO DET1-SSN
                MOVE TRAN-EMPN-NO TO DET1-EMPNUM
                MOVE EMP-L-NAME TO DET1-LAST
                MOVE EMP-F-NAME TO DET1-FIRST
                MOVE EMP-ADDRESS TO DET1-ADDRESS
                MOVE EMP-DEP TO DET1-DEPT
                MOVE EMP-YEAR-WORK TO DET1-YEARS
                MOVE EMP-SALARY TO DET1-SALARY
                MOVE RETIRE-STATUS TO DET1-STATUS

                WRITE PRINT-LINE FROM DETAIL-LINE1
                        AFTER ADVANCING 2 LINES
                END-WRITE
                ADD 1 TO LINE-CNT

            END-READ.


           EJECT


      ***************************************************************
      * 300-INCR-PROCESS adds the amount specified to the record's
      * salary field.  An unsuccessful transaction occurs when
      * the record whose SALARY is to incremented does not exist.
      ***************************************************************
       300-INCR-PROCESS.

           MOVE TRAN-INCR-KEY TO SSS-NO.

           READ MASTER-FILE KEY IS SSS-NO
             INVALID KEY
                PERFORM 10-DO-HEADERS
                MOVE TRAN-CODE TO DET2-CODE
                MOVE TRAN-INCR-KEY TO DET2-SSN
                MOVE '*** ERROR- INCREMENT-KEY DOES NOT EXIST ***'
                        TO DET2-MSG
                WRITE PRINT-LINE FROM DETAIL-LINE2
                      AFTER ADVANCING 2 LINES
                END-WRITE
                ADD 1 TO LINE-CNT

             NOT INVALID KEY
                ADD TRAN-INCR-AMT TO EMP-SALARY
                REWRITE MASTER-RECORD
                INVALID KEY
                    PERFORM 10-DO-HEADERS
                    MOVE TRAN-CODE TO DET2-CODE
                    MOVE TRAN-INCR-KEY TO DET2-SSN
                    MOVE '*** ERROR- ALTER TRANSACTION NOT DONE ***'
                        TO DET2-MSG
                    MOVE SPACES TO DET2-SSN
                    WRITE PRINT-LINE FROM DETAIL-LINE2
                        AFTER ADVANCING 2 LINES
                    END-WRITE
                    ADD 1 TO LINE-CNT
                NOT INVALID KEY
                    PERFORM 10-DO-HEADERS
                    MOVE TRAN-CODE TO DET1-CODE
                    MOVE SSS-NO TO DET1-SSN
                    MOVE EMP-NO TO DET1-EMPNUM
                    MOVE EMP-L-NAME TO DET1-LAST
                    MOVE EMP-F-NAME TO DET1-FIRST
                    MOVE EMP-ADDRESS TO DET1-ADDRESS
                    MOVE EMP-DEP TO DET1-DEPT
                    MOVE EMP-YEAR-WORK TO DET1-YEARS
                    MOVE EMP-SALARY TO DET1-SALARY
                    MOVE RETIRE-STATUS TO DET1-STATUS
                    WRITE PRINT-LINE FROM DETAIL-LINE1
                              AFTER ADVANCING 2 LINES
                    END-WRITE
                    ADD 1 TO LINE-CNT
                END-REWRITE
            END-READ.


           EJECT


      ***************************************************************
      * 400-NAME-PROCESS Find all of the base cluster records
      * requested by the alternate key last name that follows NAME.
      *
      ***************************************************************
       400-NAME-PROCESS.

           MOVE TRAN-L-NAME TO EMP-L-NAME.
           MOVE 'N' TO MAST-EOF.

           START MASTER-FILE KEY IS = EMP-L-NAME
           INVALID KEY

              PERFORM 10-DO-HEADERS
              MOVE TRAN-CODE TO DET2-CODE
              MOVE SPACES TO DET2-SSN
              MOVE '*** ERROR- NAME NOT FOUND ***' TO DET2-MSG
              WRITE PRINT-LINE FROM DETAIL-LINE2
                    AFTER ADVANCING 2 LINES
              END-WRITE
              ADD 1 TO LINE-CNT

           NOT INVALID KEY
              READ MASTER-FILE NEXT RECORD
                 AT END
                 MOVE 'Y' TO MAST-EOF
              END-READ
              PERFORM UNTIL STATUS-CODE NOT = '02' OR
                      MAST-EOF = 'Y'

                 PERFORM 10-DO-HEADERS

                 MOVE TRAN-CODE TO DET1-CODE
                 MOVE SSS-NO TO DET1-SSN
                 MOVE EMP-NO TO DET1-EMPNUM
                 MOVE TRAN-L-NAME TO DET1-LAST
                 MOVE EMP-L-NAME TO DET1-LAST
                 MOVE EMP-F-NAME TO DET1-FIRST
                 MOVE EMP-ADDRESS TO DET1-ADDRESS
                 MOVE EMP-DEP TO DET1-DEPT
                 MOVE EMP-YEAR-WORK TO DET1-YEARS
                 MOVE EMP-SALARY TO DET1-SALARY
                 MOVE RETIRE-STATUS TO DET1-STATUS

                 WRITE PRINT-LINE FROM DETAIL-LINE1 
                    AFTER ADVANCING 2 LINES
                 END-WRITE
                 
                 ADD 1 TO LINE-CNT

                READ MASTER-FILE NEXT RECORD
                   AT END MOVE 'Y' TO MAST-EOF
                END-READ
              END-PERFORM

              PERFORM 10-DO-HEADERS

              MOVE TRAN-CODE TO DET1-CODE
              MOVE SSS-NO TO DET1-SSN
              MOVE EMP-NO TO DET1-EMPNUM
              MOVE TRAN-L-NAME TO DET1-LAST
              MOVE EMP-L-NAME TO DET1-LAST
              MOVE EMP-F-NAME TO DET1-FIRST
              MOVE EMP-ADDRESS TO DET1-ADDRESS
              MOVE EMP-DEP TO DET1-DEPT
              MOVE EMP-YEAR-WORK TO DET1-YEARS
              MOVE EMP-SALARY TO DET1-SALARY
              MOVE RETIRE-STATUS TO DET1-STATUS

              WRITE PRINT-LINE FROM DETAIL-LINE1
                    AFTER ADVANCING 2 LINES
              END-WRITE

              ADD 1 TO LINE-CNT

           END-START.

           EJECT


      ***************************************************************
      * 500-PNAM-PROCESS Find all of the base cluster records
      * requested by the partial alternate key last name that
      * follows PNAME.
      ***************************************************************
       500-PNAM-PROCESS.


           MOVE TRAN-PNAM-NAME TO WS-PNAM-KEY EMP-L-NAME DET1-CODE.
           MOVE 'N' TO MAST-EOF.
           INSPECT WS-PNAM-KEY REPLACING ALL SPACES BY HIGH-VALUES.

           START MASTER-FILE
             KEY NOT < EMP-L-NAME
           END-START.
             IF STATUS-CODE = '23'
                PERFORM 10-DO-HEADERS
                MOVE TRAN-CODE TO DET2-CODE
                MOVE TRAN-PNAM-NAME TO DET2-SSN
                MOVE 'RECORD WITH THIS PNAM NOT FOUND' TO DET2-MSG
                MOVE SPACES TO DET2-SSN
                WRITE PRINT-LINE FROM DETAIL-LINE2
                        AFTER ADVANCING 2 LINES
                END-WRITE
                ADD 1 TO LINE-CNT
             ELSE
                READ MASTER-FILE NEXT RECORD
                  AT END
                     MOVE 'Y' TO MAST-EOF
                END-READ
                IF EMP-L-NAME > WS-PNAM-KEY
                   PERFORM 10-DO-HEADERS
                   MOVE TRAN-CODE TO DET2-CODE
                   MOVE TRAN-PNAM-NAME TO DET2-SSN
                   MOVE '*** ERROR- RECORD DOES NOT EXIST ***'
                            TO DET2-MSG
                   WRITE PRINT-LINE FROM DETAIL-LINE2
                        AFTER ADVANCING 2 LINES
                   END-WRITE
                   ADD 1 TO LINE-CNT
                ELSE
                PERFORM UNTIL EMP-L-NAME > WS-PNAM-KEY OR
                MAST-EOF = 'Y'

                   PERFORM 10-DO-HEADERS
                   MOVE TRAN-CODE TO DET1-CODE
                   MOVE SSS-NO TO DET1-SSN
                   MOVE EMP-NO TO DET1-EMPNUM
                   MOVE EMP-L-NAME TO DET1-LAST
                   MOVE EMP-F-NAME TO DET1-FIRST
                   MOVE EMP-ADDRESS TO DET1-ADDRESS
                   MOVE EMP-DEP TO DET1-DEPT
                   MOVE EMP-YEAR-WORK TO DET1-YEARS
                   MOVE EMP-SALARY TO DET1-SALARY
                   MOVE RETIRE-STATUS TO DET1-STATUS
                   
                   WRITE PRINT-LINE FROM DETAIL-LINE1
                        AFTER ADVANCING 2 LINES
                   END-WRITE
                   ADD 1 TO LINE-CNT

                   READ MASTER-FILE NEXT RECORD
                        AT END MOVE 'Y' TO MAST-EOF
                   END-READ
                END-PERFORM
                END-IF

               END-IF.

           EJECT


      ***************************************************************
      * 600-DELETE-PROCESS deletes a record from the master file.
      *
      ***************************************************************
       600-DELETE-PROCESS.


           MOVE TRAN-DELT-KEY TO SSS-NO.

           READ MASTER-FILE KEY IS SSS-NO
             INVALID KEY

                PERFORM 10-DO-HEADERS
                MOVE TRAN-CODE TO DET2-CODE
                MOVE TRAN-DELT-KEY TO DET2-SSN
                MOVE '*** ERROR- NO RECORD TO DELETE ***' TO DET2-MSG

                WRITE PRINT-LINE FROM DETAIL-LINE2
                        AFTER ADVANCING 2 LINES
                END-WRITE
                
                ADD 1 TO LINE-CNT

              NOT INVALID KEY
                DELETE MASTER-FILE RECORD
                INVALID KEY
                   PERFORM 10-DO-HEADERS   

                   MOVE TRAN-CODE TO DET2-CODE    
                   MOVE TRAN-DELT-KEY TO DET2-SSN    
                   MOVE '*** ERROR- DELETE UNSUCCESSFUL ***' 
                            TO DET2-MSG

                   WRITE PRINT-LINE FROM DETAIL-LINE2 
                            AFTER ADVANCING 2 LINES
                   END-WRITE
                   ADD 1 TO LINE-CNT

                NOT INVALID KEY

                   PERFORM 10-DO-HEADERS   
                   MOVE TRAN-CODE TO DET2-CODE    
                   MOVE TRAN-DELT-KEY TO DET2-SSN   
                   MOVE '*** DELETE SUCCESSFUL ***' TO DET2-MSG

                   WRITE PRINT-LINE FROM DETAIL-LINE2 
                        AFTER ADVANCING 2 LINES
                   END-WRITE
                   
                   ADD 1 TO LINE-CNT

                END-DELETE
            END-READ.

           EJECT


      ***************************************************************
      * 700-RETR-PROCESS retires an employee and deletes him from 
      *  the master file. (hope he has a good pension plan)
      ***************************************************************
       700-RETR-PROCESS.

           MOVE LOW-VALUES TO SSS-NO.
           MOVE 'N' TO MAST-EOF RETR-FLAG.
          
           START MASTER-FILE
              KEY NOT < SSS-NO
           END-START.
           READ MASTER-FILE NEXT RECORD 
           AT END
              MOVE 'Y' TO MAST-EOF
           END-READ
           PERFORM UNTIL MAST-EOF = 'Y'   
            IF RETIRE-STATUS = 'R'  
               DELETE MASTER-FILE RECORD
               INVALID KEY

                 PERFORM 10-DO-HEADERS
                 MOVE RETIRE-STATUS TO DET2-SSN    
                 MOVE TRAN-CODE TO DET2-CODE    
                 MOVE '*** ERROR- RETR UNSUCCESSFUL ***' TO DET2-MSG
                 WRITE PRINT-LINE FROM DETAIL-LINE2 
                        AFTER ADVANCING 2 LINES
                 END-WRITE
                 ADD 1 TO LINE-CNT                 

                NOT INVALID KEY

                 MOVE TRAN-CODE TO DET2-CODE    
                 MOVE 'UR DONE!' TO DET2-SSN   

                 MOVE '*** RETR SUCCESSFUL ***' TO DET2-MSG

                 WRITE PRINT-LINE FROM DETAIL-LINE2 
                        AFTER ADVANCING 2 LINES
                 END-WRITE
                 ADD 1 TO LINE-CNT

                 MOVE 'Y' TO RETR-FLAG
                END-DELETE
            END-IF
            READ MASTER-FILE NEXT RECORD 
            AT END
            MOVE 'Y' TO MAST-EOF
            END-READ
           END-PERFORM.

           IF RETR-FLAG NOT = 'Y'

                PERFORM 10-DO-HEADERS    
                MOVE SPACES TO DET2-SSN
                MOVE '*** ERROR- NO RECORD TO RETR ***' TO DET2-MSG
                MOVE TRAN-CODE TO DET2-CODE    
                WRITE PRINT-LINE FROM DETAIL-LINE2 
                        AFTER ADVANCING 2 LINES
                END-WRITE
                ADD 1 TO LINE-CNT

           END-IF.


           EJECT


      ***************************************************************
      * 800-SEQ-PROCESS prints all the stupid records in seq order.
      *
      ***************************************************************
       800-SEQ-PROCESS.

           MOVE LOW-VALUES TO SSS-NO.
           MOVE 'N' TO MAST-EOF.
          
           START MASTER-FILE
              KEY NOT < SSS-NO
           END-START.

           READ MASTER-FILE NEXT RECORD 
           AT END
              MOVE 'Y' TO MAST-EOF
           END-READ

           PERFORM UNTIL MAST-EOF = 'Y'

                PERFORM 10-DO-HEADERS
                
                MOVE TRAN-CODE TO DET1-CODE    
                MOVE SSS-NO TO DET1-SSN   
                MOVE EMP-NO TO DET1-EMPNUM
                MOVE EMP-L-NAME TO DET1-LAST
                MOVE EMP-F-NAME TO DET1-FIRST
                MOVE EMP-ADDRESS TO DET1-ADDRESS
                MOVE EMP-DEP TO DET1-DEPT
                MOVE EMP-YEAR-WORK TO DET1-YEARS
                MOVE EMP-SALARY TO DET1-SALARY
                MOVE RETIRE-STATUS TO DET1-STATUS

                WRITE PRINT-LINE FROM DETAIL-LINE1 
                        AFTER ADVANCING 2 LINES
                END-WRITE
                
                ADD 1 TO LINE-CNT 
       
                READ MASTER-FILE NEXT RECORD 
                    AT END MOVE 'Y' TO MAST-EOF
                END-READ
                
            END-PERFORM.


           EJECT



/*
//STEP10B EXEC LINKED,LOBJ=&&MAIN
//PROC3.PRINTER DD SYSOUT=*
//PROC3.MASTER  DD DSN=Z002161.C465S02.VSAM.KSDS,DISP=SHR
//PROC3.MASTER1 DD DSN=Z002161.C465S02.VSAM.KSDS.PATH1,DISP=SHR
//PROC3.MASTER2 DD DSN=Z002161.C465S02.VSAM.KSDS.PATH2,DISP=SHR
//PROC3.TRANS   DD DSN=Z002161.C465S02.VSAM.ESDS,DISP=SHR
//*******************************************************************
//* PRINT IS USED FOR PRINTING THE UPDATED KSDS CLUSTER IN  CHARACTER.
//* FORMAT
//*******************************************************************
//STEP11 EXEC PGM=IDCAMS,COND=EVEN
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
     PRINT INDATASET(Z002161.C465S02.VSAM.KSDS)-
     CHAR
/*
//*******************************************************************
//* FINAL DELETE
//*******************************************************************
//STEP12  EXEC PGM=IDCAMS,COND=EVEN
//SYSPRINT  DD SYSOUT=*
//SYSIN  DD *
    DELETE (Z002161.C465S02.VSAM.KSDS)
    DELETE (Z002161.C465S02.VSAM.ESDS)
/*
//

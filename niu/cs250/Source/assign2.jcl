//Z002161A JOB ,'Samir Faci'
/*JOBPARM ROOM=161
//    EXEC IGYWCG,CPARM='FLAG(I,I),APOST,TEST(STMT)'
//COB.SYSIN DD *
      ***************************************************************
      * Module Name:   Assign2
      *
      * Function:      To print data about severalone computer 
      *                science courses.
      *
      * Input:         A file containing several course records.
      *
      * Output:        Three detail lines are printed from the data
      *                on the input record for each record read
      *                seperated by two lines.
      *
      * Notes:         None
      ***************************************************************
 
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  ASSIGN2.
 
 
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO S-SYSIN.
           SELECT PRINT-FILE ASSIGN TO S-SYSOUT.
 
           EJECT
       DATA DIVISION.
 
       FILE SECTION.
 
      ***************************************************************
      * The INPUT-FILE contains several 80-character customer record.
      * Each record contains the course number, course title,
      * credit hours, and prerequisites.
      ***************************************************************
 
       FD  INPUT-FILE
           RECORDING MODE IS F.
 
       01  INPUT-RECORD.
           05  IN-COURSE-NUMBER           PIC X(8).
           05  IN-COURSE-TITLE            PIC X(35).
           05  IN-CREDIT-HOURS            PIC X.
           05  IN-PREREQUISITES           PIC X(35).
           05                             PIC X.
 
 
      ***************************************************************
      * The PRINT-FILE holds the output.  PRINT-RECORD is written
      * from detail lines defined in WORKING-STORAGE.
      ***************************************************************
 
       FD  PRINT-FILE
           LABEL RECORDS ARE OMITTED
           RECORDING MODE IS F.
 
       01  PRINT-LINE                 PIC X(132).
 
           EJECT
       WORKING-STORAGE SECTION.
 
      ***************************************************************
      * VARIABLE DICTIONARY
      *
      * SYSTEM-DATE-AND-TIME     Current system date and time.
      * DETAIL-LINE-ONE          Course number and title.
      * DETAIL-LINE-TWO          Credit hours.
      * DETAIL-LINE-THREE        Prerequisites.
      * EOF-FLAG                 Signals end of file.
      ***************************************************************
 
       01  SYSTEM-DATE-AND-TIME.
           05  SYS-DATE               PIC X(6).
           05                         PIC X           VALUE SPACE.
           05  SYS-TIME               PIC X(8).
 
       01  DETAIL-LINE-ONE.
           05                         PIC X(45)       VALUE SPACES.
           05  DET1-COURSE-NUMBER     PIC X(8).
           05                         PIC X(8)        VALUE SPACES.
           05  DET1-COURSE-TITLE      PIC X(35).
           05                         PIC X(36)       VALUE SPACES.
 
       01  DETAIL-LINE-TWO.
           05                         PIC X(45)       VALUE SPACES.
           05                         PIC X(16)
                                        VALUE 'CREDIT HOURS:'.
           05  DET2-CREDIT-HOURS      PIC X.
           05                         PIC X(70)       VALUE SPACES.
 
       01  DETAIL-LINE-THREE.
           05                         PIC X(45)       VALUE SPACES.
           05                         PIC X(16)
                                        VALUE 'PREREQUISITES:'.
           05  DET3-PREREQUISITES     PIC X(35).
           05                         PIC X(36)       VALUE SPACES.
       
       01  EOF-FLAG                   PIC X           VALUE 'N'.
       
       
           EJECT
       PROCEDURE DIVISION.
 
      ***************************************************************
      * 000-MAIN obtains the system date and time, then calls a
      * subroutine to print it.  It reads the input record, then
      * calls a subroutine to print the detail lines until it reaches
      * the eof marker (aka eof-flag = 'y')
      ***************************************************************
 
       000-MAIN.
 
           OPEN INPUT INPUT-FILE
                OUTPUT PRINT-FILE.
 
           ACCEPT SYS-DATE FROM DATE.
           ACCEPT SYS-TIME FROM TIME.
           PERFORM 100-PRINT-HEADER.
 
           READ INPUT-FILE.
           PERFORM 200-PROCESS-RECORD UNTIL EOF-FLAG = 'Y'.
 
           CLOSE INPUT-FILE
                 PRINT-FILE.
           STOP RUN.
 
 
 
      ***************************************************************
      * 100-PRINT-HEADER just prints the system date and time.
      ***************************************************************
 
       100-PRINT-HEADER.
 
           WRITE PRINT-LINE FROM SYSTEM-DATE-AND-TIME
               AFTER ADVANCING PAGE.
 
 
           EJECT
      ***************************************************************
      * 200-PROCESS-RECORD fills in each detail line (with
      * appropriate data from the input record) and writes it 
      * until it reaches eof.
      ***************************************************************
 
       200-PROCESS-RECORD.
 
           MOVE IN-COURSE-NUMBER TO DET1-COURSE-NUMBER.
           MOVE IN-COURSE-TITLE TO DET1-COURSE-TITLE.
           WRITE PRINT-LINE FROM DETAIL-LINE-ONE
               AFTER ADVANCING 2 LINES.
 
           MOVE IN-CREDIT-HOURS TO DET2-CREDIT-HOURS.
           WRITE PRINT-LINE FROM DETAIL-LINE-TWO
               AFTER ADVANCING 1 LINE.
 
           MOVE IN-PREREQUISITES TO DET3-PREREQUISITES.
           WRITE PRINT-LINE FROM DETAIL-LINE-THREE
               AFTER ADVANCING 1 LINE.
           READ INPUT-FILE
                 AT END MOVE 'Y' TO EOF-FLAG.
 
/*
//GO.SYSIN  DD DSN=T90ASS1.SPRING01.COBDATA(DATA02),DISP=SHR
//GO.SYSOUT DD SYSOUT=*
//


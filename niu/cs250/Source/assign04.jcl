//Z002161A JOB ,'Samir Faci'
/*JOBPARM ROOM=161
//    EXEC IGYWCG,CPARM='FLAG(I,I),APOST,TEST(STMT)'
//COB.SYSIN DD *
      ***************************************************************
      * Module Name:   Assign4
      *
      * Function:      Read and record a report concerning sales in
      *                a furniture store.
      *
      * Input:         A file containing several records concerning
      *                the furniture store.
      * Output:        a printed report that summerize the business
      *                of the furniture store.
      *
      * Notes:         None
      ***************************************************************
 
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  ASSIGN4.
 
 
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO S-SYSIN.
           SELECT PRINT-FILE ASSIGN TO S-SYSOUT.
 
           EJECT
       DATA DIVISION.
 
       FILE SECTION.
 
      ***************************************************************
      * The INPUT-FILE contains several 80-character.
      * Each record contains the customer name, date, sale amount,
      * transaction type, and room code.
      ***************************************************************
 
       FD  INPUT-FILE
           RECORDING MODE IS F.
 
       01  INPUT-RECORD.
           05  IN-CUST-NAME               PIC X(6).
           05                             PIC X. 
           05  IN-DATE                    PIC 9(6).
           05                             PIC X.
           05  IN-SALE-AMT                PIC 9(5)V99.
           05                             PIC X.
           05  IN-TRAN-TYPE               PIC 9.
           05  IN-ROOM-CODE               PIC 9.
           05                             PIC X(56).
 
 
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
      *  Ok, here we go..let's see if i can make heads or tails of 
      *  this.
      *
      * VARIABLE DICTIONARY
      *
      * SYSTEM-DATE-AND-TIME     Current system date and time.
      * DETAIL-LINE-ONE          title of 1st table.
      * DETAIL-LINE-TWO          headers of table columns.
      * EOF-FLAG                 Signals end of file.
      * DETAIL-DATA-LINE         stores info read from the input-file.
      * DETAIL-SUMMERY-TITLE     stores title of header of summery
      *                          table.
      * COUNTER                  variables used to keep track of 
      *                          misc. info incremented by 1.
      *                          (most of 'em anyways.)
      * PAGE-BREAK               used to print a blank line, then
      *                          to skip a page.
      * CALCULATION              variables used in arithmetic then
      *                          moving it to a formated variables.
      * DET-SUMMERY              prints the final table.
      ****************************************************************
 
       01  SYSTEM-DATE-AND-TIME.
           05  SYS-DATE               PIC X(6).
           05                         PIC X           VALUE SPACE.
           05  SYS-TIME               PIC X(8).
 
       01  DETAIL-LINE-ONE.
           05                         PIC X(54)       VALUE SPACES.
           05  DET1-TITLE             PIC X(29)
                            VALUE 'WEEKLY FURNITURE SALES REPORT'.
           05                         PIC X(46)       VALUE SPACES.
           05  PAGE-COUNT             PIC 9(2)        VALUE 1. 
 
       01  DETAIL-LINE-TWO.
           05                         PIC X(27)       VALUE SPACES.
           05  DET2-CUSTOMER          PIC X(10)
                                        VALUE 'CUSTOMER#'.
           05                         PIC X(5)       VALUE SPACES.
           05  DET2-DATE              PIC X(8)
                                        VALUE 'DATE'.
           05                         PIC X(8)       VALUE SPACES.
           05  DET2-RETURN            PIC X(11)
                                        VALUE 'SALE/RETURN'.
           05                         PIC X(15)      VALUE SPACES.
           05  DET2-AMOUNT            PIC X(6)
                                        VALUE 'AMOUNT'.
           05                         PIC X(5)       VALUE SPACES.
           05  DET2-ROOM-TYPE         PIC X(10)
                                        VALUE 'ROOM TYPE'.
           05                         PIC X(10)       VALUE SPACES.
           05  DET2-RUNNING-TOT       PIC X(14)
                                        VALUE 'RUNNING TOTALS'.
 
       01  DETAIL-DATA-LINE.
           05                         PIC X(27)       VALUE SPACES.
           05  DETD-CUST              PIC X(6)        VALUE SPACES.
           05                         PIC X(9)        VALUE SPACES.
           05  DETD-DATE              PIC 99/99/99    VALUE ZERO.
           05                         PIC X(8)        VALUE SPACES.
           05  DETD-RETURN            PIC X(11)       VALUE SPACES.
           05                         PIC X(13)       VALUE SPACES.
           05  DETD-AMOUNT            PIC $$,$$$.99CR.
           05                         PIC X(5)        VALUE SPACES.
           05  DETD-ROOM-TYPE         PIC X(15)       VALUE SPACES.
           05                         PIC X(5)        VALUE SPACES.
           05  DETD-RUNNING-TO        PIC $,$$$,$$$.99CR VALUE ZERO.


       01  DETAIL-SUMMERY-TITLE.
           05                         PIC X(60)       VALUE SPACES.
           05  DETS-TITLE             PIC X(12) 
                                        VALUE 'GROSS SALES'.
           05                         PIC X(60)       VALUE SPACES.


       01  SYSTEM-VARIABLES.
           05  EOF-FLAG               PIC X           VALUE 'N'.

       01  COUNTER.
           05  COUNT-PAGE-BREAK       PIC 99          VALUE 15.
           05  LIV-RM-TOT             PIC S9(4)V99    VALUE ZERO.
           05  DIN-RM-TOT             PIC S9(4)V99    VALUE ZERO.
           05  BED-RM-TOT             PIC S9(4)V99    VALUE ZERO.
           05  MISC-TOT               PIC S9(4)V99    VALUE ZERO.
           

       01  PAGE-BREAK                 PIC X(132)      VALUE ALL SPACES.
       
       01  CALCULATION.
           05  CALC-SALES-AMT         PIC S9(8)V99     VALUE ZERO.
           05  CALC-RUN-TOT           PIC S9(8)V99      VALUE ZERO.

       01  DET-SUMMERY.
           05                         PIC X(52)       VALUE SPACES.
           05  DETS-TITLE2            PIC X(14)       VALUE SPACES.
           05                         PIC X(10)       VALUE SPACES.
           05  DETS-TOTS              PIC $$,$$$,$$$.99-  VALUE ZERO.
           05  FILLER                 PIC X(48)       VALUE SPACES.

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

           PERFORM 100-PRINT-DATE.
           PERFORM 200-TITLES.
           READ INPUT-FILE.
           PERFORM 300-PERFORM UNTIL EOF-FLAG = 'Y'.

           PERFORM 400-SUMMERY.

           CLOSE INPUT-FILE
                 PRINT-FILE.
           STOP RUN.
 
 
 
      ***************************************************************
      * 100-PRINT-DATE just prints the system date and time.
      ***************************************************************
 
       100-PRINT-DATE.
 
           WRITE PRINT-LINE FROM SYSTEM-DATE-AND-TIME
               AFTER ADVANCING PAGE.

 
            EJECT
 




      ***************************************************************
      * 200-TITLES prints column headers and titles for table 1.
      ***************************************************************
 
       200-TITLES.
 
           WRITE PRINT-LINE FROM DETAIL-LINE-ONE
               AFTER ADVANCING 3 LINE.
           WRITE PRINT-LINE FROM DETAIL-LINE-TWO
               AFTER ADVANCING 2 LINES.

           IF COUNT-PAGE-BREAK >= 15
                WRITE PRINT-LINE FROM PAGE-BREAK
                    AFTER ADVANCING PAGE
                MOVE ZERO TO COUNT-PAGE-BREAK
                ADD 1 TO PAGE-COUNT GIVING PAGE-COUNT.
           END-IF.
  
           EJECT






      ***************************************************************
      * 300-PERFORM moves data to correct variables and prints
      * it in a nice table format.  
      ***************************************************************
 
       300-PERFORM.
 
           MOVE IN-CUST-NAME TO DETD-CUST.
           MOVE IN-DATE TO DETD-DATE.
           MOVE IN-SALE-AMT TO CALC-SALES-AMT.
           
           EVALUATE IN-TRAN-TYPE
              WHEN 1
                 MOVE 'SALE' TO DETD-RETURN
              WHEN 2
                 MOVE 'RETURN' TO DETD-RETURN
              WHEN OTHER
                 MOVE 'ERROR' TO DETD-RETURN
           END-EVALUATE.
            
           EVALUATE IN-ROOM-CODE
              WHEN 1
                 MOVE 'Dinning Room' TO DETD-ROOM-TYPE
              WHEN 2
                 MOVE 'Living Room' TO DETD-ROOM-TYPE
              WHEN 3
                 MOVE 'Bedroom' TO DETD-ROOM-TYPE
              WHEN 4 
                 MOVE 'Miscellaneous' TO DETD-ROOM-TYPE
              WHEN OTHER
                 MOVE 'ERROR' TO DETD-ROOM-TYPE
           END-EVALUATE.

           IF DETD-RETURN = 'RETURN'
                  MULTIPLY CALC-SALES-AMT BY -1 GIVING CALC-SALES-AMT.
           
           MOVE CALC-SALES-AMT TO DETD-AMOUNT.
           ADD CALC-SALES-AMT TO CALC-RUN-TOT GIVING CALC-RUN-TOT.
           MOVE CALC-RUN-TOT TO DETD-RUNNING-TO.

           WRITE PRINT-LINE FROM DETAIL-DATA-LINE
                 AFTER ADVANCING 2 LINE.

           EVALUATE DETD-ROOM-TYPE
              WHEN 'Dinning Room'
                   ADD CALC-SALES-AMT TO DIN-RM-TOT GIVING DIN-RM-TOT
              WHEN 'Living Room' 
                   ADD CALC-SALES-AMT TO LIV-RM-TOT GIVING LIV-RM-TOT 
              WHEN 'Bedroom'
                   ADD CALC-SALES-AMT TO BED-RM-TOT GIVING BED-RM-TOT
              WHEN 'Miscellaneous'
                   ADD CALC-SALES-AMT TO MISC-TOT GIVING MISC-TOT
           END-EVALUATE.

           ADD 1 TO COUNT-PAGE-BREAK GIVING COUNT-PAGE-BREAK.

           IF COUNT-PAGE-BREAK >= 15
                   PERFORM 200-TITLES
           END-IF.

           READ INPUT-FILE
                AT END MOVE 'Y' TO EOF-FLAG.
 
           EJECT


      ***************************************************************
      * 300-PRINT-HEADER just prints the system date and time.
      ***************************************************************
 
       400-SUMMERY.
 
           WRITE PRINT-LINE FROM DETAIL-SUMMERY-TITLE
               AFTER ADVANCING 3 LINES.
 
           MOVE 'Living Room:' TO DETS-TITLE2.
           MOVE LIV-RM-TOT TO DETS-TOTS.
           WRITE PRINT-LINE FROM DET-SUMMERY
               AFTER ADVANCING 2 LINES.
         
           MOVE 'Dining Room:' TO DETS-TITLE2.
           MOVE DIN-RM-TOT TO DETS-TOTS.
           WRITE PRINT-LINE FROM DET-SUMMERY
               AFTER ADVANCING 2 LINES.

           MOVE 'Bedroom:' TO DETS-TITLE2.
           MOVE BED-RM-TOT TO DETS-TOTS.
           WRITE PRINT-LINE FROM DET-SUMMERY
               AFTER ADVANCING 2 LINES.

           MOVE 'Miscellaneous:' TO DETS-TITLE2.
           MOVE MISC-TOT TO DETS-TOTS.
           WRITE PRINT-LINE FROM DET-SUMMERY
               AFTER ADVANCING 2 LINES.

           EJECT

/*
//GO.SYSIN  DD DSN=T90ASS1.SPRING01.COBDATA(DATA04),DISP=SHR
//GO.SYSOUT DD SYSOUT=*
//

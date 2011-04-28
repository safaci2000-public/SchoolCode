//Z002161A JOB ,'Samir Faci'
/*JOBPARM ROOM=161
//    EXEC IGYWCG,CPARM='FLAG(I,I),APOST,TEST(STMT)'
//COB.SYSIN DD *

      *******************************************************************
      * Module Name:   Assign10
      *
      * Function:      To Add, Alter, or Delete the master file
      *                accordingly and print a report after the task
      *                is completed.
      *
      * Input:         Master file and Transaction file.
      *
      * Output:        A report that prints error encountered.
      *                
      * Notes:         None
      *******************************************************************
 
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  ASSIGN10.
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT MASTER-FILE ASSIGN      TO S-OLDMAST.
           SELECT NEW-MASTER-FILE  ASSIGN TO S-NEWMAST.
           SELECT TRAN-FILE ASSIGN        TO S-TRAN.
           SELECT PRINT-FILE  ASSIGN      TO S-SYSOUT.


 
           EJECT

       DATA DIVISION.
 
       FILE SECTION.
 
      *******************************************************************
      * The OLD-MASTER-FILE contains several records pertaining to the
      * business of ABC Properties Inc.
      *******************************************************************
 
       FD  MASTER-FILE
           RECORD CONTAINS 142 CHARACTERS
           LABEL RECORDS ARE STANDARD
           RECORDING MODE IS F.

       01  MAST-HEADER-RECORD.
           05  MAST-HDR-BLANKS          PIC X(23).
           05  MAST-HDR-NAME            PIC X(4).
           05  MAST-HDR-DATE.
               10  MAST-HDR-MONTH       PIC 9(2).
               10  MAST-HDR-DAY         PIC 9(2).
               10  MAST-HDR-YEAR        PIC 9(4).
           05  FILLER                   PIC X(107).
           
       01  MAST-RECORD.
           05  MASTER-KEY.
               10  MAST-BULDING-ID       PIC X.
               10  MAST-APT-NUM          PIC 9(3).

           05  MAST-APT-TN               PIC X(2).
           05  MAST-NUM-OF-BED           PIC 9.
           05  MAST-TOT-SQR-FT           PIC 9(4).
           05  MAST-LEASE-START-DATE.
               10  MAST-MONTH-START      PIC 9(2).
               10  MAST-DAY-START        PIC 9(2).
               10  MAST-YEAR-START       PIC 9(4).
           05  MAST-LEASE-END-DATE.
               10  MAST-MONTH-END        PIC 9(2).
               10  MAST-DAY-END          PIC 9(2).
               10  MAST-YEAR-END         PIC 9(4).
           05  MAST-RENTER-NAME-TABLE OCCURS 4 TIMES.
               10  MAST-RENTER-NAME      PIC X(15).
           05  MAST-NUM-OF-OCCUPANTS.
               10  MAST-NUM-OF-ADULTS    PIC 9.
               10  MAST-NUM-OF-MINORS    PIC 9.
           05  MAST-NUM-OF-PETS          PIC X.
           05  MAST-MONTHLY-RENT         PIC 9(4).
           05  MAST-RENT-PAYMENT-TABLE OCCURS 12 TIMES.
               10  MAST-TBL-RENT         PIC 9(4).


      *******************************************************************
      * The NEW-MASTER-FILE contains several records pertaining to the
      * business of ABC Properties Inc.  It's the updated version
      * of the Master-File.
      *******************************************************************
 
       FD  NEW-MASTER-FILE
           RECORD CONTAINS 142 CHARACTERS
           BLOCK CONTAINS 35 RECORDS
           RECORDING MODE IS F.

        
       01  NEW-MASTER-RECORD        PIC X(142).    


           

      ****************************************************************
      * TRAN-FILE contains all updates to be done to the master
      * file.
      ****************************************************************

       FD  TRAN-FILE
           RECORD CONTAINS 95 CHARACTERS           
           LABEL RECORDS ARE STANDARD
           RECORDING MODE IS F.
 
       01  DATE-RECORD.
           05  IN-FILL                 PIC X(5).
           05  IN-DATE.
               10  IN-MONTH            PIC 9(2).
               10  IN-DAY              PIC 9(2).
               10  IN-YEAR             PIC 9(4).
           05  IN-NAME                 PIC X(4).
           05  FILLER                  PIC X(78).

       01  TRAN-RECORD.
           05  TRAN-KEY.
               10  TRAN-BLD-ID           PIC X.
               10  TRAN-APT-NUM          PIC 9(3).

           05  TRAN-CODE                 PIC 9.
           05  TRAN-INFO                 PIC X(90).

           05  TRAN-ADD-INFO REDEFINES TRAN-INFO.
               10  TRAN-ADD-APT-HOUSE   PIC X(2).
               10  TRAN-ADD-NUM-OF-BED  PIC 9.
               10  TRAN-ADD-TOT-SQR-FT  PIC 9(4).
               10  TRAN-ADD-LEASE-START.
                   15  TRAN-ADD-MONTH-START  PIC 9(2).
                   15  TRAN-ADD-DAY-START    PIC 9(2).
                   15  TRAN-ADD-YEAR-START   PIC 9(4).
               10  TRAN-ADD-LEASE-END.
                   15  TRAN-ADD-MONTH-END   PIC 9(2).
                   15  TRAN-ADD-DAY-END     PIC 9(2).
                   15  TRAN-ADD-YEAR-END    PIC 9(4).
               10  RENTER-NAME-TABLE OCCURS 4 TIMES.
                   15  TRAN-ADD-RENTER-NAME PIC X(15).
               10  NUMBER-OF-OCCUPANTS.
                   15  TRAN-ADD-NUM-OF-ADULTS    PIC 9.
                   15  TRAN-ADD-NUM-OF-MINORS    PIC 9.
               10  TRAN-ADD-PETS                 PIC X.
               10  TRAN-ADD-MONTHLY-RENT         PIC 9(4).


           05  TRAN-ALTER-INFO REDEFINES TRAN-INFO.
               10  TRAN-ALTER-CODE     PIC 9(2).
               10  TRAN-ALTER-FIELD    PIC X(88).

               10  TRAN-ALTER-BEDROOM REDEFINES TRAN-ALTER-FIELD.
                   15  TRAN-ALTER-NUM-OF-BEDRMS  PIC 9.
                   15  FILLER                    PIC X(87).

               10  TRAN-ALTER-SQR-FT-TBL REDEFINES TRAN-ALTER-FIELD.
                   15  TRAN-ALTER-SQR-FT         PIC 9(4).
                   15  FILLER                    PIC X(84).

               10  TRAN-ALTER-START-DATES REDEFINES TRAN-ALTER-FIELD.
                   15  TRAN-ALTER-START-DATE.
                       20  TRAN-ALTER-MONTH-START PIC 9(2).
                       20  TRAN-ALTER-DAY-START   PIC 9(2).
                       20  TRAN-ALTER-YEAR-START  PIC 9(4).

                   15  FILLER                    PIC X(80).

               10  TRAN-ALTER-END-DATES REDEFINES TRAN-ALTER-FIELD.
                   15  TRAN-ALTER-END-DATE.
                       20  TRAN-ALTER-MONTH-END  PIC 9(2).
                       20  TRAN-ALTER-DAY-END    PIC 9(2).
                       20  TRAN-ALTER-YEAR-END   PIC 9(4).
                   15  FILLER                    PIC X(80).

               10  TRAN-ALTER-RENTERS-NAME REDEFINES TRAN-ALTER-FIELD.
                   15  TRAN-ALTER-RENTER-TABLE OCCURS 4 TIMES.
                       20  TRAN-ALTER-RENTER-NAME     PIC X(15).
                   15  FILLER                         PIC X(28).

               10  TRAN-ALTER-NUM-OF-OCCUPANTS REDEFINES
                   TRAN-ALTER-FIELD.
                   15  TRAN-ALTER-NUM-OF-ADULTS PIC 9.
                   15  TRAN-ALTER-NUM-OF-MINORS PIC 9.
                   15  FILLER                   PIC X(86).

               10  TRAN-ALTER-PETS REDEFINES TRAN-ALTER-FIELD.
                   15  TRAN-ALTER-NUM-OF-PETS   PIC X.
                   15  FILLER                  PIC X(87).

               10  TRAN-ALTER-RENT REDEFINES TRAN-ALTER-FIELD.
                   15  TRAN-ALTER-MONTHLY-RENT PIC 9(4).
                   15  FILLER                  PIC X(84).

               10  TRAN-ALTER-RENT-PAYMENT REDEFINES
                   TRAN-ALTER-FIELD.
                   15  TRAN-ALTER-PAYMENT-NUM  PIC 9(2).
                   15  TRAN-ALTER-AMT          PIC 9(4).
                   15  FILLER                  PIC X(82).

           05  TRAN-DELETE-INFO REDEFINES TRAN-INFO.
               10  TRAN-DELETE-BLANKS          PIC X(90).



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
      * VARIABLE DICTIONARY
      *
      * WORK-RECORD            Copy of Master file to be used in
      *                        Working Storage
      * HRD-FLAG               Header flag for the Transaction file
      * TRAN-EOF               Flag for Transaction file EOF.
      * EOF-FLAG               EOF flag for new-master file.
      * HEADER-ERROR-FLAG      Header flag for the Master file.
      * MASTER-EOF             EOF flag for the old master file.
      * MASTER-FLAG            flag that checks validity of record.
      * INVALID-ADD-FLAG       checks if record need to be added or not
      * HEADER                 moves my last name and formatted date to
      *                        appropriate variable.
      * CURRENT-KEY            stores Current Key
      * GOOD-ALT               counter for good Alters
      * GOOD-ADD               counter for good Adds
      * GOOD-DEL               counters for good deletes.
      * BAD-COUNT              Counters for transaction errors.
      * OLD-COUNT              counts # of records in old master.
      * NEW-COUNT              counts # of records written to new 
      *                        master.
      * PAGE-NUM               stores page #
      * LINE-COUNT             stores line count.
      * MY-DATE                stores current date
      * DASHED-LINE            dashed line
      * SUBSCRIPTS             Subscripts for subscritped table
      * DETAIL-TITLE1-2        Prints title.
      * DETAIL-HEADER1-2       Prints headers.
      * DETAIL-LINE1           Prints 1st line of detail.  aka
      *                        ap/tn, # of bedrms, lease date, etc.
      * DETAIL-LINE2-3         Pritns months and monthly rents.
      * DETAIL-LINE-ERR        Prints errors.
      * MY-MONTHS              variables to be redefined in temp-table
      * TEMP-TABLE             temp table to be moved to detail-line3
      * SUMMERY1               Prints 1st summery count of old and new
      *                        master file.
      * SUMMERY2               Prints remaining counts.
      *
      * SYSTEM-DATE-AND-TIME   Current system date and time.
      *******************************************************************
 

       01  WORK-RECORD.
           05  WORK-KEY.
               10  WORK-BULDING-ID       PIC X.
               10  WORK-APT-NUM          PIC 9(3).

           05  WORK-APT-TN               PIC X(2).
           05  WORK-NUM-OF-BED           PIC 9.
           05  WORK-TOT-SQR-FT           PIC 9(4).
           05  WORK-LEASE-START-DATE.
               10  WORK-MONTH-START      PIC 9(2).
               10  WORK-DAY-START        PIC 9(2).
               10  WORK-YEAR-START       PIC 9(4).
           05  WORK-LEASE-END-DATE.
               10  WORK-MONTH-END        PIC 9(2).
               10  WORK-DAY-END          PIC 9(2).
               10  WORK-YEAR-END         PIC 9(4).
           05  WORK-RENTER-NAME-TABLE OCCURS 4 TIMES.
               10  WORK-RENTER-NAME      PIC X(15).
           05  WORK-NUM-OF-OCCUPANTS.
               10  WORK-NUM-OF-ADULTS    PIC 9.
               10  WORK-NUM-OF-MINORS    PIC 9.
           05  WORK-NUM-OF-PETS          PIC X.
           05  WORK-MONTHLY-RENT         PIC 9(4).
           05  WORK-RENT-PAYMENT-TABLE OCCURS 12 TIMES.
               10  WORK-TBL-RENT         PIC 9(4).


       01  SYSTEM-DATE-AND-TIME.
           05  SYS-DATE             PIC X(6).
           05                       PIC X         VALUE SPACE.
           05  SYS-TIME             PIC X(8).
 
       01  FLAGS.
           05  HDR-FLAG             PIC X         VALUE 'N'.
           05  TRAN-EOF             PIC X         VALUE 'N'.
           05  EOF-FLAG             PIC X         VALUE 'N'.
           05  HEADER-ERROR-FLAG    PIC X         VALUE 'N'.
           05  MASTER-EOF           PIC X         VALUE 'N'.
           05  INVALID-ADD-FLAG     PIC X         VALUE 'N'.
           05  MASTER-FLAG          PIC X         VALUE 'N'.

       01  HEADER.
           05  HDR-FILL             PIC X(5)      VALUE SPACES.
           05  HDR-DATE.
               10  HDR-MONTH        PIC 9(2)      VALUE ZERO.
               10  HDR-DAY          PIC 9(2)      VALUE ZERO.
               10  HDR-YEAR         PIC 9(4)      VALUE ZERO.
           05  HDR-NAME             PIC X(4)      VALUE 'FACI'.



       01  CURRENT-KEY.
           05  CURR-BLD-ID      PIC X.
           05  CURR-APT-NUM     PIC 9(3).



       01  COUNTERS.
           05  GOOD-ALT             PIC 9(2)    VALUE ZERO.
           05  GOOD-ADD             PIC 9(2)    VALUE ZERO.
           05  GOOD-DEL             PIC 9(2)    VALUE ZERO.
           05  BAD-COUNT            PIC 9(2)    VALUE ZERO.
           05  OLD-COUNT            PIC 9(2)    VALUE ZERO.
           05  NEW-COUNT            PIC 9(2)    VALUE ZERO.



       01  VARS.
           05  MY-DATE.
               10  MY-YEAR          PIC 9(4).
               10  MY-MONTH         PIC 9(2).
               10  MY-DAY           PIC 9(2).
           05  PAGE-NUM             PIC 9(2)    VALUE ZERO.
           05  LINE-COUNT           PIC 9(2)    VALUE 99.
           05  COUNTER              PIC 9(2)    VALUE ZERO.
           05  DASHED-LINE          PIC X(132)  VALUE ALL '-'.


       01  SUBSCRIPTS.
           05  RENT-SUB                PIC 99         VALUE ZERO
                                       USAGE IS COMP.
           05  MONTH-SUB               PIC 99       USAGE IS COMP.
           05  NAME-SUB                PIC 99       USAGE IS COMP.

       01  DETAIL-TITLE1.
           05  DETT-DATE.
               10 MY-MONTH             PIC 9(2).
               10 FILLER               PIC X         VALUE '/'.
               10 MY-DAY               PIC 9(2).
               10 FILLER               PIC X         VALUE '/'.
               10 MY-YEAR              PIC 9(4)      VALUE ZERO.

           05  FILLER               PIC X(46)     VALUE SPACES.
           05  DET1-TITLE           PIC X(20)
               VALUE 'ABC PROPERTIES, INC.'.
           05  FILLER               PIC X(49)     VALUE SPACES.
           05  DET1-PAGE            PIC X(5)      VALUE 'PAGE '.
           05  DET1-PAGE-NUM        PIC 9(2)      VALUE ZERO.

       01  DETAIL-TITLE2.
           05  FILLER                  PIC X(54).
           05  DETT2-TITLE             PIC X(30)
               VALUE 'MASTER FILE UPDATE REPORT'.
           05  FILLER                  PIC X(48).

       01  DETAIL-HEADER1.
           05  DETH1-HD1               PIC X(10)
               VALUE 'TYPE OF'.
           05  FILLER                  PIC X(7)   VALUE SPACES.
           05  DETH1-HD2               PIC X(5)
               VALUE 'APT.'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH1-HD3               PIC X(5)
               VALUE 'AP/'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH1-HD4               PIC X(10)
               VALUE '# OF'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH1-HD5               PIC X(5)
               VALUE 'SQ.'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH1-HD6               PIC X(10)
               VALUE 'LEASE'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH1-HD7               PIC X(10)
               VALUE 'LEASE'.
           05  FILLER                  PIC X(47)   VALUE SPACES.


       01  DETAIL-HEADER2.
           05  DETH2-HD1               PIC X(12)
               VALUE 'TRANSACTION'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH2-HD2               PIC X(5)
               VALUE 'ID'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH2-HD3               PIC X(5)
               VALUE 'TN'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH2-HD4               PIC X(10)
               VALUE 'BEDROOMS.'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH2-HD5               PIC X(5)
               VALUE 'FT.'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH2-HD6               PIC X(10)
               VALUE 'START DATE'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH2-HD7               PIC X(10)
               VALUE 'END DATE'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH2-HD8               PIC X(10)
               VALUE 'ADULTS'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH2-HD9               PIC X(10)
               VALUE 'CHILDREN'.
           05  DETH2-HD10              PIC X(5)   VALUE 'PETS'.
           05  FILLER                  PIC X(5)   VALUE SPACES.
           05  DETH2-HD11              PIC X(5)   VALUE 'RENT'.

       01  DETAIL-LINE1.
           05  DET1-ADD                PIC X(4)    VALUE SPACES.
           05  DET1-ALTER              PIC X(4)    VALUE SPACES.
           05  DET1-DEL                PIC X(4)    VALUE SPACES.
           05  FILLER                  PIC X(4)    VALUE SPACE.
           05  DET1-KEY.
               10  DET1-APT            PIC X       VALUE SPACE.
               10  DET1-BLD-NUM        PIC ZZ9     VALUE ZERO.
           05  FILLER                  PIC X(7)    VALUE SPACES.
           05  DET1-AP-TN              PIC X(3)    VALUE ZERO.
           05  FILLER                  PIC X(10)   VALUE SPACES.
           05  DET1-NUM-BED            PIC 9       VALUE ZERO.
           05  FILLER                  PIC X(10)   VALUE SPACES.
           05  DET1-SQ-FT              PIC ZZZ9    VALUE ZERO.
           05  FILLER                  PIC X(7)    VALUE SPACES.
           05  DET1-START-DATE.
               10  DET1-ST-MONTH       PIC 99.
               10  FILLER              PIC X       VALUE '/'.
               10  DET1-ST-DAY         PIC 99.
               10  FILLER              PIC X       VALUE '/'.
               10  DET1-ST-YEAR        PIC 9(4).
           05  FILLER                  PIC X(6)    VALUE SPACES.
           05  DET1-END-DATE.
               10  DET1-END-MONTH      PIC 99.
               10  FILLER              PIC X       VALUE '/'.
               10  DET1-END-DAY        PIC 99.
               10  FILLER              PIC X       VALUE '/'.
               10  DET1-END-YEAR       PIC 9(4).
           05  FILLER                  PIC X(6)    VALUE SPACES.
           05  DET1-ADULTS             PIC 9       VALUE ZERO.
           05  FILLER                  PIC X(15)   VALUE SPACES.
           05  DET1-CHILDREN           PIC 9       VALUE ZERO.
           05  FILLER                  PIC X(7)    VALUE SPACES.
           05  DET1-PETS               PIC X       VALUE SPACE.
           05  FILLER                  PIC X(4)    VALUE SPACES.
           05  DET1-RENT               PIC $$,$$9  VALUE ZERO.




       01  DETAIL-LINE-ERR.
           05  DETR-ADD                PIC X(4)    VALUE SPACES.
           05  DETR-ALTER              PIC X(4)    VALUE SPACES.
           05  DETR-DEL                PIC X(4)    VALUE SPACES.
           05  FILLER                  PIC X(4)    VALUE SPACES.
           05  DETR-KEY.
               10  DETR-APT            PIC X       VALUE SPACE.
               10  DETR-BLD-NUM        PIC 999     VALUE ZERO.
           05  FILLER                  PIC X(9)    VALUE SPACES.
           05  DETR-ERROR              PIC X(111)  VALUE SPACES.


       01  MY-MONTHS.
           05  FILLER                  PIC X(3)    VALUE 'JAN'.
           05                          PIC X(3)    VALUE 'FEB'.
           05                          PIC X(3)    VALUE 'MAR'.
           05                          PIC X(3)    VALUE 'APR'.
           05                          PIC X(3)    VALUE 'MAY'.
           05                          PIC X(3)    VALUE 'JUN'.
           05                          PIC X(3)    VALUE 'JUL'.
           05                          PIC X(3)    VALUE 'AUG'.
           05                          PIC X(3)    VALUE 'SEP'.
           05                          PIC X(3)    VALUE 'OCT'.
           05                          PIC X(3)    VALUE 'NOV'.
           05                          PIC X(3)    VALUE 'DEC'.

       01  TEMP-TABLE REDEFINES MY-MONTHS.
           05  TEMP-MONTH  OCCURS 12 TIMES
                           PIC X(3).

       01  DETAIL-LINE2.
           05  FILLER                  PIC X(29)    VALUE SPACES.
           05  MONTHS-TABLE   OCCURS 12 TIMES.
               10  DET2-MONTH          PIC X(5).
               10  FILLER              PIC X(4).
               
       01  DETAIL-LINE3.
           05  FILLER                  PIC X(27)    VALUE SPACES.
           05  PAYMENT-TABLE   OCCURS 12 TIMES.
               10  DET3-PAY            PIC $$,$$9.
               10  FILLER              PIC X(3).

       01  SUMMERY1.
           05  FILLER                  PIC X(47)     VALUE SPACES.
           05  SUM1-NUM                PIC ZZ9.
           05  FILLER                  PIC X         VALUE SPACE.
           05  FILLER                  PIC X(15)
               VALUE 'RECORDS IN THE '.
           05  SUM1-FILE               PIC X(20)     VALUE SPACES.
           05  FILLER                  PIC X(46)     VALUE SPACES.

       01  SUMMERY2.
           05  FILLER                  PIC X(49)     VALUE SPACES.
           05  SUM2-NUM                PIC ZZ9.
           05  FILLER                  PIC X         VALUE SPACE.
           05  SUM2-HDR                PIC X(30)     VALUE SPACES.
           05  FILLER                  PIC X(50)     VALUE SPACES.


           EJECT
       PROCEDURE DIVISION.
 
      *******************************************************************
      * 000-MAIN obtains the system date and time, then calls a
      * subroutine to print it.  checks header of tran and mast files
      * i header is correct it does 200 'till eof = 'y'.  then it
      * prints the new-master-file.
      *******************************************************************
 
       000-MAIN.
 
          
           OPEN INPUT
                      MASTER-FILE
                      TRAN-FILE
                OUTPUT
                      NEW-MASTER-FILE
                      PRINT-FILE.


           ACCEPT SYS-DATE FROM DATE.
           ACCEPT SYS-TIME FROM TIME.


           PERFORM 050-CHECK-HEADER.
           PERFORM 060-CHECK-TRAN.

           IF HDR-FLAG = 'N' AND HEADER-ERROR-FLAG = 'N'

                READ MASTER-FILE
                     AT END MOVE 'Y' TO EOF-FLAG
                END-READ

                READ TRAN-FILE
                     AT END MOVE 'Y' TO EOF-FLAG
                END-READ
                
                PERFORM 100-CHOOSE-CURRENT-KEY
                
                PERFORM 550-DOPAGE

                PERFORM 200-PROCESS-ONE-KEY
                    UNTIL MASTER-EOF = 'Y'
                    AND TRAN-EOF      = 'Y'

           END-IF.


           ADD 1 TO PAGE-NUM.

           MOVE PAGE-NUM TO DET1-PAGE-NUM.
           MOVE '     UPDATE SUMMERY' TO DETT2-TITLE.
           WRITE PRINT-LINE FROM DETAIL-TITLE1
                 AFTER ADVANCING PAGE.
           WRITE PRINT-LINE FROM DETAIL-TITLE2.
                 



           PERFORM 700-PRINT-COUNT.

           CLOSE
                 MASTER-FILE
                 TRAN-FILE
                 NEW-MASTER-FILE
                 PRINT-FILE.

           OPEN INPUT NEW-MASTER-FILE
                OUTPUT PRINT-FILE.

           MOVE 'N' TO EOF-FLAG.

           ADD 1 TO PAGE-NUM.

           MOVE PAGE-NUM TO DET1-PAGE-NUM.
           MOVE 'NEW MASTER FILE RECORDS' TO DETT2-TITLE.
           WRITE PRINT-LINE FROM DETAIL-TITLE1
                 AFTER ADVANCING PAGE.
           WRITE PRINT-LINE FROM DETAIL-TITLE2.
           MOVE SPACES TO PRINT-LINE.
           WRITE PRINT-LINE.

           PERFORM 800-PRINT-RAW
                 UNTIL EOF-FLAG = 'Y'.


           CLOSE NEW-MASTER-FILE
                 PRINT-FILE.


           STOP RUN.
 
 
 
      *******************************************************************
      * 050-CHECK-HEADER checks master file header.
      * moves 'y' to header-error-flag if its corrupt.
      *******************************************************************
       050-CHECK-HEADER.

           READ MASTER-FILE
              AT END MOVE 'Y' TO MASTER-EOF
           END-READ.



           IF MASTER-EOF = 'Y'
              MOVE 'Y' TO HEADER-ERROR-FLAG
              DISPLAY 'Error:  Master File is Empty!!'

           ELSE
              IF
                 MAST-HDR-BLANKS IS NOT EQUAL TO SPACES OR
                 MAST-HDR-DATE IS NOT NUMERIC
                 DISPLAY 'MISSING OR INVALID MASTER HEADER'
                 MOVE 'Y' TO HEADER-ERROR-FLAG
              ELSE
                 MOVE 'FACI' TO MAST-HDR-NAME
              END-IF
           END-IF.


           WRITE PRINT-LINE FROM MAST-RECORD.
           EJECT
 
      *******************************************************************
      * 060-CHECK-TRAN checks if tran header is valid and isn't corrupt 
      * and moves 'y' to hdr-flag if its corrupt.
      *******************************************************************
       060-CHECK-TRAN.

           READ TRAN-FILE
                 AT END MOVE 'Y' TO TRAN-EOF
           END-READ.

           MOVE IN-DATE TO HDR-DATE.
           MOVE IN-FILL TO HDR-FILL.

           MOVE IN-MONTH TO MY-MONTH IN MY-DATE.
           MOVE IN-DAY   TO MY-DAY IN MY-DATE.
           MOVE IN-YEAR  TO MY-YEAR IN MY-DATE.
           MOVE 'FACI'   TO IN-NAME.

           MOVE CORR MY-DATE TO DETT-DATE.

           

           IF HDR-FILL NOT EQUAL TO SPACES
              DISPLAY 'ERROR ON BLANKS'
              MOVE 'Y' TO HDR-FLAG
           END-IF.

           IF HDR-DATE IS NOT NUMERIC
              DISPLAY 'ERROR NOT NUMERIC'
              MOVE 'Y' TO HDR-FLAG              
           END-IF.

           IF HDR-MONTH <= 0 OR HDR-MONTH > 12
              DISPLAY 'INVALID MONTH'
              MOVE 'Y' TO HDR-FLAG.

           IF HDR-DAY <= 0 OR HDR-DAY > 31
              MOVE 'Y' TO HDR-FLAG
              DISPLAY 'INVALIDE DAY'.


              WRITE PRINT-LINE FROM TRAN-RECORD.
              WRITE NEW-MASTER-RECORD FROM TRAN-RECORD.

           EJECT


      ***********************************************************
      * 100-CHOOSE-CURRENT-KEY compares current key to tran-key
      * and master-key and chooses the appropriate one depending
      * on value.
      ***********************************************************
       100-CHOOSE-CURRENT-KEY.

           IF MASTER-EOF = 'Y'
              MOVE TRAN-KEY TO CURRENT-KEY
           ELSE
             IF TRAN-EOF = 'Y'
               MOVE MASTER-KEY TO CURRENT-KEY
             ELSE
               IF TRAN-KEY < MASTER-KEY
                  MOVE TRAN-KEY TO CURRENT-KEY
               ELSE 
                  MOVE MASTER-KEY TO CURRENT-KEY
               END-IF
             END-IF
           END-IF.



           EJECT



      ***********************************************************
      * 200-PROCESS-ONE-KEY evaluates tran code, add, del or
      * alters depending on code.  then prints to screen to create
      * a report...and writes to new-master-file.
      ***********************************************************
       200-PROCESS-ONE-KEY.

           MOVE 'Y' TO MASTER-FLAG.

           IF LINE-COUNT > 20
              MOVE 99 TO LINE-COUNT
              PERFORM 550-DOPAGE
           END-IF.

           INITIALIZE DETAIL-LINE1.


           IF MASTER-KEY = CURRENT-KEY
              MOVE MAST-RECORD TO WORK-RECORD
              MOVE 'Y' TO MASTER-FLAG
              ADD 1 TO OLD-COUNT
              READ MASTER-FILE
                   AT END MOVE 'Y' TO MASTER-EOF
              END-READ
           ELSE
              MOVE 'N' TO MASTER-FLAG
           END-IF.

           MOVE 'N' TO INVALID-ADD-FLAG.

           
           PERFORM UNTIL TRAN-KEY NOT = CURRENT-KEY
                      OR TRAN-EOF = 'Y'
             EVALUATE TRAN-CODE
                    WHEN 1 PERFORM 300-ADD
                    WHEN 2 PERFORM 400-ALTER
                    WHEN 3 PERFORM 500-DEL
             END-EVALUATE



           IF INVALID-ADD-FLAG = 'N'
              READ TRAN-FILE
                   AT END MOVE 'Y' TO TRAN-EOF
              END-READ
           END-IF
           END-PERFORM.

           IF DET1-ADD NOT = SPACES OR DET1-ALTER NOT = SPACES OR
              DET1-DEL NOT = SPACES
              PERFORM 600-PRINT-DETAILS
           END-IF.


           IF MASTER-FLAG = 'Y'
              WRITE NEW-MASTER-RECORD FROM WORK-RECORD
              ADD 1 TO NEW-COUNT
           END-IF.
           

           PERFORM 100-CHOOSE-CURRENT-KEY.
           EJECT


      ***********************************************************
      * 300-ADD Adds a record the master file assuming the record
      *         doesn't exist already.
      ***********************************************************
       300-ADD.


           IF MASTER-FLAG = 'Y'
              ADD 1 TO BAD-COUNT
              MOVE 'Y' TO INVALID-ADD-FLAG
              MOVE 'ADD' TO DETR-ADD
              MOVE SPACES TO DETR-ALTER
              MOVE SPACES TO DETR-DEL
              MOVE '*** ' TO DETR-ERROR (1:4)
              MOVE 'INVALID ADD; KEY ALREADY IN MASTER FILE OR JUST'
                TO  DETR-ERROR (5:52)
              MOVE 'ADDED ***' TO DETR-ERROR (55:)

              MOVE TRAN-KEY TO DETR-KEY
              WRITE PRINT-LINE FROM DETAIL-LINE-ERR

              READ TRAN-FILE
                 AT END MOVE 'Y' TO TRAN-EOF
              END-READ

              PERFORM UNTIL TRAN-KEY NOT = CURRENT-KEY OR
                            TRAN-EOF = 'Y'

                  ADD 1 TO BAD-COUNT
                  MOVE SPACES TO DETR-DEL DETR-ALTER DETR-ADD
                  MOVE '*** ERROR:  FOLLOWS AN INVALID ADD ***'
                       TO DETR-ERROR
 
                  EVALUATE TRAN-CODE
                       WHEN 1 MOVE 'ADD' TO DETR-ADD
                       WHEN 2 MOVE 'ALT' TO DETR-ALTER
                       WHEN 3 MOVE 'DEL' TO DETR-DEL
                  END-EVALUATE

                  WRITE PRINT-LINE FROM DETAIL-LINE-ERR

                  READ TRAN-FILE
                       AT END MOVE 'Y' TO TRAN-EOF
                  END-READ

              END-PERFORM


           ELSE
              MOVE 'Y' TO MASTER-FLAG
              ADD 1 TO GOOD-ADD GIVING GOOD-ADD
              MOVE 'ADD' TO DET1-ADD
              MOVE TRAN-KEY TO WORK-KEY
              MOVE TRAN-ADD-APT-HOUSE TO WORK-APT-TN
              MOVE TRAN-ADD-NUM-OF-BED TO WORK-NUM-OF-BED
              MOVE TRAN-ADD-TOT-SQR-FT TO WORK-TOT-SQR-FT

              MOVE TRAN-ADD-MONTH-START TO WORK-MONTH-START
              MOVE TRAN-ADD-DAY-START   TO WORK-DAY-START
              MOVE TRAN-ADD-YEAR-START  TO WORK-YEAR-START

              MOVE TRAN-ADD-MONTH-END   TO WORK-MONTH-END
              MOVE TRAN-ADD-DAY-END     TO WORK-DAY-END
              MOVE TRAN-ADD-YEAR-END    TO WORK-YEAR-END


              PERFORM VARYING NAME-SUB FROM 1 BY 1
                      UNTIL NAME-SUB > 4

                      MOVE TRAN-ADD-RENTER-NAME (NAME-SUB) TO
                           WORK-RENTER-NAME (NAME-SUB)
              END-PERFORM

              MOVE TRAN-ADD-PETS TO WORK-NUM-OF-PETS
              MOVE TRAN-ADD-NUM-OF-MINORS TO WORK-NUM-OF-MINORS
              MOVE TRAN-ADD-NUM-OF-ADULTS TO WORK-NUM-OF-ADULTS
              MOVE TRAN-ADD-MONTHLY-RENT  TO WORK-MONTHLY-RENT

           END-IF.


       EJECT

      ***********************************************************
      * 400-ALTER - Alter a record in the master file...assuming
      *             the record does already exist.
      ***********************************************************
       400-ALTER.

           IF MASTER-FLAG = 'Y'
              ADD 1 TO GOOD-ALT

              EVALUATE TRAN-ALTER-CODE
                 WHEN 1
                     MOVE TRAN-ALTER-NUM-OF-BEDRMS TO
                     WORK-NUM-OF-BED
                 WHEN 2
                      MOVE TRAN-ALTER-SQR-FT TO
                      WORK-TOT-SQR-FT
                 WHEN 3
                      MOVE TRAN-ALTER-START-DATE TO
                           WORK-LEASE-START-DATE
                 WHEN 4
                      MOVE TRAN-ALTER-END-DATE TO
                           WORK-LEASE-END-DATE
                 WHEN 5
                      PERFORM VARYING NAME-SUB FROM 1 BY 1
                              UNTIL NAME-SUB > 4
                              
                           MOVE TRAN-ALTER-RENTER-TABLE (NAME-SUB) TO
                           WORK-RENTER-NAME-TABLE (NAME-SUB)

                      END-PERFORM
                      
                 WHEN 6
                      MOVE TRAN-ALTER-NUM-OF-ADULTS TO
                           WORK-NUM-OF-ADULTS
                      MOVE TRAN-ALTER-NUM-OF-MINORS TO
                           WORK-NUM-OF-MINORS
                 WHEN 7
                      MOVE TRAN-ALTER-NUM-OF-PETS TO
                           WORK-NUM-OF-PETS
                 WHEN 8
                      MOVE TRAN-ALTER-MONTHLY-RENT TO
                           WORK-MONTHLY-RENT
                 WHEN 9
                      MOVE TRAN-ALTER-AMT TO
                      WORK-TBL-RENT (TRAN-ALTER-PAYMENT-NUM)
              END-EVALUATE
          

              MOVE 'ALT' TO DET1-ALTER
    

           ELSE
              ADD 1 TO BAD-COUNT
              MOVE TRAN-KEY TO DETR-KEY
              MOVE 'ALT' TO DETR-ALTER
              MOVE SPACES TO DETR-ADD
              MOVE SPACES TO DETR-DEL
              MOVE '*** INVALID ALTER; KEY NOT IN MASTER FILE ***'
                   TO DETR-ERROR
              WRITE PRINT-LINE FROM DETAIL-LINE-ERR
           END-IF.
      *     DISPLAY CURRENT-KEY '   ' MASTER-FLAG.
       EJECT

      ***********************************************************
      * 500-DEL -- Deletes a record from the master file..assuming
      *            The record does exist.
      ***********************************************************
       500-DEL.

           IF MASTER-FLAG = 'N'
              ADD 1 TO BAD-COUNT
              MOVE 'DEL' TO DETR-DEL
              MOVE SPACES TO DETR-ALTER
              MOVE SPACES TO DETR-ADD
              MOVE TRAN-KEY TO DETR-KEY
              
              MOVE '*** ' TO DETR-ERROR (1:4)
              MOVE 'INVALID DELETE; KEY NOT IN MASTER FILE OR ALREADY'
                TO  DETR-ERROR (5:50)
              MOVE 'DELETED ***' TO DETR-ERROR (55:)
              WRITE PRINT-LINE FROM DETAIL-LINE-ERR
           ELSE
             MOVE 'N' TO MASTER-FLAG
             MOVE 'DEL' TO DET1-DEL
             ADD 1 TO GOOD-DEL
            END-IF.



       EJECT

      ***********************************************************
      * 550-DOPAGE -- Prints headers and takes care of page
      *               numbering.
      ***********************************************************
       550-DOPAGE.

           IF LINE-COUNT > 20
              ADD 1 TO PAGE-NUM
              MOVE PAGE-NUM TO DET1-PAGE-NUM
           END-IF.

           WRITE PRINT-LINE FROM DETAIL-TITLE1
                 AFTER ADVANCING PAGE.
           WRITE PRINT-LINE FROM DETAIL-TITLE2.
           WRITE PRINT-LINE FROM DETAIL-HEADER1.
           WRITE PRINT-LINE FROM DETAIL-HEADER2.
           WRITE PRINT-LINE FROM DASHED-LINE.
           MOVE 0 TO LINE-COUNT.

           EJECT


      ***********************************************************
      * 600-PRINT-DETAILS Prints details in a formatted output on
      *     the screen and moves work vars to detail vars.
      ***********************************************************
       600-PRINT-DETAILS.

           MOVE WORK-KEY TO DET1-KEY.
           MOVE WORK-APT-TN TO DET1-AP-TN.
           MOVE WORK-NUM-OF-BED TO DET1-NUM-BED.
           MOVE WORK-TOT-SQR-FT TO DET1-SQ-FT.

           MOVE WORK-MONTH-START TO DET1-ST-MONTH.
           MOVE WORK-DAY-START   TO DET1-ST-DAY.
           MOVE WORK-YEAR-START  TO DET1-ST-YEAR.

           MOVE WORK-MONTH-END TO DET1-END-MONTH.
           MOVE WORK-DAY-END   TO DET1-END-DAY.
           MOVE WORK-YEAR-END  TO DET1-END-YEAR.

           MOVE WORK-NUM-OF-ADULTS    TO DET1-ADULTS.
           MOVE WORK-NUM-OF-MINORS    TO DET1-CHILDREN.
           MOVE WORK-NUM-OF-PETS      TO DET1-PETS.
           MOVE WORK-MONTHLY-RENT     TO DET1-RENT.



           WRITE PRINT-LINE FROM DETAIL-LINE1
                 AFTER ADVANCING 2 LINES.

           PERFORM VARYING MONTH-SUB FROM 1 BY 1
                   UNTIL MONTH-SUB > 12
                   
                   MOVE TEMP-MONTH (MONTH-SUB) TO
                        DET2-MONTH (MONTH-SUB)
                   MOVE WORK-TBL-RENT (MONTH-SUB) TO
                        DET3-PAY (MONTH-SUB)
           END-PERFORM.

           WRITE PRINT-LINE FROM DETAIL-LINE2.
           WRITE PRINT-LINE FROM DETAIL-LINE3.

           ADD 3 TO LINE-COUNT.

           EJECT


      ***********************************************************
      * 700-PRINT-COUNT Prints summery counts and moves count vars
      *               to detail vars.
      ***********************************************************
       700-PRINT-COUNT.

           MOVE OLD-COUNT TO SUM1-NUM.
           MOVE 'OLD MASTER FILE' TO SUM1-FILE.
           WRITE PRINT-LINE FROM SUMMERY1
                 AFTER ADVANCING 2 LINES.

           MOVE NEW-COUNT TO SUM1-NUM.
           MOVE 'NEW MASTER FILE' TO SUM1-FILE.
           WRITE PRINT-LINE FROM SUMMERY1.


           MOVE GOOD-ADD TO SUM2-NUM.
           MOVE 'SUCCESSFUL ADDS' TO SUM2-HDR.
           WRITE PRINT-LINE FROM SUMMERY2
                 AFTER ADVANCING 2 LINES.

           MOVE GOOD-ALT TO SUM2-NUM.
           MOVE 'SUCCESSFUL ALTERS' TO SUM2-HDR.
           WRITE PRINT-LINE FROM SUMMERY2.

           MOVE GOOD-DEL TO SUM2-NUM.
           MOVE 'SUCCESSFUL DELETES' TO SUM2-HDR.
           WRITE PRINT-LINE FROM SUMMERY2.

           MOVE BAD-COUNT TO SUM2-NUM.
           MOVE 'TRANSACTION ERRORS' TO SUM2-HDR.
           WRITE PRINT-LINE FROM SUMMERY2.


           EJECT


      ***********************************************************
      * 800-PRINT-RAW Prints new-master file raw data.
      *               
      ***********************************************************
       800-PRINT-RAW.
           READ NEW-MASTER-FILE
                AT END MOVE 'Y' TO EOF-FLAG
           END-READ.

           IF EOF-FLAG NOT = 'Y'
              WRITE PRINT-LINE FROM NEW-MASTER-RECORD
           END-IF.



           EJECT




//GO.SYSOUT DD SYSOUT=*
//GO.OLDMAST DD DSN=T90ASS1.APT.MASTER,DISP=SHR
//GO.TRAN  DD DSN=T90ASS1.APT.TRAN(EDITED),DISP=SHR
//GO.NEWMAST  DD DSN=&&NEWMAST,UNIT=DISK,
//   SPACE=(TRK,(1,1)),VOL=SER=ACA302,DISP=(NEW,PASS)








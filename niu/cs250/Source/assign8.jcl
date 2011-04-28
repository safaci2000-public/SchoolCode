//Z002161A JOB ,'Samir Faci'
/*JOBPARM ROOM=161
//    EXEC IGYWCG,CPARM='FLAG(I,I),APOST,TEST(STMT)'
//COB.SYSIN DD *

      *******************************************************************
      * Module Name:   Assign8
      *
      * Function:      To validate data being read in and make sure it's
      *                not corrupt or dirty.
      *
      * Input:         raw uneditted transaction file.
      *
      * Output:        A report on successes and errors returned
      *                by the program.
      *
      * Notes:         None
      *******************************************************************
 
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  ASSIGN8.
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRAN-FILE ASSIGN TO S-TRAN.
           SELECT PRINT-FILE ASSIGN TO S-SYSOUT.
           SELECT EDITED-FILE ASSIGN TO S-EDITTRAN.


 
           EJECT

       DATA DIVISION.
 
       FILE SECTION.
 
      *******************************************************************
      * The TRAN-FILE contains several 95-character records.
      * Each record is validated to make sure it's not 'dirty'.
      *******************************************************************
 
       FD  TRAN-FILE
           RECORD CONTAINS 95 CHARACTERS
           RECORDING MODE IS F.
 
       01  DATE-RECORD.
           05  IN-FILL                 PIC X(5).
           05  IN-DATE                 PIC 9(8).
           05  FILLER                  PIC X(82).

       01  TRAN-RECORD.
           05  TRAN-APT-ID               PIC X(4).
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



      *******************************************************************
      * The EDITED-FILE is the cleaned up version of the tran-file.
      *******************************************************************
       FD  EDITED-FILE
           LABEL RECORDS ARE STANDARD
           BLOCK CONTAINS 40 RECORDS
           RECORDING MODE IS F.

       01  EDITED-RECORD               PIC X(95).
 
           EJECT

       WORKING-STORAGE SECTION.
 
      *******************************************************************
      * VARIABLE DICTIONARY
      *
      * SYSTEM-DATE-AND-TIME     Current system date and time.
      * EOF-FLAG                 Signals end of file.
      * DETAIL-TITLE1          Prints 1st line of title.
      * DETAIL-TITLE2          Prints second line of title.
      * DETAIL-HEADER1         Prints a title full of dots.
      * DETAIL-HEADER2         Prints number 1 through 9
      * DETAIL-HEADER3         prints a line of numbers starting w/ 6
      *                        ending w/ 0 and filling 132 character
      *                        positions.
      * VALID-TOTAL            Tracks # of valid records
      * INVALID-TOTAL          Tracks # of invalid records
      * RECORD-COUNT           # of Records.
      * HDR-FLAG               Header flag
      * MY-DATE                used to move into a formatted date.
      * HEADER                 Prints record date and my last name.
      * PAGE-COUNT             Counts # of pages.
      * LINE-COUNT             counts # of lines.
      * ERROR-COUNT            counts # of errors printed.
      * ERROR=SUB              keeps track to subscript.
      * DETAIL-LINE-ONE        prints errors in a formatted manner.
      * DETAIL-LINE-TWO        same as above.
      * DETAIL-LINE-THREE      same as above.
      * HEADER-RECORD          my last name and date.
      * ERROR-MSGS             Error MSGs.
      * ERROR-TABLE            Redefines above.
      *******************************************************************
 
       01  SYSTEM-DATE-AND-TIME.
           05  SYS-DATE             PIC X(6).
           05                       PIC X         VALUE SPACE.
           05  SYS-TIME             PIC X(8).
 
        01  VARS.
           05  VALID-TOTAL          PIC 9(3)      VALUE ZERO.
           05  INVALID-TOTAL        PIC 9(3)      VALUE ZERO.
           05  RECORD-COUNT         PIC 9(3)      VALUE ZERO.
           05  HDR-FLAG             PIC X         VALUE 'N'.
           05  MY-DATE.
               10  MY-YEAR          PIC 9(4).
               10  MY-MONTH         PIC 9(2).
               10  MY-DAY           PIC 9(2).


       01  EOF-FLAG                 PIC X         VALUE 'N'.

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
           05  DET1-PAGE-NUM        PIC 9(2)      VALUE 01.

       01  DETAIL-TITLE2.
           05  FILLER              PIC X(46).
           05  DET2-TITLE          PIC X(40)
               VALUE '  DATA VALIDATION EXCEPTION REPORT'.
           05  FILLER              PIC X(46).

       01  HEADER.
           05  HDR-FILL             PIC X(5)      VALUE SPACES.
           05  HDR-DATE.
               10  HDR-MONTH        PIC 9(2)      VALUE ZERO.
               10  HDR-DAY          PIC 9(2)      VALUE ZERO.
               10  HDR-YEAR         PIC 9(4)      VALUE ZERO.
           05  HDR-NAME             PIC X(4)      VALUE 'FACI'.
           

       01  COUNTERS.
           05  PAGE-COUNT           PIC 9(2)      VALUE ZERO.
           05  LINE-COUNT           PIC 9(2)      VALUE ZERO.
           05  ERROR-COUNT          PIC 9(2)      VALUE ZERO.
           05  ERROR-SUB            PIC 9(2)      VALUE ZERO
               USAGE IS COMP.


       01  DETAIL-HEADER1.
           05  FILLER               PIC X(16)  VALUE SPACES.
           05  DOTS1                PIC X(42)  VALUE ALL '.'.
           05  DETH-TITLE           PIC X(17)
               VALUE 'TRANSACTION DATA'.
           05  DOTS2                PIC X(57)  VALUE ALL '.'.

       01  DETAIL-HEADER2.
           05  DETH2-APT            PIC X(3)   VALUE 'APT'.
           05  FILLER               PIC X(5)   VALUE SPACES.
           05  DETH2-TRAN           PIC X(4)   VALUE 'TRAN'.
           05  FILLER               PIC X(12)  VALUE SPACES.
           05                       PIC X      VALUE '1'.
           05  FILLER               PIC X(12)  VALUE SPACES.
           05                       PIC X      VALUE '2'.
           05  FILLER               PIC X(12)  VALUE SPACES.
           05                       PIC X      VALUE '3'.
           05  FILLER               PIC X(12)  VALUE SPACES.
           05                       PIC X      VALUE '4'.
           05  FILLER               PIC X(12)  VALUE SPACES.
           05                       PIC X      VALUE '5'.
           05  FILLER               PIC X(12)  VALUE SPACES.
           05                       PIC X      VALUE '6'.
           05  FILLER               PIC X(12)  VALUE SPACES.
           05                       PIC X      VALUE '7'.
           05  FILLER               PIC X(12)  VALUE SPACES.
           05                       PIC X      VALUE '8'.
           05  FILLER               PIC X(12)  VALUE SPACES.
           05                       PIC X      VALUE '9'.

       01  DETAIL-HEADER3.
           05  DETH3-ID             PIC X(3)   VALUE 'ID '.
           05  FILLER               PIC X(5)   VALUE SPACES.
           05  DETH3-CODE           PIC X(4)   VALUE 'CODE'.
           05  FILLER               PIC X(4)   VALUE SPACES.
           05  FILLER               PIC X(116)
               VALUE ALL '6789012345'.
           
       01  DETAIL-LINE-ONE.
           05  DET1-APT-ID          PIC X(4)    VALUE SPACES.
           05                       PIC X(5)    VALUE SPACES.
           05  DET1-TRAN-CODE       PIC 9(2)    VALUE ZERO.
           05                       PIC X(9)    VALUE SPACES.
           05  DET1-ERROR-CODE      PIC X(90)    VALUE SPACES.

       01  DETAIL-LINE-TWO.
           05  FILLER               PIC X(20)   VALUE SPACES.
           05  DET2-ERRORS          PIC X(10)   VALUE 'ERROR(S):'.
           05  DET2-ERROR-LIST      PIC X(50)   VALUE SPACES.

       01  DETAIL-LINE-THREE.
           05  FILLER               PIC X(30)   VALUE SPACES.
           05  DET3-ERROR-LIST      PIC X(50)   VALUE SPACES.

       01  FINAL-LINE-ONE.
           05  FIN1-INPUT-TRANS     PIC X(80)
                  VALUE 'TOTAL NUMBER OF INPUT TRANSACTIONS: '.
           05  FIN1-INPUT-TRANS-NUM PIC 9(3)      VALUE ZERO.

       01  FINAL-LINE-TWO.
           05  FIN2-VALID-TRANS     PIC X(80)
                  VALUE 'NUMBER OF VALID TRANSACTIONS: '.
           05  FIN2-NUM-VALIDS      PIC 9(3)      VALUE ZERO.

       01  FINAL-LINE-THREE.
           05  FIN3-INVALID-TRANS   PIC X(80)
                  VALUE 'NUMBER OF INVALID TRANSACTIONS: '.
           05  FIN3-NUM-INVALIDS    PIC 9(3)       VALUE ZERO.


       01  HEADER-RECORD.
           05  FILLER               PIC X(5)       VALUE SPACES.
           05  HD-CREATION-DATE     PIC 9(8)       VALUE ZERO.
           05  HD-LAST-NAME         PIC X(20)      VALUE SPACES.
           05  FILLER               PIC X(62)      VALUE SPACES.



       01  ERROR-MSGS.

           05  FILLER              PIC X(50)
           VALUE 'Building ID is not Alphabetic'.

           05  FILLER               PIC X(50)
           VALUE 'Building ID is not A, B, C, or D'.

           05  FILLER              PIC X(50)
           VALUE 'Apartment number is not Numeric'.

           05  FILLER              PIC X(50)
           VALUE 'Apartment number is not greater then zero'.

           05  FILLER              PIC X(50)
           VALUE 'Transaction Code is not numeric'.

           05  FILLER              PIC X(50)
           VALUE 'Transaction Code is not 1, 2, or 3'.

           05  FILLER              PIC X(50)
           VALUE 'Alter Code is not numeric'.

           05  FILLER              PIC X(50)
           VALUE 'Alter Code is not in 1-9 range'.

           05  FILLER              PIC X(50)
           VALUE 'Apartment or Townhouse is not Alphabetic'.

           05  FILLER              PIC X(50)
           VALUE 'Apartment or Townhouse is not AP or TN'.

           05  FILLER              PIC X(50)
           VALUE 'Number of Bedroom is not numeric'.

           05  FILLER              PIC X(50)
           VALUE 'Number of Bedrooms is not in 0-3 range'.

           05  FILLER              PIC X(50)
           VALUE 'Total Square Feet not numeric'.

           05  FILLER              PIC X(50)
           VALUE 'Total Square Feet or not greater then zero'.

           05  FILLER              PIC X(50)
           VALUE 'Start date month not numeric'.

           05  FILLER              PIC X(50)
           VALUE 'Start date month not in 1-12 range'.

           05  FILLER              PIC X(50)
           VALUE 'Start date day not numeric'.

           05  FILLER              PIC X(50)
           VALUE 'Start date day not in 1-31 range'.

           05  FILLER              PIC X(50)
           VALUE 'Start date year not numeric'.

           05  FILLER              PIC X(50)
           VALUE 'Start date year not greater then zero'.

           05  FILLER              PIC X(50)
           VALUE 'End date month not numeric'.

           05  FILLER              PIC X(50)
           VALUE 'End date month not in 1-12 range'.

           05  FILLER              PIC X(50)
           VALUE 'End date day not numeric'.

           05  FILLER              PIC X(50)
           VALUE 'End date day not in 1-31 range'.

           05  FILLER              PIC X(50)
           VALUE 'End date year not numeric'.

           05  FILLER              PIC X(50)
           VALUE 'End year not greater then zero'.

           05  FILLER              PIC X(50)
           VALUE 'Renter Name doesnt have a max of one blank Entry'.

           05  FILLER              PIC X(50)
           VALUE 'Number of Adults not numeric'.

           05  FILLER              PIC X(50)
           VALUE 'Number of Adults not greater then zero'.

           05  FILLER              PIC X(50)
           VALUE 'Number of Children not numeric'.

           05  FILLER              PIC X(50)
           VALUE 'Pets not alphanumeric'.

           05  FILLER              PIC X(50)
           VALUE 'Pets not an N, C, D, or O'.

           05  FILLER              PIC X(50)
           VALUE 'Monthly rent not numeric'.

           05  FILLER              PIC X(50)
           VALUE 'Monthly rent not greater then zero'.

           05  FILLER              PIC X(50)
           VALUE 'Tran-Delete-Blanks not equal to spaces'.

           05  FILLER              PIC X(50)
           VALUE 'Payment Number is not Numeric'.

           05  FILLER              PIC X(50)
           VALUE 'Payment Number is not in the 1-12 range'.


       01  ERROR-TABLE REDEFINES ERROR-MSGS.
           05  ERROR-NAME          PIC X(50)  OCCURS 37 TIMES.

           EJECT
       PROCEDURE DIVISION.
 
      *******************************************************************
      * 000-MAIN obtains the system date and time, then calls a
      * subroutine to print it.  It reads the input record, then
      * calls a subroutine to print the detail lines until it reaches
      * the eof marker (aka eof-flag = 'y')
      *******************************************************************
 
       000-MAIN.
 
          
           OPEN  INPUT  TRAN-FILE
                 OUTPUT PRINT-FILE
                        EDITED-FILE.

           PERFORM 100-CHECK-HEADER.

           MOVE FUNCTION CURRENT-DATE TO MY-DATE IN VARS.

           MOVE MY-YEAR IN MY-DATE TO MY-YEAR IN DETT-DATE.
           MOVE MY-MONTH IN MY-DATE TO MY-MONTH IN DETT-DATE.
           MOVE MY-DAY IN MY-DATE TO MY-DAY IN DETT-DATE.


           ACCEPT SYS-DATE FROM DATE
           ACCEPT SYS-TIME FROM TIME

           WRITE PRINT-LINE FROM SYSTEM-DATE-AND-TIME.
           

           IF HDR-FLAG = 'N'



              PERFORM 700-PRINT-TITLE

              MOVE IN-DATE TO HD-CREATION-DATE



              READ TRAN-FILE
                 AT END MOVE 'Y' TO EOF-FLAG
              END-READ

              PERFORM 200-PROCESS-RECORD
                  UNTIL EOF-FLAG = 'Y'

              CLOSE EDITED-FILE
              OPEN INPUT EDITED-FILE

              MOVE RECORD-COUNT TO FIN1-INPUT-TRANS-NUM.
              MOVE VALID-TOTAL TO FIN2-NUM-VALIDS.
              MOVE INVALID-TOTAL TO  FIN3-NUM-INVALIDS.

              WRITE PRINT-LINE FROM FINAL-LINE-ONE
                  AFTER ADVANCING 2 LINES.
              WRITE PRINT-LINE FROM FINAL-LINE-TWO.
              WRITE PRINT-LINE FROM FINAL-LINE-THREE.

              PERFORM 800-PRINT-NEW-FILE


           END-IF.



           CLOSE TRAN-FILE
                 PRINT-FILE.

           STOP RUN.
 
 
 
      *******************************************************************
      * 100-PRINT-HEADER checks if header is valid and isn't corrupt and
      * moves 'y' to hdr-flag if its corrupt.
      *******************************************************************
 
       100-CHECK-HEADER.
 
           READ TRAN-FILE
                 AT END MOVE 'Y' TO EOF-FLAG
           END-READ.

           MOVE IN-DATE TO HDR-DATE.
           MOVE IN-FILL TO HDR-FILL.

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



           EJECT


      *******************************************************************
      * 200-PROCESS-RECORD processes the record, checks the building ID
      * and apartment number for validity, checks tran-code for validity
      * and calls the appropriate function depending on the value of
      * tran-code.
      *******************************************************************
 
       200-PROCESS-RECORD.

           MOVE 'N' TO HDR-FLAG.

           IF TRAN-APT-ID(1:1) IS NOT ALPHABETIC 

              MOVE 1 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           ELSE IF TRAN-APT-ID(1:1) NOT = 'A' AND TRAN-APT-ID(1:1)
              NOT = 'B' AND TRAN-APT-ID(1:1) NOT = 'C'
              AND NOT TRAN-APT-ID(1:1)  = 'D'

              MOVE 2 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           END-IF.

           IF TRAN-APT-ID(2:) IS NOT NUMERIC
              MOVE 3 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           ELSE IF TRAN-APT-ID(2:) NOT > ZERO

              MOVE 4 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           END-IF.

           IF TRAN-CODE IS NOT NUMERIC
              MOVE 5 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           ELSE IF TRAN-CODE NOT > 0 AND TRAN-CODE NOT < 3

              MOVE 6 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           ELSE

           EVALUATE TRAN-CODE
               WHEN 1
                  PERFORM 400-TRAN-ADD
               WHEN 2
                  PERFORM 500-TRAN-ALTER
               WHEN 3
                  PERFORM 600-TRAN-DELETE

           END-EVALUATE
           END-IF.

           MOVE 0 TO ERROR-COUNT.

           ADD 1 TO RECORD-COUNT GIVING RECORD-COUNT
           IF HDR-FLAG = 'N'
              ADD 1 TO VALID-TOTAL GIVING VALID-TOTAL
              WRITE EDITED-RECORD FROM TRAN-RECORD
           END-IF.

           READ TRAN-FILE
              AT END MOVE 'Y' TO EOF-FLAG.


           
           EJECT



      *******************************************************************
      * 300-PRINT-ERROR prints error, checks line count and calls
      * 700-PRINT-TITLE if criteria is met.  Increments page count
      * accordingly.
      *******************************************************************
 
       300-PRINT-ERROR.

           IF HDR-FLAG = 'N'

           MOVE 'Y' TO HDR-FLAG
           ADD 1 TO ERROR-COUNT

           IF LINE-COUNT >= 50
               PERFORM 700-PRINT-TITLE
           END-IF

           MOVE TRAN-APT-ID TO DET1-APT-ID
           MOVE TRAN-CODE TO DET1-TRAN-CODE
           MOVE TRAN-INFO TO DET1-ERROR-CODE

           ADD 2 TO LINE-COUNT GIVING LINE-COUNT

           IF ERROR-COUNT = 1
                 MOVE ERROR-NAME (ERROR-SUB) TO DET2-ERROR-LIST
                 WRITE PRINT-LINE FROM DETAIL-LINE-ONE
                 AFTER ADVANCING 2 LINES
                 WRITE PRINT-LINE FROM DETAIL-LINE-TWO AFTER
                 ADVANCING 1 LINE
                 ADD 1 TO INVALID-TOTAL
           ELSE
                 MOVE ERROR-NAME (ERROR-SUB) TO DET3-ERROR-LIST
                 WRITE PRINT-LINE FROM DETAIL-LINE-THREE
           END-IF


           END-IF.


           EJECT



      *******************************************************************
      * 400-TRAN-ADD checks record read in for validity and prints
      * errors if criteria isn't met.
      *******************************************************************
 
       400-TRAN-ADD.


           IF TRAN-ADD-APT-HOUSE NOT ALPHABETIC
              MOVE 9 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR

           ELSE IF TRAN-ADD-APT-HOUSE NOT = 'AP'
              AND TRAN-ADD-APT-HOUSE NOT = 'TN'

              MOVE 10 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           END-IF.

           IF TRAN-ADD-NUM-OF-BED NOT NUMERIC

              MOVE 11 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR

           ELSE IF TRAN-ADD-NUM-OF-BED  < 0 OR
              TRAN-ADD-NUM-OF-BED > 3

              MOVE 12 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           END-IF.

           IF TRAN-ADD-TOT-SQR-FT IS NOT NUMERIC
              MOVE 13 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR

           ELSE IF TRAN-ADD-TOT-SQR-FT IS NOT GREATER ZERO

              MOVE 14 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           END-IF.

           IF TRAN-ADD-MONTH-START NOT NUMERIC
              MOVE 15 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           ELSE IF TRAN-ADD-MONTH-START  > 12 OR
                   TRAN-ADD-MONTH-START  < 1

              MOVE 16 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           END-IF.

           IF TRAN-ADD-DAY-START NOT NUMERIC

              MOVE 17 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           ELSE IF TRAN-ADD-DAY-START  > 31 OR
                   TRAN-ADD-DAY-START  < 1

              MOVE 18 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           END-IF.

           IF TRAN-ADD-YEAR-START  NOT NUMERIC
              MOVE 19 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR

           ELSE IF TRAN-ADD-YEAR-START NOT > ZERO

              MOVE 20 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR

           END-IF.

           IF TRAN-ADD-MONTH-END IS NOT NUMERIC
              MOVE 21 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           ELSE IF TRAN-ADD-MONTH-END IS > 12 OR
                   TRAN-ADD-MONTH-END IS < 1

              MOVE 22 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           END-IF.

           IF TRAN-ADD-DAY-END  IS NOT NUMERIC
              MOVE 23 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           ELSE IF TRAN-ADD-DAY-END IS > 31 OR
                   TRAN-ADD-DAY-END IS < 1

              MOVE 24 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR

           END-IF.

           IF TRAN-ADD-YEAR-END  IS NOT NUMERIC
              MOVE 25 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           ELSE IF TRAN-ADD-YEAR-END IS NOT GREATER ZERO
              MOVE 26 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           END-IF.

           IF TRAN-ADD-RENTER-NAME (1) = SPACES

              MOVE 27 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR

           END-IF.

           IF TRAN-ADD-NUM-OF-ADULTS NOT NUMERIC

              MOVE 28 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           ELSE IF TRAN-ADD-NUM-OF-ADULTS NOT > 0

              MOVE 29 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           END-IF.

           IF TRAN-ADD-NUM-OF-MINORS NOT NUMERIC

              MOVE 30 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           END-IF.

           IF TRAN-ADD-PETS NOT ALPHABETIC
              MOVE 31 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR

           ELSE IF TRAN-ADD-PETS NOT  = 'N' AND
                   TRAN-ADD-PETS NOT = 'C' AND
                   TRAN-ADD-PETS NOT = 'D' AND
                   TRAN-ADD-PETS NOT = 'O'

              MOVE 32 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR

           END-IF.



           IF TRAN-ADD-MONTHLY-RENT NOT NUMERIC 

              MOVE 33 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR

           ELSE IF TRAN-ADD-MONTHLY-RENT NOT GREATER ZERO
              MOVE 34 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR

           END-IF.


           EJECT



      *******************************************************************
      * 500-TRAN-ALTER checks the alter-code for validity then does
      * different error check depending on alter-code.
      *******************************************************************
 
       500-TRAN-ALTER.


           IF TRAN-ALTER-CODE NOT NUMERIC
              MOVE 7 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           ELSE
              IF TRAN-ALTER-CODE < 1 OR > 9
                 MOVE 8 TO ERROR-SUB
                 PERFORM 300-PRINT-ERROR
              END-IF
           END-IF.


           EVALUATE TRAN-ALTER-CODE
             WHEN 1
                 IF TRAN-ALTER-NUM-OF-BEDRMS NOT NUMERIC
                     MOVE 11 TO ERROR-SUB
                     PERFORM 300-PRINT-ERROR
                 ELSE 

                     IF  TRAN-ALTER-NUM-OF-BEDRMS < 0 OR
                         TRAN-ALTER-NUM-OF-BEDRMS > 3
                         MOVE 12 TO ERROR-SUB
                         PERFORM 300-PRINT-ERROR
                     END-IF
                 END-IF
             WHEN 2
                 IF TRAN-ALTER-SQR-FT IS NOT NUMERIC
                    MOVE 13 TO ERROR-SUB
                    PERFORM 300-PRINT-ERROR
                 ELSE
                    IF TRAN-ALTER-SQR-FT IS NOT GREATER ZERO
                       MOVE 14 TO ERROR-SUB
                       PERFORM 300-PRINT-ERROR
                    END-IF
                 END-IF

             WHEN 3
                IF TRAN-ALTER-MONTH-START NOT NUMERIC
                   MOVE 15 TO ERROR-SUB
                   PERFORM 300-PRINT-ERROR
                ELSE
                   IF TRAN-ALTER-MONTH-START > 12 OR
                      TRAN-ALTER-MONTH-START < 1
                      MOVE 16 TO ERROR-SUB
                      PERFORM 300-PRINT-ERROR
                   END-IF
                END-IF

                IF TRAN-ALTER-DAY-START NOT NUMERIC
                   MOVE 17 TO ERROR-SUB
                   PERFORM 300-PRINT-ERROR
                ELSE
                   IF TRAN-ALTER-DAY-START > 31 OR
                      TRAN-ALTER-DAY-START < 1
                      MOVE 18 TO ERROR-SUB
                      PERFORM 300-PRINT-ERROR
                   END-IF
                END-IF

               IF TRAN-ALTER-YEAR-START  NOT NUMERIC
                  MOVE 19 TO ERROR-SUB
                  PERFORM 300-PRINT-ERROR
               ELSE
                  IF TRAN-ALTER-YEAR-START NOT > ZERO
                     MOVE 20 TO ERROR-SUB
                     PERFORM 300-PRINT-ERROR
                  END-IF
               END-IF

             WHEN 4
               IF TRAN-ALTER-MONTH-END IS NOT NUMERIC
                  MOVE 21 TO ERROR-SUB
                  PERFORM 300-PRINT-ERROR
               ELSE
                  IF  TRAN-ALTER-MONTH-END IS > 12 OR
                      TRAN-ALTER-MONTH-END IS < 1
                      MOVE 22 TO ERROR-SUB
                      PERFORM 300-PRINT-ERROR
                  END-IF
               END-IF

               IF TRAN-ALTER-DAY-END IS NOT NUMERIC
                  MOVE 23 TO ERROR-SUB
                  PERFORM 300-PRINT-ERROR
               ELSE
                  IF TRAN-ALTER-DAY-END IS > 31 OR
                     TRAN-ALTER-DAY-END IS < 1
                     MOVE 24 TO ERROR-SUB
                     PERFORM 300-PRINT-ERROR
                  END-IF
               END-IF

               IF TRAN-ALTER-YEAR-END IS NOT NUMERIC
                  MOVE 25 TO ERROR-SUB
                  PERFORM 300-PRINT-ERROR
               ELSE
                  IF TRAN-ALTER-YEAR-END IS NOT GREATER ZERO
                     MOVE 26 TO ERROR-SUB
                     PERFORM 300-PRINT-ERROR
                  END-IF
               END-IF

             WHEN 5
               IF TRAN-ALTER-RENTER-NAME (1) = SPACES
                  MOVE 27 TO ERROR-SUB
                  PERFORM 300-PRINT-ERROR
               END-IF

             WHEN 6
               IF TRAN-ALTER-NUM-OF-ADULTS NOT NUMERIC
                  MOVE 28 TO ERROR-SUB
                  PERFORM 300-PRINT-ERROR
              ELSE
                 IF TRAN-ALTER-NUM-OF-ADULTS <= 0
                    MOVE 29 TO ERROR-SUB
                    MOVE 0 TO ERROR-COUNT
                    PERFORM 300-PRINT-ERROR
                 END-IF
              END-IF

              IF TRAN-ALTER-NUM-OF-MINORS NOT NUMERIC
                 MOVE 30 TO ERROR-SUB
                 MOVE 0 TO ERROR-COUNT
                 PERFORM 300-PRINT-ERROR
              END-IF

             WHEN 7
              IF TRAN-ALTER-NUM-OF-PETS NOT ALPHABETIC
                 MOVE 31 TO ERROR-SUB
                 PERFORM 300-PRINT-ERROR
              ELSE
                 IF TRAN-ALTER-NUM-OF-PETS NOT  = 'N' AND
                    TRAN-ALTER-NUM-OF-PETS NOT = 'C' AND
                    TRAN-ALTER-NUM-OF-PETS NOT = 'D' AND
                    TRAN-ALTER-NUM-OF-PETS NOT = 'O'
                      MOVE 32 TO ERROR-SUB
                      PERFORM 300-PRINT-ERROR
                 END-IF
              END-IF

             WHEN 8
              IF TRAN-ALTER-MONTHLY-RENT NOT NUMERIC
                 MOVE 33 TO ERROR-SUB
                 PERFORM 300-PRINT-ERROR
              ELSE
                 IF TRAN-ALTER-MONTHLY-RENT NOT GREATER ZERO
                    MOVE 34 TO ERROR-SUB
                    PERFORM 300-PRINT-ERROR
                 END-IF
              END-IF

             WHEN 9
              IF TRAN-ALTER-AMT NOT NUMERIC 
                 MOVE 33 TO ERROR-SUB
                 PERFORM 300-PRINT-ERROR
              ELSE
                 IF TRAN-ALTER-AMT NOT GREATER ZERO
                    MOVE 34 TO ERROR-SUB
                    PERFORM 300-PRINT-ERROR
                 END-IF
              END-IF

              IF TRAN-ALTER-PAYMENT-NUM IS NOT NUMERIC
                 MOVE 36 TO ERROR-SUB
                 PERFORM 300-PRINT-ERROR
              ELSE
                 IF TRAN-ALTER-PAYMENT-NUM < 1 OR
                    TRAN-ALTER-PAYMENT-NUM > 12
                    MOVE 37 TO ERROR-SUB
                    PERFORM 300-PRINT-ERROR
                 END-IF
              END-IF
           END-EVALUATE.



           EJECT




      *******************************************************************
      * 600-TRAN-DELETE checks if line to be delete is only spaces.
      *  If it isn't then it prints an error.
      *******************************************************************
       600-TRAN-DELETE.

           IF TRAN-DELETE-BLANKS IS NOT EQUAL TO SPACES
              MOVE 35 TO ERROR-SUB
              PERFORM 300-PRINT-ERROR
           END-IF.


           EJECT


      *******************************************************************
      * 700-PRINT-TITLE Prints the title and page headers and increments
      * page numbering.
      *******************************************************************
 
       700-PRINT-TITLE.


           WRITE PRINT-LINE FROM DETAIL-TITLE1
                 AFTER ADVANCING PAGE.
           WRITE PRINT-LINE FROM DETAIL-TITLE2
                 AFTER ADVANCING 1 LINE.


           WRITE PRINT-LINE FROM DETAIL-HEADER1
                 AFTER ADVANCING 2 LINES.
           WRITE PRINT-LINE FROM DETAIL-HEADER2.
           WRITE PRINT-LINE FROM DETAIL-HEADER3.



           ADD 1 TO DET1-PAGE-NUM GIVING DET1-PAGE-NUM.
           MOVE 0 TO LINE-COUNT.


           EJECT

      *******************************************************************
      * 800-PRINT-NEW-FILE write the checked data to a new file aka
      * EDITED-FILE.
      *******************************************************************

       800-PRINT-NEW-FILE.

           MOVE 'N' TO EOF-FLAG.

           WRITE PRINT-LINE FROM SYSTEM-DATE-AND-TIME
                 AFTER ADVANCING PAGE.
           WRITE PRINT-LINE FROM DETAIL-TITLE1
                 AFTER ADVANCING PAGE.
           WRITE PRINT-LINE FROM DETAIL-TITLE2
                 AFTER ADVANCING 1 LINE.
           WRITE PRINT-LINE FROM HEADER
                 AFTER ADVANCING 1 LINE.


           PERFORM UNTIL EOF-FLAG = 'Y'
               READ EDITED-FILE
                  AT END MOVE 'Y' TO EOF-FLAG
               NOT AT END
                   WRITE PRINT-LINE FROM EDITED-RECORD
               END-READ
           END-PERFORM.


           EJECT


/*
//GO.SYSOUT DD SYSOUT=*
//GO.TRAN  DD DSN=T90ASS1.SPRING01.APT.TRAN(UNEDITED),DISP=SHR
//GO.EDITTRAN DD DSN=&&EDITED,UNIT=DISK,VOL=SER=ACA302,
//       SPACE=(TRK,(1,1)),DISP=(NEW,PASS)
//


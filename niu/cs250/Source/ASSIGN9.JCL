//Z002161A JOB ,'Samir Faci'
/*JOBPARM ROOM=161
//    EXEC IGYWCG,CPARM='FLAG(I,I),APOST,TEST(STMT)'
//COB.SYSIN DD *

      *******************************************************************
      * Module Name:   Assign9
      *
      * Function:      To Extract date from the master file and print
      *                A report on the extracted data.
      *
      * Input:         Master file and Parameter File.
      *
      * Output:        A report based on the extracted data.  If any
      *                Errors occured, the report will display them.
      *
      * Notes:         None
      *******************************************************************
 
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  ASSIGN9.
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT MASTER-FILE ASSIGN TO S-MASTER.
           SELECT PRINT-FILE  ASSIGN TO S-SYSOUT.
           SELECT PARM-FILE   ASSIGN TO S-PARM.
           SELECT EXTRACT-FILE ASSIGN TO S-EXTRACT.


 
           EJECT

       DATA DIVISION.
 
       FILE SECTION.
 
      *******************************************************************
      * The TRAN-FILE contains several 95-character records.
      * Each record is validated to make sure it's not 'dirty'.
      *******************************************************************
 
       FD  MASTER-FILE
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
           05  MAST-BULDING-ID           PIC X.
           05  MAST-APT-NUM              PIC 9(3).
           05  MAST-APT-TN               PIC X(2).
           05  MAST-NUM-OF-BED           PIC 9.
           05  MAST-TOT-SQR-FT           PIC 9(4).
           05  MAST-LEAST-START-DATE.
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

           

      ****************************************************************
      * PARM-FILE specifies parameters to match and processes and 
      * extracts the record depending on the parameters given.
      ****************************************************************

       FD  PARM-FILE
           LABEL RECORDS ARE STANDARD
           RECORDING MODE IS F.

       01  PARM-RECORD.
           05  PARM-AP-TN               PIC X(2).
           05  PARM-NUM-OF-BED          PIC 9.
           05  PARM-DAYS-LEASE-END      PIC 9(3).
           05  PARM-MONTHLY-RENT        PIC 9(4).
           05  FILLER                   PIC X(70).



      ****************************************************************
      * EXTRACT-FILE file which contains the extracted data from the 
      * master file.
      ****************************************************************

       FD  EXTRACT-FILE
           LABEL RECORDS ARE STANDARD
           BLOCK CONTAINS 20 RECORDS
           RECORDING MODE IS F.
           
       01  EXTRACT-HEADER.
           05  FILLER                   PIC X(23).
           05  EXT-HDR-NAME             PIC X(4).
           05  EXT-HDR-DATE             PIC 9(8).
           05  FILLER                   PIC X(59).

       01  EXTRACT-RECORD               PIC X(94).




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
      * SYSTEM-DATE-AND-TIME     Current system date and time.
      * EOF-FLAG                 Signals end of file.
      * DETAIL-TITLE1          Prints 1st line of title.
      * DETAIL-TITLE2          Prints second line of title.
      * DETAIL-HEADER1         Prints a title full of dots.
      * DETAIL-HEADER2         Prints number 1 through 9
      * DETAIL-HEADER3         prints a line of numbers starting w/ 6
      *                        ending w/ 0 and filling 132 character
      *                        positions.
      * MY-DATE2               used in date calculation/conversions
      * MY-DATE                used to move into a formatted date.
      * PAGE-NUM               counts # of pages.
      * VARS                   Everything else in Vars deals w/ date
      *                        calculations.
      * EOF-FLAG               EOF file marker
      * MASTER-EOF             Master file eof marker            
      * PARM-EOF               Parameter file eof marker
      * PARM-ERROR-FLAG        Parameter Error flag
      * HEADER-ERROR-FLAG      Header error flag
      * EXTRACT-FLAG           Extract header flag
      * EXTRACT-EOF            Extract EOF marker.
      * DETAIL-LINE1-4         1 through 4 prints the parameter summery
      * DETAIL-LINE5-7         Prints formatted output
      *******************************************************************
 
       01  SYSTEM-DATE-AND-TIME.
           05  SYS-DATE             PIC X(6).
           05                       PIC X         VALUE SPACE.
           05  SYS-TIME             PIC X(8).
 
        01  VARS.
           05  MY-DATE.
               10  MY-YEAR          PIC 9(4).
               10  MY-MONTH         PIC 9(2).
               10  MY-DAY           PIC 9(2).
           05  MY-DATE2.
               10  MY-YEAR2          PIC 9(4).
               10  MY-MONTH2         PIC 9(2).
               10  MY-DAY2           PIC 9(2).


           05  PAGE-NUM             PIC 9(2)    VALUE ZERO.

           05  END-COMP-DATE     PIC 9(8)    VALUE ZERO.
           05  BEGIN-COMP-DATE   PIC 9(8)    VALUE ZERO.
           05  BEGIN-TEMP.
               10 TEMP-YEAR     PIC 9(4).
               10 TEMP-MONTH    PIC 9(2).
               10  TEMP-DAY     PIC 9(2).

           05  INT-BEGIN-DATE        PIC 9(6)    VALUE ZERO.
           05  INT-END-DATE          PIC 9(6)    VALUE ZERO.
           05  LEASE-DATE.
               10  LEASE-DATE-YR     PIC 9(4).
               10  LEASE-DATE-MONTH  PIC 9(2).
               10  LEASE-DATE-DAY    PIC 9(2).
           05  LEASE-DATE2           PIC 9(8).

           05  INT-LEASE-DATE        PIC 9(6)    VALUE ZERO.
           05  COUNTER               PIC 9(2)    VALUE ZERO.



       01  SYS-FLAGS.
           05  EOF-FLAG                 PIC X         VALUE 'N'.
           05  MASTER-EOF               PIC X         VALUE 'N'.
           05  PARM-EOF                 PIC X         VALUE 'N'.
           05  PARM-ERROR-FLAG          PIC X         VALUE 'N'.
           05  HEADER-ERROR-FLAG        PIC X         VALUE 'N'.
           05  EXTRACT-FLAG             PIC X         VALUE 'N'.
           05  EXTRACT-EOF              PIC X         VALUE 'N'.


       01  SUBSCRIPTS.
           05  ERROR-SUB               PIC 99         VALUE ZERO
                                       USAGE IS COMP.

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

       01  DETAIL-LINE1.
           05  FILLER              PIC X(50)      VALUE SPACES.
           05  DET1-TITLE          PIC X(30)
               VALUE 'Apartment/Townhouse:  '.
           05  DET1-DATA           PIC X(10).
           05  FIILER              PIC X(50)      VALUE SPACES.

       01  DETAIL-LINE2.
           05  FILLER              PIC X(50)      VALUE SPACES.
           05  DET2-TITLE          PIC X(30)
               VALUE 'Bedroom: '.
           05  DET2-DATA           PIC 9(2)       VALUE ZERO.
           05  FILLER              PIC X(50)      VALUE SPACES.

       01  DETAIL-LINE3.
           05  FILLER              PIC X(50)      VALUE SPACES.
           05  DET3-TITLE          PIC X(30)
               VALUE 'Lease End Date:  '.
           05  DET3-DATA.
               10  DET3-MONTH      PIC 9(2).
               10  FILLER          PIC X          VALUE '/'.
               10  DET3-DAY        PIC 9(2).
               10  FILLER          PIC X          VALUE '/'.
               10  DET3-YEAR       PIC 9(4).
           05  FILLER              PIC X(49)      VALUE SPACES.

       01  DETAIL-LINE4.
           05  FILLER              PIC X(50)      VALUE SPACES. 
           05  DET4-TITLE          PIC X(30)
               VALUE 'Monthly Rent:  '.
           05  DOLLAR-SIGN             PIC X          VALUE '$'.
           05  DET4-DATA           PIC X(7)       VALUE SPACES.
               


       01  DETAIL-LINE5.
           05  FILLER              PIC X(5)       VALUE SPACES.
           05  DET5-HD1            PIC X(10)      VALUE 'APT ID'.
           05  FILLER              PIC X(5)       VALUE SPACES.
           05  DET5-HD2            PIC X(10)      VALUE 'APT/TN'.
           05  FILLER              PIC X(5)       VALUE SPACES.
           05  DET5-HD3            PIC X(10)      VALUE 'BEDROOMS'.
           05  FILLER              PIC X(5)       VALUE SPACES.
           05  DET5-HD4            PIC X(15)
               VALUE 'LEASE END DATE'.
           05  FILLER              PIC X(5)       VALUE SPACES.
           05  DET5-HD5            PIC X(25)
               VALUE 'MONTHLY RENT'.
           
       01  DETAIL-LINE6.
           05  FILLER              PIC X(5)       VALUE SPACES.
           05  DET6-BLD-ID         PIC X.
           05  DET6-APT-NUM        PIC 9(3).
           05  FILLER              PIC X(13)      VALUE SPACES.
           05  DET6-AP-TN          PIC X(2).
           05  FILLER              PIC X(15)      VALUE SPACES.
           05  DET6-BDRM-NUM       PIC 9.
           05  FILLER              PIC X(13)      VALUE SPACES.
           05  DET6-DATE.
               10  DET6-MONTH      PIC 9(2).
               10  FILLER          PIC X          VALUE '/'.
               10  DET6-DAY        PIC 9(2).
               10  FILLER          PIC X          VALUE '/'.
               10  DET6-YEAR       PIC 9(4).

           05  FILLER              PIC X(10)      VALUE SPACES.
           05  DET6-RENT           PIC $$$,$$9.

       01  DETAIL-LINE7.
           05  FILLER              PIC X(20)       VALUE SPACES.
           05  DET7-HDR            PIC X(50)
               VALUE 'TOTAL NUMBER OF APARTMENTS EXTRACTED: '.
           05  DET7-DATA           PIC 9(3)        VALUE ZERO.

           EJECT
       PROCEDURE DIVISION.
 
      *******************************************************************
      * 000-MAIN obtains the system date and time, then calls a
      * subroutine to print it.  It reads the input record, then
      * calls a subroutine to print the detail lines until it reaches
      * the eof marker (aka eof-flag = 'y')
      *******************************************************************
 
       000-MAIN.
 
          
           OPEN INPUT  MASTER-FILE
                       PARM-FILE
                OUTPUT EXTRACT-FILE PRINT-FILE.


           ACCEPT SYS-DATE FROM DATE.
           ACCEPT SYS-TIME FROM TIME.


           MOVE FUNCTION CURRENT-DATE TO MY-DATE IN VARS.
           MOVE CORR MY-DATE IN VARS TO DETT-DATE.


           PERFORM 100-CHECK-HEADER.
           PERFORM 200-GET-PARM.

           PERFORM 240-DO-DATE.
           PERFORM 250-PRINT-PARM.


           IF HEADER-ERROR-FLAG = 'N' AND PARM-ERROR-FLAG = 'N'

              READ MASTER-FILE
                 AT END MOVE 'Y' TO MASTER-EOF
              END-READ

              PERFORM 400-PRINT-DATE-TIME

              WRITE PRINT-LINE FROM DETAIL-LINE5

              PERFORM 500-PROCESS-ONE-RECORD
                  UNTIL MASTER-EOF = 'Y'

              CLOSE EXTRACT-FILE
              OPEN INPUT EXTRACT-FILE
           END-IF.

           MOVE COUNTER TO DET7-DATA.

           IF DET7-DATA NOT = 'ANY'
              MOVE ' ' TO DOLLAR-SIGN
           END-IF.

           WRITE PRINT-LINE FROM DETAIL-LINE7
                AFTER ADVANCING 2 LINES.

           IF PARM-ERROR-FLAG NOT = 'Y'
               READ EXTRACT-FILE
               PERFORM 600-PRINT-EXTRACT
                  UNTIL EXTRACT-EOF = 'Y'
           END-IF.


           CLOSE PRINT-FILE
                 MASTER-FILE
                 PARM-FILE.

           STOP RUN.
 
 
 
      *******************************************************************
      * 100-PRINT-HEADER checks if header is valid and isn't corrupt and
      * moves 'y' to hdr-flag if its corrupt.
      *******************************************************************
 
       100-CHECK-HEADER.

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
                 MOVE MAST-HDR-DATE TO EXT-HDR-DATE
                 WRITE EXTRACT-HEADER FROM MAST-HEADER-RECORD
              END-IF
           END-IF.
 

           EJECT


      *******************************************************************
      * 200-GET-PARM Reads parameter file...if it's empty then it 
      * displays an error message, if not...it runs a function that
      * checks validity of parameters.
      *******************************************************************
 
       200-GET-PARM.

           READ PARM-FILE
              AT END MOVE 'Y' TO PARM-EOF
           END-READ.

           IF PARM-EOF = 'Y'
              DISPLAY 'Parameter record is missing!!'
           ELSE
             PERFORM 300-CHECK-PARM
           END-IF.


       EJECT


      *******************************************************************
      * 240-DO-DATE converts date from date to int and back again
      * and moves to correct var.
      *******************************************************************
 
       240-DO-DATE.



           MOVE MAST-HDR-YEAR TO TEMP-YEAR.
           MOVE MAST-HDR-MONTH TO TEMP-MONTH.
           MOVE MAST-HDR-DAY TO TEMP-DAY.

           MOVE BEGIN-TEMP TO BEGIN-COMP-DATE.


           COMPUTE INT-BEGIN-DATE = FUNCTION INTEGER-OF-DATE
           (BEGIN-COMP-DATE).

           ADD PARM-DAYS-LEASE-END TO INT-BEGIN-DATE GIVING
           INT-END-DATE.

           COMPUTE END-COMP-DATE = FUNCTION DATE-OF-INTEGER
           (INT-END-DATE).


           EJECT




      *******************************************************************
      * 250-PRINT-PARM checks validity of some parameters and write
      * the parameter info in a nice format.
      *******************************************************************
 
       250-PRINT-PARM.

           IF PARM-AP-TN = SPACES
              MOVE 'EITHER' TO DET1-DATA
           ELSE
             MOVE PARM-AP-TN TO DET1-DATA
           END-IF.

           MOVE PARM-NUM-OF-BED TO DET2-DATA.

           MOVE END-COMP-DATE TO MY-DATE2.

           MOVE MY-MONTH2 TO DET3-MONTH.
           MOVE MY-DAY2   TO DET3-DAY.
           MOVE MY-YEAR2  TO DET3-YEAR.

             

           IF PARM-MONTHLY-RENT = 0
              MOVE 'ANY' TO DET4-DATA
           ELSE
              MOVE PARM-MONTHLY-RENT TO DET4-DATA
           END-IF.


           WRITE PRINT-LINE FROM DETAIL-TITLE1
                 AFTER ADVANCING 2 LINES.

           WRITE PRINT-LINE FROM DETAIL-LINE1.
           WRITE PRINT-LINE FROM DETAIL-LINE2.
           WRITE PRINT-LINE FROM DETAIL-LINE3.
           WRITE PRINT-LINE FROM DETAIL-LINE4.


           EJECT



      *******************************************************************
      * 300-GET-PARM checks validity of parameter records.
      *******************************************************************
 
       300-CHECK-PARM.

           MOVE SPACES TO PRINT-LINE.

      *     DISPLAY PARM-RECORD.

           IF PARM-AP-TN NOT EQUAL TO 'AP' AND NOT = 'TN' AND
              NOT = '  '
               MOVE 'Y' TO PARM-ERROR-FLAG
               DISPLAY 'Apartment/Townhouse indicator not AP or TN'
           END-IF.

           IF PARM-NUM-OF-BED < 0 OR > 3
               MOVE 'Y' TO PARM-ERROR-FLAG
               DISPLAY 'Number of Bedrooms not in 0-3 range'
           END-IF.

           IF PARM-DAYS-LEASE-END NOT NUMERIC
               MOVE 'Y' TO PARM-ERROR-FLAG
               DISPLAY 'Days to Lease End not numeric'
           END-IF.

           IF PARM-MONTHLY-RENT NOT NUMERIC
              MOVE 'Y' TO PARM-ERROR-FLAG
              DISPLAY 'Monthly rent not numeric'
           END-IF.


           EJECT
      *******************************************************************
      * 400-PRINT-DATE-TIME  Prints system date and time.
      *******************************************************************

       400-PRINT-DATE-TIME.

           WRITE PRINT-LINE FROM SYSTEM-DATE-AND-TIME
              AFTER ADVANCING 3 LINES.
           MOVE 1 TO PAGE-NUM.


           EJECT

      *******************************************************************
      * 500-PROCESS-ONE-RECORD checks if master record fits parameters
      * Prints data in correct format and write data to extract-record.
      *******************************************************************

       500-PROCESS-ONE-RECORD.

           MOVE 'Y' TO EXTRACT-FLAG.


           IF PARM-AP-TN  NOT = SPACES
              IF MAST-APT-TN NOT = PARM-AP-TN
                 MOVE 'N' TO EXTRACT-FLAG
              END-IF
           END-IF.


           IF MAST-NUM-OF-BED NOT = PARM-NUM-OF-BED
              MOVE 'N' TO EXTRACT-FLAG
           END-IF.


            MOVE MAST-YEAR-END   TO LEASE-DATE-YR.
            MOVE MAST-MONTH-END  TO LEASE-DATE-MONTH.
            MOVE MAST-DAY-END    TO LEASE-DATE-DAY.

            MOVE LEASE-DATE TO LEASE-DATE2.

            COMPUTE INT-LEASE-DATE = FUNCTION INTEGER-OF-DATE
                   (LEASE-DATE2).


           IF PARM-DAYS-LEASE-END NOT = 999
              IF (INT-LEASE-DATE >= INT-END-DATE) OR
                  (INT-END-DATE <= INT-BEGIN-DATE)
                  MOVE 'N' TO EXTRACT-FLAG
               END-IF
           END-IF.


           IF MAST-MONTHLY-RENT > PARM-MONTHLY-RENT
              MOVE 'N' TO EXTRACT-FLAG
           END-IF.


           IF EXTRACT-FLAG = 'Y'
              ADD 1 TO COUNTER GIVING COUNTER
              WRITE EXTRACT-RECORD FROM MAST-RECORD
              MOVE MAST-BULDING-ID    TO DET6-BLD-ID
              MOVE MAST-APT-NUM        TO DET6-APT-NUM
              MOVE MAST-APT-TN         TO DET6-AP-TN
              MOVE MAST-NUM-OF-BED     TO DET6-BDRM-NUM

              MOVE MAST-MONTH-END      TO DET6-MONTH
              MOVE MAST-DAY-END        TO DET6-DAY
              MOVE MAST-YEAR-END       TO DET6-YEAR

              MOVE MAST-MONTHLY-RENT   TO DET6-RENT
              WRITE PRINT-LINE FROM DETAIL-LINE6
           END-IF.


           READ MASTER-FILE
              AT END MOVE 'Y' TO MASTER-EOF
           END-READ.



           EJECT

      *******************************************************************
      * 600-PRINT-EXTRACT Prints the raw data extracted.
      *******************************************************************
 
       600-PRINT-EXTRACT.

           WRITE PRINT-LINE FROM EXTRACT-RECORD
                 AFTER ADVANCING 1 LINE.

           READ EXTRACT-FILE
              AT END MOVE 'Y' TO EXTRACT-EOF.



           EJECT



/*
//GO.SYSOUT DD SYSOUT=*

//GO.MASTER DD DSN=T90ASS1.SPRING01.APT.MASTER,DISP=SHR
//GO.PARM  DD DSN=T90ASS1.SPRING01.PARM(FOUR),DISP=SHR
//EXTRACT  DD DSN=&&EXT,UNIT=DISK,VOL=SER=ACA302,
//         SPACE=(TRK,(1,1)),DISP=(NEW,PASS)
//


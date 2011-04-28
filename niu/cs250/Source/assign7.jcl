//Z002161A JOB ,'Samir Faci'
/*JOBPARM ROOM=161
//    EXEC IGYWCG,CPARM='FLAG(I,I),APOST,TEST(STMT),SSRANGE'
//COB.SYSIN DD *
      ***************************************************************
      * Module Name:   Assign7
      *
      * Function:      Processes temperature data for selected
      *                cities.
      *
      * Input:         A file containing several records.
      *
      * Output:        A printed report with daily and weekly
      *                temperature readings.
      *
      * Notes:         None
      ***************************************************************
 
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  ASSIGN7.
 
 
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO S-SYSIN.
           SELECT PRINT-FILE ASSIGN TO S-SYSOUT.
 
           EJECT
       DATA DIVISION.
 
       FILE SECTION.
 
      ***************************************************************
      * The INPUT-FILE contains several 80-character records.
      * Each record contains the city name  
      ***************************************************************
 
       FD  INPUT-FILE
           RECORDING MODE IS F.
 
       01  INPUT-RECORD.

           05  IN-CITY-NAME               PIC X(15).
           05                             PIC X.
           05  IN-TEMP
               OCCURS 7 TIMES
               INDEXED BY IN-TEMP-NDX.
               10  IN-TB-TEMP             PIC S9(3)
                   SIGN IS LEADING SEPARATE.
           05  FILLER                     PIC X(36).


 
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
      * EOF-FLAG                 Signals end of file.
      * MY-DATE                  Formatted Date
      * DETAIL-TITLE             Prints the title, date and page #.
      * DETAIL-HEADERS1          Prints the headers of the table.
      * DETAIL-LINE-ONE          Prints the data (city name, 7 temps,
      *                          and weekly high temp).
      * DETAIL-LINE-TWO          Prints city name and mean
      *                          temperature.
      * DETAIL-LINE-ERR          Prints error when city is not found.
      * COUNTERS                 2 variables to store the avg temp
      *                          and max temp.
      * TABLES                   stores the citie names and avg. temps
      * 
      ***************************************************************
 
       01  SYSTEM-DATE-AND-TIME.
           05  SYS-DATE               PIC X(6).
           05                         PIC X           VALUE SPACE.
           05  SYS-TIME               PIC X(8).

       01  MY-DATE.
           05  MY-YEAR                PIC 9999.
           05  MY-MONTH               PIC 99.
           05  MY-DAY                 PIC 99.
 

       01  EOF-FLAG                   PIC X           VALUE 'N'.

       01  COUNTERS.
           05  AVG-TEMP               PIC S9(3)V9      VALUE ZERO.
           05  HIGH-TEMP              PIC S9(3)        VALUE ZERO.



       01  TABLES.
           05  CITIES-INDEXED         OCCURS 20 TIMES
                                      ASCENDING KEY TB-CITIES
                                      INDEXED BY CITY-NDX.
               10  TB-CITIES          PIC X(15)
                           VALUE 'ZZZZZZZZZZZZZZZ'.
               10  TB-AVG             PIC S999V9  VALUE ZERO.

       01  DETAIL-TITLE.
           05                         PIC X(2).
           05  MY-MONTH               PIC 99/.
           05  MY-DAY                 PIC 99/.
           05  MY-YEAR                PIC 9999.
           05                         PIC X(10)  VALUE SPACES.
           05  DETT-TITLE             PIC X(40)
                    VALUE 'WEEKLY TEMPERATURES IN SELECTED CITIES'.
           05                         PIC X(30)  VALUE SPACES.
           05  DETT-PAGE              PIC X(5)   VALUE 'PAGE '.
           05  DETT-PAGE-NUM          PIC 99     VALUE 01.

       01  DETAIL-HEADERS1.
           05                         PIC X(2)    VALUE SPACES.
           05  DETH-CIT-NAME          PIC X(9)    VALUE 'CITY NAME'.
           05                         PIC X(15)   VALUE SPACES.
           05  DETH-TEMPERATURES      PIC X(20)
                    VALUE 'DAILY HIGH TEMPS'.
           05                         PIC X(40)   VALUE SPACES.
           05  DETH-WK-HIGH           PIC X(15)
                    VALUE 'WEEKLY HIGH'.

       01  DETAIL-LINE-ONE.
           05                         PIC X(2)    VALUE SPACES.
           05  DET-CITY               PIC X(15)   VALUE SPACES.
           05                         PIC X(5)    VALUE SPACES.
           05  DET-TEMPS
               OCCURS 7 TIMES
               INDEXED BY ERR-NDX.

               10  DET-TEMP           PIC +++9    VALUE ZERO.
               10                     PIC X(5)    VALUE SPACES.
           05  DET-TEMP-HIGH          PIC +++9     VALUE ZERO.

       01  DETAIL-LINE-ERR.
           05                         PIC X(2)    VALUE SPACES.
           05  DETE-CITY              PIC X(15)   VALUE SPACES.
           05                         PIC X(5)    VALUE SPACES.
           05  DETE-TEMPS             PIC X(65)
                 VALUE '***ERROR:  CITY NOT FOUND!!!***'.
           05                         PIC X(5).



       01  DETAIL-LINE-TWO.
           05  FILLER                 PIC X(30)    VALUE SPACES.
           05  DET2-CITY              PIC X(15)    VALUE SPACES.
           05                         PIC X(10)    VALUE SPACES.
           05  DET2-TEMP              PIC ++9.99   VALUE ZERO.




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
           MOVE FUNCTION CURRENT-DATE TO MY-DATE.

           PERFORM 100-PRINT-HEADER.
 
           READ INPUT-FILE.

           MOVE MY-DAY IN MY-DATE TO MY-DAY IN DETAIL-TITLE.
           MOVE MY-YEAR IN MY-DATE TO MY-YEAR IN DETAIL-TITLE.
           MOVE MY-MONTH IN MY-DATE TO MY-MONTH IN DETAIL-TITLE.

           WRITE PRINT-LINE FROM DETAIL-TITLE
                  AFTER ADVANCING PAGE.

           WRITE PRINT-LINE FROM DETAIL-HEADERS1
                  AFTER ADVANCING 2 LINES.

           PERFORM 200-READ-CITY
                VARYING CITY-NDX FROM 1 BY 1
                UNTIL IN-CITY-NAME = '               '.



           READ INPUT-FILE.


           PERFORM 300-READ-TEMPS
                VARYING CITY-NDX FROM 1 BY 1
                UNTIL EOF-FLAG = 'Y'.

           MOVE 02 TO DETT-PAGE-NUM.

           MOVE '           MEAN TEMPERATURES' TO DETT-TITLE.
           WRITE PRINT-LINE FROM DETAIL-TITLE
                 AFTER ADVANCING PAGE.

           PERFORM 400-PRINT-FINAL-TABLE
                VARYING CITY-NDX FROM 1 BY 1
                UNTIL CITY-NDX > 20.


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
      * 200-MOVE moves city names to indexed table.
      ***************************************************************
       200-READ-CITY.
 

           MOVE IN-CITY-NAME TO TB-CITIES (CITY-NDX).


           READ INPUT-FILE.


           EJECT

      ***************************************************************
      * 300-READ-TEMPS reads the city name and places the temp in the
      *          appropriate spot in the table.
      ***************************************************************
       300-READ-TEMPS.

           SET IN-TEMP-NDX TO 1.
           SEARCH ALL CITIES-INDEXED

              AT END
                MOVE IN-CITY-NAME TO DETE-CITY

                WRITE PRINT-LINE FROM DETAIL-LINE-ERR
                      AFTER ADVANCING 2 LINE

                 WHEN TB-CITIES (CITY-NDX) = IN-CITY-NAME

                   COMPUTE HIGH-TEMP = FUNCTION MAX ( IN-TB-TEMP
                    (ALL))


                   COMPUTE AVG-TEMP = FUNCTION MEAN (IN-TB-TEMP
                   (ALL))

                  


                   PERFORM VARYING ERR-NDX FROM 1 BY 1
                           UNTIL ERR-NDX > 7
                       SET IN-TEMP-NDX TO ERR-NDX
                       MOVE IN-TB-TEMP (IN-TEMP-NDX)
                         TO DET-TEMP (ERR-NDX)
                   END-PERFORM


                   MOVE AVG-TEMP TO TB-AVG (CITY-NDX)
                   MOVE HIGH-TEMP TO DET-TEMP-HIGH
                   MOVE IN-CITY-NAME TO DET-CITY
                   

                   MOVE IN-CITY-NAME TO DET2-CITY
                   WRITE PRINT-LINE FROM DETAIL-LINE-ONE
                         AFTER ADVANCING 2 LINE



           END-SEARCH.


           READ INPUT-FILE
                AT END MOVE 'Y' TO EOF-FLAG.


           EJECT


      ***************************************************************
      * 400-PRINT-FINAL-TABLE prints city names and avg temperatures.
      *          
      ***************************************************************
       400-PRINT-FINAL-TABLE.

           PERFORM VARYING CITY-NDX FROM 1 BY 1
                   UNTIL CITY-NDX > 20 OR TB-CITIES
                   (CITY-NDX ) = ' '
              MOVE TB-CITIES (CITY-NDX) TO DET2-CITY
              MOVE TB-AVG (CITY-NDX) TO DET2-TEMP
              IF TB-AVG (CITY-NDX) NOT = 0
                  WRITE PRINT-LINE FROM DETAIL-LINE-TWO
                  AFTER ADVANCING 2 LINES
           END-PERFORM.



           EJECT

/*
//GO.SYSIN  DD DSN=T90ASS1.SPRING01.COBDATA(DATA07),DISP=SHR
//GO.SYSOUT DD SYSOUT=*
//


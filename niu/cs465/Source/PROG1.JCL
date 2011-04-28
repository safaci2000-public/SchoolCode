//Z002161A JOB ,'Samir Faci'
/*JOBPARM ROOM=161
//STEP1 EXEC IGYWCG,CPARM='FLAG(W,W),TEST,APOST,SSRANGE',
//    LPARM='MAP',GPARM='/TERMTHDACT(DUMP),CHECK(ON)'
//COB.SYSIN DD *
      *******************************************************************
      * Module Name:   Assign1                                          *
      *                                                                 *
      * Function:      This program produces a report, like everything  *
      *                other program we have ever written in cobol,     *
      *                which deals with the Tiddily-Winks Tournament.   *
      *                This program uses multidimensional tables as well*
      *                as different number formats.                     *
      *                                                                 *
      *                                                                 *
      * Input:        SOCREFILE and NAMEFILE.                           *
      *                                                                 *
      *                                                                 *
      * Output:        Formatted Report.                                *
      *                                                                 *
      * Notes:         Any numberic variable used for math that is not  *
      *                to be printed is Binary (COMP) any data that     *
      *                will be printed is of type Display               *
      *******************************************************************
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  ASSIGN1.
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRINT-FILE  ASSIGN      TO PRINTER.
           SELECT SCORE-FILE  ASSIGN      TO SCORE.
           SELECT NAME-FILE   ASSIGN      TO NAME.


 
           EJECT

       DATA DIVISION.
 
       FILE SECTION.

      ****************************************************************
      * SCORE-FILE contains date on the scores obtained by different 
      * schools.         
      ****************************************************************
       FD  SCORE-FILE
           RECORDING MODE IS F
           DATA RECORD IS SCORE-INFO.

       01  SCORE-INFO.
           05 WEEK-NUMBER              PIC 9  COMP.
           05 SCHOOL-NUMBER            PIC 9  COMP.
           05 WEEKLY-SCORES  OCCURS 4 TIMES.
              10 GAME-1                PIC 9(3) COMP.
              10 GAME-2                PIC 9(3) COMP.
              10 GAME-3                PIC 9(3) COMP.
              

      ****************************************************************
      * NAME-FILE contains info regarding school names and the team
      * names as well.   
      ****************************************************************
       FD  NAME-FILE
           RECORDING MODE IS F.

       01  NAME-INFO.
           05 SCHOOL-NAME              PIC X(20).
           05 TEAM-NAME OCCURS 4 TIMES PIC X(20).
       

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
      * VARS:                                                           *
      *   EOF-FLAG             marks the end of the input-file          *
      *   COUNT1/2             used in perform loops as well as used    *
      *                        to find location of highest scoring team/*
      *                        school.                                  *
      *   MAX-SCHOOL           stores highest scoring school score.     *
      *   MAX-SCL-LOCATION     stores highest scoring school location   *
      *                        in table.                                *
      *   MAX-TEAM             stores highest scoring team's score.     *
      *   MAX-TEAM-LOCATION1/2 stores highest scoring team's location   *
      *                        in table.                                *
      *                                                                 *
      * SYSTEM-DATE-AND-TIME   gets system dates and time.              *
      *                                                                 *
      * MY-DATE:               formatted date.                          *
      *   MY-MONTH             stores today's month                     *
      *   MY-DAY               stores today's day                       *
      *   MY-YEAR              stores today's year (y2k complaint 4 dig)*
      *                                                                 *
      * SCORE-TAB:             3D table to store score information on   *
      *                        the big 9 conference.                    *
      *   SCHOOL-TOTALS        weekly school totals (sum of all team    *
      *                                                scores for the wk*
      *   GAME1/2/3            score earned by each team on each of the *
      *                        three games played that week.            *
      *   TOT-WK-SCR           sum of the threes games played that week *
      *                                                                 *
      * TEAM-TAB:              2D table to store information about      *
      *                        school names, team names, and misc data  *
      *                        about 'em.                               *
      *   SCHOOL-FN-SCORES     sum of school scores over all of the     *
      *                        season.                                  *
      *   SCHOOL-AR-NAM        name of school                           *
      *   TEAM                 name of team                             *
      *   TEAM-TOT             total points earned by team over length  *
      *                        of season.                               *
      *   
      * DETAIL-TITLE*          prints title of reports generated.       *
      * DETAIL-HEADER*         prints headers of reports.               *
      * UNDER-SCORE            prints a line underlining the headers.   *
      * DETAIL-LINE*           prints the data in the reports.          *
      * FINAL-HEADER           prints the final summery's header        *
      * FINAL-DETAIL*          prints data for the final summery.       *
      *******************************************************************

       01  VARS.
           05 EOF-FLAG                 PIC X     VALUE 'N'.
           05  COUNT1                  PIC 9(3)  VALUE IS 0 COMP.
           05  COUNT2                  PIC 9(3)  VALUE IS 0 COMP.
           05  MAX-SCHOOL              PIC 9(4)  VALUE IS 0 COMP.
           05  MAX-TEAM                PIC 9(4)  VALUE IS 0 COMP.
           05  MAX-SCL-LOCATION        PIC 99    VALUE IS 0 COMP.
           05  MAX-TEAM-LOCATION       PIC 99    VALUE IS 0 COMP.
           05  MAX-TEAM-LOCATION2      PIC 99    VALUE IS 0 COMP.
           05  PAGE-NUM                PIC 99    VALUE IS 1.


       01  SYSTEM-DATE-AND-TIME.
           05  SYS-DATE             PIC X(8).
           05                       PIC X         VALUE SPACE.
           05  SYS-TIME             PIC X(8).


       01  MY-DATE.
           05  MY-MONTH                PIC 9(2)   VALUE IS 0.
           05                          PIC X      VALUE IS '/'.
           05  MY-DAY                  PIC 9(2)   VALUE IS 0.
           05                          PIC X      VALUE IS '/'.
           05  MY-YEAR                 PIC 9(4)   VALUE IS 0.


       01  SCORE-TAB.
           05  WEEK-SCORE              OCCURS 7 TIMES
                                       INDEXED BY WEEK-NDX.

               10  SCHOOL-SCORE        OCCURS 9 TIMES
                                       INDEXED BY SCL-NDX.

                   15  SCHOOL-TOTALS   PIC 9(5)   VALUE IS 0.

                   15  TEAM-SCORE      OCCURS 4 TIMES
                                       INDEXED BY TEAM-NDX.

                       20  GAME1        PIC 9(3) COMP.
                       20  GAME2        PIC 9(3) COMP.
                       20  GAME3        PIC 9(3) COMP.
                       20  TOT-WKSCR    PIC 9(5) COMP.


       01  TEAM-TAB.
           05  SCHOOL-NAM               OCCURS 9 TIMES
                                        INDEXED BY SCHOOL-NDX.

               10  SCHOOL-FN-SCORES     PIC 9(5)   VALUE IS 0.
               10  SCHOOL-AR-NAM        PIC X(20).

               10  TEAM-NAM             OCCURS 4 TIMES
                                        INDEXED BY TEAM-NAM-NDX.
                   15  TEAM             PIC X(20).
                   15  TEAM-TOT         PIC 9(5)    VALUE IS 0 COMP.


       01  DETAIL-TITLE.
           05                           PIC X(45)   VALUE IS SPACES.
           05                           PIC X(43)
               VALUE IS 'BIG 9 CONFERENCE TIDDILY-WINKS CHAMPIONSHIP'.
           05                           PIC X(44)   VALUE IS SPACES.

       01  DETAIL-TITLE2.
           05                           PIC X(45)   VALUE IS SPACES.
           05                           PIC X(43)
               VALUE IS 'WOODLANDS PLAZA HOTEL - FLAGSTAFF, ARIZONA '.
           05                           PIC X(44)   VALUE IS SPACES.

       01  DETAIL-TITLE3.
           05                           PIC X(45)   VALUE IS SPACES.
           05                           PIC X(43)
               VALUE IS '           WEEKLY TEAM TOTALS              '.
           05                           PIC X(44)   VALUE IS SPACES.


       01  DETAIL-HEADER.
           05                           PIC X(10)
                        VALUE IS ' WEEK     '.
           05                           PIC X(10) VALUE IS SPACES.
           05                           PIC X(20)
                        VALUE IS 'SCHOOL     '.
           05                           PIC X(10)  VALUE IS SPACES.
           05                           PIC X(15)
                        VALUE IS 'SCHOOL TOTAL  '.
           05                           PIC X(10)  VALUE IS SPACES.
           05                           PIC X(20)
                        VALUE IS 'TEAMS  '.
           05                           PIC X(20)
                        VALUE IS 'TEAM TOTALS'.
           05                           PIC X(10)   VALUE IS SPACES.
           05                           PIC X(5)    VALUE IS 'PAGE '.
           05 HDR-PAGE                  PIC 99      VALUE IS 1.
           

       01  UNDER-SCORE                  PIC X(110) VALUE ALL '-'.

       01  DETAIL-LINE1.
           05  DET1-WEEK                PIC Z9.
           05                           PIC X(18)   VALUE IS SPACES.
           05  DET1-SCHOOL              PIC X(20)   VALUE IS SPACES.
           05                           PIC X(10)   VALUE IS SPACES.
           05  DET1-SCH-TOT             PIC Z,ZZ9.
           05                           PIC X(15)   VALUE IS SPACES.
           05  DET1-TEAMS               PIC X(20)   VALUE IS SPACES.
           05                           PIC X(10)   VALUE IS SPACES.
           05  DET1-TEAM-TOT            PIC Z,ZZ9.

       01  DETAIL-LINE2.
           05                           PIC X(70)   VALUE IS SPACES.
           05  DET2-TEAMS               PIC X(20)   VALUE IS SPACES.
           05                           PIC X(10)   VALUE IS SPACES.
           05  DET2-TEAM-TOT            PIC Z,ZZ9.


       01  DETAIL-TITLE4.
           05                           PIC X(45)   VALUE IS SPACES.
           05                           PIC X(43)
               VALUE IS '              FINAL RESULTS          '.
           05                           PIC X(44)   VALUE IS SPACES.

       01  DETAIL-HEADER2.
           05                           PIC X(20)   VALUE IS 'SCHOOL'.
           05                           PIC X(10)   VALUE IS SPACES.
           05                           PIC X(20)
                        VALUE IS 'FINAL SCHOOL TOTALS'.
           05                           PIC X(10)   VALUE IS SPACES.
           05                           PIC X(20)   VALUE IS 'TEAMS'.
           05                           PIC X(10)   VALUE IS SPACES.
           05                           PIC X(20)
                        VALUE IS 'FINAL TEAM TOTAL'.
           05                           PIC X(10)   VALUE IS SPACES.
           05                           PIC X(5)    VALUE IS 'PAGE '.
           05 HDR2-PAGE                 PIC 99      VALUE IS 7.


       01  DETAIL-LINE3.
           05  DET3-SCHOOL              PIC X(20)    VALUE IS SPACES.
           05                           PIC X(10)    VALUE IS SPACES.
           05  DET3-SCH-TOT             PIC Z,ZZ9.
           05                           PIC X(25)    VALUE IS SPACES.
           05  DET3-TEAMS               PIC X(20)    VALUE IS SPACES.
           05                           PIC X(10)    VALUE IS SPACES.
           05  DET3-TEAM-TOT            PIC Z,ZZ9.

       01  DETAIL-LINE4.
           05                           PIC X(60)    VALUE IS SPACES.
           05  DET4-TEAMS               PIC X(20)    VALUE IS SPACES.
           05                           PIC X(10)    VALUE IS SPACES.
           05  DET4-TEAM-TOT            PIC Z,ZZ9.

       01  FINAL-HEADER.
           05                           PIC X(40)    VALUE SPACES.
           05                           PIC X(25)
                        VALUE IS 'HIGHEST SCORING SCHOOL'.
           05                           PIC X(5)     VALUE SPACES.
           05                           PIC X(10)    VALUE IS 'TOTAL'.
           05                           PIC X(30)   VALUE IS SPACES.
           05                           PIC X(5)    VALUE IS 'PAGE '.
           05 HDRF-PAGE                 PIC 99      VALUE IS 8.


       01  FINAL-DETAIL1.
           05                           PIC X(40)    VALUE IS SPACES.
           05 FDET1-SCHOOL              PIC X(20)    VALUE IS SPACES.
           05                           PIC X(10)    VALUE IS SPACES.
           05 FDET1-SCORE               PIC Z,ZZ9.

       01  FINAL-HEADER2.
           05                           PIC X(40)    VALUE IS SPACES.
           05                           PIC X(25)
                        VALUE IS 'HIGHEST SCORING TEAM'.
           05                           PIC X(5)     VALUE IS SPACES.
           05                           PIC X(10)    VALUE IS 'TOTAL'.

       01  FINAL-DETAIL2.
           05                           PIC X(40)     VALUE IS SPACES.
           05 FDET2-TEAM                PIC X(20)     VALUE IS SPACES.
           05                           PIC X(10)     VALUE IS SPACES.
           05 FDET2-SCORE               PIC Z,ZZ9.


           EJECT
       PROCEDURE DIVISION.
 
      *******************************************************************
      * 000-MAIN controls the flow of the program.                      *
      * calls 2 functions to read in data from 2 files after which it   *
      * calls 3 other functions that calculate misc info and prints     *
      * detailed reports.                                               *
      *******************************************************************
 
       000-MAIN.
 
          
           OPEN   INPUT  NAME-FILE
                  OUTPUT PRINT-FILE.

           MOVE FUNCTION CURRENT-DATE TO SYS-DATE.

           ACCEPT SYS-TIME FROM TIME.

           MOVE SYS-DATE (5:2) TO MY-MONTH.
           MOVE SYS-DATE (7:2) TO MY-DAY.
           MOVE SYS-DATE (1:4) TO MY-YEAR.

           ACCEPT SYS-DATE FROM DATE.

           WRITE PRINT-LINE FROM MY-DATE
           AFTER ADVANCING PAGE.


           READ NAME-FILE
               AT END MOVE 'Y' TO EOF-FLAG.

           PERFORM 100-READ-NAMES
               VARYING SCHOOL-NDX FROM 1 BY 1
               UNTIL EOF-FLAG = 'Y'.
           
           CLOSE NAME-FILE.

           OPEN INPUT SCORE-FILE.

           MOVE 'N' TO EOF-FLAG.

           READ SCORE-FILE
               AT END MOVE 'Y' TO EOF-FLAG.

           PERFORM 200-READ-SCORES
               UNTIL EOF-FLAG = 'Y'.

           WRITE PRINT-LINE FROM DETAIL-TITLE.
           WRITE PRINT-LINE FROM DETAIL-TITLE2.
           WRITE PRINT-LINE FROM DETAIL-TITLE3.
           WRITE PRINT-LINE FROM DETAIL-HEADER
                 AFTER ADVANCING 2 LINES.
           WRITE PRINT-LINE FROM UNDER-SCORE.


           PERFORM 300-DO-WEEK-REPORT VARYING
                COUNT1 FROM 1 BY 1
                UNTIL COUNT1 > 7.


           WRITE PRINT-LINE FROM DETAIL-TITLE
                 AFTER ADVANCING PAGE.
           WRITE PRINT-LINE FROM DETAIL-TITLE2.
           WRITE PRINT-LINE FROM DETAIL-TITLE4.
           WRITE PRINT-LINE FROM DETAIL-HEADER2
                 AFTER ADVANCING 2 LINES.
           WRITE PRINT-LINE FROM UNDER-SCORE.

           PERFORM 400-DO-FINAL-REPORT.

           PERFORM 500-DO-SUMMERY.


           CLOSE SCORE-FILE
                 PRINT-FILE.


           STOP RUN.

      ***********************************************************
      * 100-READ-NAMES  Reads the school names and team names
      * into a muti-demensional table.  on eof, it moves 'y'
      * to eof-flag variable.
      ***********************************************************
       100-READ-NAMES.

           MOVE SCHOOL-NAME TO SCHOOL-AR-NAM(SCHOOL-NDX).


           PERFORM VARYING  COUNT1 FROM 1 BY 1
                    UNTIL COUNT1 > 4
                SET TEAM-NAM-NDX TO COUNT1
           MOVE  TEAM-NAME (COUNT1) TO TEAM(SCHOOL-NDX, TEAM-NAM-NDX)
           END-PERFORM.

           READ NAME-FILE
               AT END MOVE 'Y' TO EOF-FLAG.


           EJECT

      ***********************************************************
      * 200-READ-SCORES Reads the misc scores from the SCORE-   *
      * FILE and inserts them into a muti-dimensional table.    *
      * It also computes the weekly score totals.               *
      ***********************************************************
       200-READ-SCORES.

           
           SET WEEK-NDX TO WEEK-NUMBER.
           SET SCL-NDX TO SCHOOL-NUMBER.

           PERFORM VARYING COUNT1 FROM 1 BY 1
                   UNTIL COUNT1 > 4
              SET TEAM-NDX TO COUNT1

              MOVE GAME-1 (COUNT1) TO GAME1 (WEEK-NDX,
                                          SCL-NDX, TEAM-NDX)
              MOVE GAME-2 (COUNT1) TO GAME2 (WEEK-NDX,
                                          SCL-NDX, TEAM-NDX)
              MOVE GAME-3 (COUNT1) TO GAME3 (WEEK-NDX,
                                          SCL-NDX, TEAM-NDX)
              
              COMPUTE TOT-WKSCR (WEEK-NDX, SCL-NDX, TEAM-NDX) =
                 GAME1 (WEEK-NDX, SCL-NDX, TEAM-NDX) +
                 GAME2 (WEEK-NDX, SCL-NDX, TEAM-NDX) +
                 GAME3 (WEEK-NDX, SCL-NDX, TEAM-NDX)


           END-PERFORM.

           READ SCORE-FILE
               AT END MOVE 'Y' TO EOF-FLAG.


           EJECT

      ***********************************************************
      * 300-DO-WEEK-REPORT generates the weekly reports for     *
      * each school in the big 9 conference.                    *
      ***********************************************************
       300-DO-WEEK-REPORT.

           MOVE COUNT1 TO DET1-WEEK.
           SET WEEK-NDX TO COUNT1.

           PERFORM VARYING SCL-NDX FROM 1 BY 1
                   UNTIL SCL-NDX > 9

               SET SCHOOL-NDX TO SCL-NDX
               MOVE SCHOOL-AR-NAM (SCHOOL-NDX) TO DET1-SCHOOL

               PERFORM VARYING TEAM-NDX FROM 1 BY 1
                       UNTIL TEAM-NDX > 4

                  

                  COMPUTE SCHOOL-TOTALS (WEEK-NDX, SCL-NDX) =
                     SCHOOL-TOTALS (WEEK-NDX, SCL-NDX) +
                     TOT-WKSCR (WEEK-NDX, SCL-NDX, TEAM-NDX)


               END-PERFORM

               MOVE SCHOOL-TOTALS(WEEK-NDX, SCL-NDX)
                                TO DET1-SCH-TOT
               MOVE TEAM ( SCHOOL-NDX , 1 )  TO DET1-TEAMS
              

               MOVE TOT-WKSCR(WEEK-NDX, SCL-NDX, 1)
                        TO DET1-TEAM-TOT


               WRITE PRINT-LINE FROM DETAIL-LINE1
                        AFTER ADVANCING 2 LINE

               PERFORM VARYING TEAM-NAM-NDX FROM 2 BY 1
                       UNTIL TEAM-NAM-NDX > 4

                  SET TEAM-NDX TO TEAM-NAM-NDX
                  MOVE TOT-WKSCR (WEEK-NDX, SCL-NDX, TEAM-NDX)
                       TO DET2-TEAM-TOT
                  MOVE TEAM (SCHOOL-NDX, TEAM-NAM-NDX) TO DET2-TEAMS
                  WRITE PRINT-LINE FROM DETAIL-LINE2

               END-PERFORM

           END-PERFORM.

           IF (WEEK-NDX NOT EQUAL TO 7)

             ADD 1 TO PAGE-NUM
             MOVE PAGE-NUM TO HDR-PAGE
             WRITE PRINT-LINE FROM DETAIL-TITLE
                 AFTER ADVANCING PAGE
             WRITE PRINT-LINE FROM DETAIL-TITLE2
             WRITE PRINT-LINE FROM DETAIL-TITLE3
             WRITE PRINT-LINE FROM DETAIL-HEADER
                AFTER ADVANCING 2 LINES
             WRITE PRINT-LINE FROM UNDER-SCORE
           END-IF.


           EJECT

      ***********************************************************
      * 400-DO-FINAL-REPORT does the final reports for the      *
      * season and accumulates school totals over length of     *
      * season as well as overall team totals over duration of  *
      * the season.                                             *
      ***********************************************************
       400-DO-FINAL-REPORT.


           PERFORM VARYING COUNT1 FROM 1 BY 1
                   UNTIL COUNT1 > 9

               SET SCL-NDX TO COUNT1
               SET SCHOOL-NDX TO COUNT1

               PERFORM VARYING WEEK-NDX FROM 1 BY 1
                       UNTIL WEEK-NDX > 7

                   COMPUTE SCHOOL-FN-SCORES (SCHOOL-NDX) =
                         SCHOOL-FN-SCORES (SCHOOL-NDX) +
                         SCHOOL-TOTALS ( WEEK-NDX, SCL-NDX )

               END-PERFORM

            END-PERFORM.

            PERFORM VARYING TEAM-NAM-NDX FROM 1 BY 1
                    UNTIL TEAM-NAM-NDX > 4
              PERFORM VARYING SCL-NDX FROM 1 BY 1
                      UNTIL SCL-NDX > 9
                 SET SCHOOL-NDX TO SCL-NDX

                 PERFORM VARYING WEEK-NDX FROM 1 BY 1
                         UNTIL WEEK-NDX > 7

                     SET TEAM-NDX TO TEAM-NAM-NDX

                     COMPUTE TEAM-TOT (SCHOOL-NDX, TEAM-NAM-NDX) =
                             TEAM-TOT (SCHOOL-NDX, TEAM-NAM-NDX) +
                             TOT-WKSCR (WEEK-NDX, SCL-NDX,
                                         TEAM-NDX)
                     
                 END-PERFORM

              
              END-PERFORM
           END-PERFORM.


           PERFORM VARYING SCL-NDX FROM 1 BY 1
                   UNTIL SCL-NDX > 9
             SET SCHOOL-NDX TO SCL-NDX
             MOVE SCHOOL-AR-NAM (SCHOOL-NDX) TO DET3-SCHOOL
             MOVE SCHOOL-FN-SCORES (SCHOOL-NDX) TO DET3-SCH-TOT
             MOVE TEAM (SCHOOL-NDX, 1) TO DET3-TEAMS
             MOVE TEAM-TOT (SCHOOL-NDX, 1) TO DET3-TEAM-TOT

             WRITE PRINT-LINE FROM DETAIL-LINE3
                   AFTER ADVANCING 2 LINES

             PERFORM VARYING TEAM-NAM-NDX FROM 2 BY 1
                       UNTIL TEAM-NAM-NDX > 4

                
                MOVE TEAM (SCHOOL-NDX, TEAM-NAM-NDX) TO DET4-TEAMS
                MOVE TEAM-TOT (SCHOOL-NDX, TEAM-NAM-NDX)
                        TO DET4-TEAM-TOT

                WRITE PRINT-LINE FROM DETAIL-LINE4
             END-PERFORM

           END-PERFORM.

           EJECT


      ***********************************************************
      * 500-DO-SUMMERY searches and finds the school with the   *
      * highest score span of the season as well as the team    *
      * with the highest score over the length of the season.   *
      ***********************************************************
       500-DO-SUMMERY.     

           MOVE 0 TO COUNT2.

           PERFORM VARYING COUNT1 FROM 1 BY 1
                   UNTIL COUNT1 > 9

               SET SCL-NDX TO COUNT1
               SET SCHOOL-NDX TO COUNT1

               ADD 1 TO COUNT2
               IF SCHOOL-FN-SCORES (SCHOOL-NDX) > MAX-SCHOOL
                  MOVE COUNT2 TO MAX-SCL-LOCATION
                  MOVE SCHOOL-FN-SCORES (SCHOOL-NDX) TO MAX-SCHOOL
               END-IF

            END-PERFORM.



           MOVE 0 TO COUNT2.
           MOVE 0 TO COUNT1.

           PERFORM VARYING SCHOOL-NDX FROM 1 BY 1
                   UNTIL SCHOOL-NDX > 9

               ADD 1 TO COUNT2
               MOVE 0 TO COUNT1
               PERFORM VARYING TEAM-NAM-NDX FROM 1 BY 1
                       UNTIL TEAM-NAM-NDX > 4
                  ADD 1 TO COUNT1

               IF TEAM-TOT (SCHOOL-NDX, TEAM-NAM-NDX) > MAX-TEAM
                  MOVE COUNT1 TO MAX-TEAM-LOCATION2
                  MOVE COUNT2 TO MAX-TEAM-LOCATION
                  MOVE TEAM-TOT (SCHOOL-NDX, TEAM-NAM-NDX)
                                TO MAX-TEAM
               END-IF
               END-PERFORM
            END-PERFORM.




           SET SCHOOL-NDX TO MAX-TEAM-LOCATION.
           SET TEAM-NAM-NDX TO MAX-TEAM-LOCATION2.
           MOVE MAX-TEAM TO FDET2-SCORE.
           MOVE TEAM (SCHOOL-NDX, TEAM-NAM-NDX) TO FDET2-TEAM.


           MOVE MAX-SCHOOL TO FDET1-SCORE.
           SET SCHOOL-NDX TO MAX-SCL-LOCATION.
           MOVE SCHOOL-AR-NAM (SCHOOL-NDX) TO FDET1-SCHOOL.

           WRITE PRINT-LINE FROM FINAL-HEADER
                 AFTER ADVANCING PAGE.
           WRITE PRINT-LINE FROM FINAL-DETAIL1.
           WRITE PRINT-LINE FROM FINAL-HEADER2.
           WRITE PRINT-LINE FROM FINAL-DETAIL2.


           EJECT


/*
//GO.NAME DD DSN=T90RAZ1.C465S02.NAMEFILE,UNIT=DISK,
//      VOL=SER=ACA302,DISP=SHR
//GO.SCORE DD DSN=T90RAZ1.C465S02.SCORFILE,UNIT=DISK,
//      VOL=SER=ACA302,DISP=SHR
//GO.PRINTER DD SYSOUT=*
//GO.SYSOUT DD SYSOUT=*

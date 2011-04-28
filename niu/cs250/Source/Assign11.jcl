//Z002161A JOB ,'Samir Faci'
/*JOBPARM ROOM=161
//    EXEC IGYWCG,CPARM='FLAG(I,I),APOST,TEST(STMT),SSRANGE'
//COB.SYSIN DD *

      *******************************************************************
      * Module Name:   Assign11
      *
      * Function:      Read in data into a 3d table and print it as well
      *                calculate some info on the data read in.
      *                
      *
      * Input:         Input file  a record with info to move into
      *                The table.
      *
      * Output:        Formatted Report.
      *                
      * Notes:         None
      *******************************************************************
 
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  ASSIGN11.
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRINT-FILE  ASSIGN      TO S-SYSOUT.
           SELECT INPUT-FILE  ASSIGN      TO S-SYSIN.


 
           EJECT

       DATA DIVISION.
 
       FILE SECTION.
 
           

      ****************************************************************
      * INPUT-FILE file contain records of quiz scores, section # and
      * student Z number.
      ****************************************************************
       FD  INPUT-FILE
           RECORDING MODE IS F.


       01  INPUT-RECORD.
           05  IN-STUD-ID              PIC X(7).
           05  FILLER                  PIC X.
           05  IN-SECTION-NUM          PIC 9.
           05  FILLER                  PIC X.
           05  IN-QUIZ-TBL             OCCURS 10 TIMES.
               10  IN-QUIZ             PIC 9(2).
           05  FILLER                  PIC X(50).


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
      * LINE-COUNT             stores line count.
      * PAGE-NUM               stores page #
      * COUNT-B                counts number of blank entries.
      * EOF-FLAG               marks the end of the input-file
      * ERROR-FLAG             if value is 'y' then sec-sum is not in
      *                        the 1-4 range.
      * QUIZ-SUM               adds the sum of all 10 quizes.
      * SEC-SUM                table with sum of all scores for all  
      *                        students in each section.
      * SEC-AVG                table of avg quiz grade for each section
      * SUBS                   Subscripts for subscritped table
      * SYSTEM-DATE-AND-TIME   Current system date and time.
      * MY-3-LEVEL-TABLE       The 3d table used to store read in data.
      * DETAIL-TITLE1          Prints title  of report.
      * DETAIL-HEADER1         Prints header of report.
      * DETAIL-LINE1           Prints sec, stud-id, and quiz scores in
      *                        user friendly format.
      * DETAIL-LINE2           Prints avg quiz score in user friendly
      *                        format.
      *******************************************************************
 
       01  COUNT-B                   PIC 9(2).


       01  SYSTEM-DATE-AND-TIME.
           05  SYS-DATE             PIC X(6).
           05                       PIC X         VALUE SPACE.
           05  SYS-TIME             PIC X(8).
 

       01  SUBS.
           05  SEC-SUB              PIC 9(2)      USAGE IS COMP.
           05  STUD-SUB             PIC 9(2)      USAGE IS COMP.
           05  QUIZ-SUB             PIC 9(2)      USAGE IS COMP.


       01  FLAGS.
           05  EOF-FLAG             PIC X       VALUE 'N'.
           05  ERROR-FLAG           PIC X       VALUE 'N'.

       01  PAGE-STUFF.
           05  PAGE-NUM             PIC 9(2)    VALUE ZERO.
           05  LINE-COUNT           PIC 9(2)    VALUE 99.

       01  COUNTERS.
           05 QUIZ-SUM              PIC 9(3)    VALUE ZERO.

       01  SUM-OF-ALL-SECTION-SCORES.
           05  SEC-SUM              OCCURS 4 TIMES
                                    PIC 9(4)    VALUE ZERO.
               

       01  AVG-OF-ALL-SECTION-SCORES.
           05  SEC-AVG              OCCURS 4 TIMES
                                    PIC 9(2)    VALUE ZERO.


       01  MY-3-LEVEL-TABLE.
           05  SEC-TABLE            OCCURS 4 TIMES.
               10  SEC-NUM          PIC 9        VALUE ZERO.
               10  STUDENT-TBL OCCURS 15 TIMES.
                   15  STUDENT      PIC X(7)      VALUE SPACES.
                   15  QUIZ-SCORES-TBL  OCCURS 11 TIMES.
                       20  SCORES   PIC 9(3)   VALUE ZERO.


       01  DETAIL-TITLE1.
           05  FILLER               PIC X(46)   VALUE SPACES.
           05  DETT1-TITLE          PIC X(40)
               VALUE 'COMPARISON OF QUIZ SCORES'.
           05  FILLER               PIC X(40)   VALUE SPACES.
           05  FILLER               PIC X(5)    VALUE 'PAGE '.
           05  DETT-PAGE            PIC 9       VALUE ZERO.

       01  DETAIL-HEADER1.
           05  DETH-HD1             PIC X(10)   VALUE 'SECTION'.
           05  FILLER               PIC X(10)   VALUE SPACES.
           05  DETH-HD2             PIC X(15)   VALUE 'STUDENT ID'.
           05  FILLER               PIC X(5)   VALUE SPACES.
           05  DETH-HD3             PIC X(11)   VALUE 'QUIZ SCORES'.
           05  FILLER               PIC X(71)   VALUE ALL '.'.

       01  DETAIL-LINE1.
           05  FILLER               PIC X(4)    VALUE SPACES.
           05  DET1-SEC             PIC 9       VALUE ZERO.
           05  FILLER               PIC X(16)   VALUE SPACES.
           05  DET1-STUD-ID         PIC X(7)    VALUE SPACES.
           05  FILLER               PIC X(12)   VALUE SPACES.
           05  DET1-SCORES-TBL      OCCURS 10 TIMES.
               10  DET1-SCORES      PIC ZZ9     VALUE ZERO.
               10  FILLER           PIC X(5)    VALUE SPACES.

       01  DETAIL-LINE2.
           05  FILLER               PIC X(20)    VALUE SPACES.
           05  DET2-TITLE           PIC X(26)
               VALUE 'Average score for Section '.
           05  DET2-SEC             PIC 9        VALUE ZERO.
           05  FILLER               PIC X(3)     VALUE ':  '.
           05  DET3-AVG             PIC ZZ9.

           EJECT
       PROCEDURE DIVISION.
 
      *******************************************************************
      * 000-MAIN controls the flow of the program.  calls a function to 
      * build table, then one to calculate quiz avg for the section then
      * another the print a report.  
      *******************************************************************
 
       000-MAIN.
 
          
           OPEN   INPUT  INPUT-FILE
                  OUTPUT PRINT-FILE.


           ACCEPT SYS-DATE FROM DATE.
           ACCEPT SYS-TIME FROM TIME.

           MOVE 1 TO STUD-SUB QUIZ-SUB.

           READ INPUT-FILE
               AT END MOVE 'Y' TO EOF-FLAG.


           PERFORM 100-MOVE-STUFF
               UNTIL EOF-FLAG = 'Y'.

           PERFORM 200-CALC-STUFF.

           PERFORM 300-PRINT-STUFF.

           CLOSE INPUT-FILE
                 PRINT-FILE.


           STOP RUN.
 
 
 

      ***********************************************************
      * 100-MOVE-STUFF  Builds tables and moves data into 3D
      * table.
      ***********************************************************
       100-MOVE-STUFF.


           IF IN-SECTION-NUM > 0 AND < 5
                    MOVE IN-SECTION-NUM TO SEC-SUB
                          SEC-NUM (IN-SECTION-NUM)
           ELSE
              DISPLAY 'ERROR:  SECTION NUMBER NOT IN 1-4 RANGE'
              MOVE 'Y' TO ERROR-FLAG
           END-IF.


           IF ERROR-FLAG = 'N'
              PERFORM VARYING STUD-SUB FROM 1 BY 1
                      UNTIL STUDENT (SEC-SUB, STUD-SUB) = SPACES
                            OR STUD-SUB > 15
              END-PERFORM

           PERFORM VARYING QUIZ-SUB FROM 1 BY 1
              UNTIL QUIZ-SUB > 10
              MOVE IN-QUIZ (QUIZ-SUB) TO
                   SCORES (SEC-SUB, STUD-SUB, QUIZ-SUB)

           END-PERFORM

           MOVE IN-STUD-ID TO STUDENT (SEC-SUB, STUD-SUB)



           END-IF.


           READ INPUT-FILE
               AT END MOVE 'Y' TO EOF-FLAG.



           EJECT


      ***********************************************************
      * 200-CALC-STUFF Adds all the quiz scores up, then the total
      * quiz scores for each section and calculates the avg quiz
      * scores for each of the four sections.
      ***********************************************************

       200-CALC-STUFF.



           PERFORM VARYING SEC-SUB FROM 1 BY 1
                   UNTIL SEC-SUB > 4
              PERFORM VARYING STUD-SUB FROM 1 BY 1
                   UNTIL STUD-SUB > 15
                 PERFORM VARYING QUIZ-SUB FROM 1 BY 1
                 UNTIL QUIZ-SUB > 10
                    ADD SCORES (SEC-SUB, STUD-SUB, QUIZ-SUB)
                        TO QUIZ-SUM GIVING QUIZ-SUM
           END-PERFORM
                MOVE QUIZ-SUM TO  SCORES (SEC-SUB, STUD-SUB, 11)
                MOVE ZERO TO QUIZ-SUM
           END-PERFORM
           END-PERFORM.


           PERFORM VARYING SEC-SUB FROM 1 BY 1
                   UNTIL SEC-SUB > 4
              PERFORM VARYING STUD-SUB FROM 1 BY 1
                   UNTIL STUD-SUB > 15
                 PERFORM VARYING QUIZ-SUB FROM 1 BY 1
                 UNTIL QUIZ-SUB > 10

           END-PERFORM
               ADD SCORES (SEC-SUB, STUD-SUB, 11) TO SEC-SUM (SEC-SUB)
           END-PERFORM
           END-PERFORM.



           PERFORM VARYING SEC-SUB FROM 1 BY 1
                   UNTIL SEC-SUB > 4
              PERFORM VARYING STUD-SUB FROM 1 BY 1
                   UNTIL STUD-SUB > 15
                 PERFORM VARYING QUIZ-SUB FROM 1 BY 1
                 UNTIL QUIZ-SUB > 10

                 END-PERFORM
                 IF STUDENT (SEC-SUB, STUD-SUB) = SPACES
                    ADD 1 TO COUNT-B
                 END-IF
              END-PERFORM
               COMPUTE SEC-AVG (SEC-SUB) ROUNDED = SEC-SUM (SEC-SUB) /
                        (10 * (15 - COUNT-B))
               END-COMPUTE
               MOVE 0 TO COUNT-B
           END-PERFORM.



           EJECT

      ***********************************************************
      * 300-PRINT-STUFF Prints system date and time as well as the
      * report on the students quizes and section avg quiz score.
      ***********************************************************
       300-PRINT-STUFF.

      

           PERFORM VARYING SEC-SUB FROM 1 BY 1
                   UNTIL SEC-SUB > 4

                   ADD 1 TO PAGE-NUM
                   MOVE PAGE-NUM TO DETT-PAGE


                   WRITE PRINT-LINE FROM SYSTEM-DATE-AND-TIME
                   AFTER ADVANCING PAGE

                   WRITE PRINT-LINE FROM DETAIL-TITLE1
                   AFTER ADVANCING 2 LINES
                   WRITE PRINT-LINE FROM DETAIL-HEADER1
                   AFTER ADVANCING 2 LINES
                   MOVE SEC-NUM (SEC-SUB) TO DET1-SEC

              PERFORM VARYING STUD-SUB FROM 1 BY 1
                   UNTIL STUD-SUB > 15

                   MOVE STUDENT (SEC-SUB, STUD-SUB) TO
                        DET1-STUD-ID

                 PERFORM VARYING QUIZ-SUB FROM 1 BY 1
                 UNTIL QUIZ-SUB > 10
                     MOVE SCORES (SEC-SUB, STUD-SUB, QUIZ-SUB) TO
                           DET1-SCORES (QUIZ-SUB)
           END-PERFORM
               IF STUDENT (SEC-SUB, STUD-SUB) NOT = SPACES
                      WRITE PRINT-LINE FROM DETAIL-LINE1
                      AFTER ADVANCING 2 LINES
               END-IF

           END-PERFORM
               MOVE SEC-SUB TO DET2-SEC
               MOVE SEC-AVG (SEC-SUB) TO DET3-AVG
               WRITE PRINT-LINE FROM DETAIL-LINE2
                     AFTER ADVANCING 3 LINES

           END-PERFORM.



           EJECT

//GO.SYSOUT DD SYSOUT=*
//GO.SYSIN  DD  DSN=T90ASS1.SPRING01.COBDATA(DATA11),DISP=SHR












//Z002161A JOB ,'Samir Faci'
/*JOBPARM ROOM=161
//    EXEC IGYWCG,CPARM='FLAG(I,I),APOST,TEST(STMT),SSRANGE'
//COB.SYSIN DD *
      ***************************************************************
      * Module Name:   Assign6
      *
      * Function:      Builds a table of student exam scores, then 
      *                uses data in the table to do some calc and 
      *                print a report.
      *
      * Input:         A file containing several records.
      *
      * Output:        A printed report with student grades.
      *
      * Notes:         None
      ***************************************************************
 
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  ASSIGN6.
 
 
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO S-SYSIN.
           SELECT PRINT-FILE ASSIGN TO S-SYSOUT.
 
           EJECT
       DATA DIVISION.
 
       FILE SECTION.
 
      ***************************************************************
      * The INPUT-FILE contains several 80-character student records.
      * Each record contains the student # and name, year in school,
      * and exam score.  
      ***************************************************************
 
       FD  INPUT-FILE
           RECORDING MODE IS F.
 
       01  INPUT-RECORD.

           05  IN-STUDENT-NUMBER          PIC 9(2).
           05                             PIC X.
           05  IN-STUDENT-NAME            PIC X(20).
           05                             PIC X.
           05  IN-YEAR-IN-SCHOOL          PIC 9.
           05                             PIC X.
           05  IN-EXAM-SCORE              PIC 9(3).
           05                             PIC X.
           05  FILLER                     PIC X(50).
 
 
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
      * STATUS-VALUE             Used with Redefines.
      * TABLES                   Usee to store valid records.
      * COUNTERS                 counts valid and invalid records
      *                          sum of all valid scores, number of
      *                          students, and student average.
      * DETAIL-TITLE             Prints formatted date and title
      * DETAIL-TITLE2            Prints invalid records title
      * DETAIL-LINE-ONE          Prints headers for valid table
      *                          to be printed.
      * DETAIL-LINE-TWO          variables that print data below
      *                          DETAIL-LINE-ONE.
      * DETAIL-LINE-THREE        Prints 1 line for each grade to
      *                          summerize the report.
      * DETAIL-LINE-FOUR         Prints final average of exam scores.
      * PRINT-INVALID            Prints invalid scores.
      * ERROR-CHECK              copies student number and sees if
      *                          it's in range.
      * STATUS-COUNT             counts the # of fresh, soph, 
      *                          juniors and seniors.
      *
      ***************************************************************
 
       01  SYSTEM-DATE-AND-TIME.
           05  SYS-DATE               PIC X(6).
           05                         PIC X           VALUE SPACE.
           05  SYS-TIME               PIC X(8).

       01  MY-DATE.
           05  MY-YEAR                PIC 99.
           05  MY-MONTH               PIC 99.
           05  MY-DAY                 PIC 99.
 

       01  STATUS-VALUE.
           05                         PIC X(10)  VALUE 'FRESHMAN'.
           05                         PIC X(10)  VALUE 'SOPHOMORE'.
           05                         PIC X(10)  VALUE 'JUNIOR'.
           05                         PIC X(10)  VALUE 'SENIOR'.

       01  STATUS-TABLE REDEFINES STATUS-VALUE.
           05  LOCATIONS OCCURS 4 TIMES.
               10  STATUS-CODE        PIC 9.




       01  EOF-FLAG                   PIC X           VALUE 'N'.

       01  TABLES.
           05  TABLE-RECORDS OCCURS 40 TIMES.
               10  TB-STUDENT-NUMBER      PIC 99   VALUE 99.
               10  TB-STUDENT-NAME        PIC X(20).
               10  TB-YEAR-IN-SCHOOL-NUM  PIC 9.
               10  TB-EXAM-SCORE          PIC 999.

       01  COUNTERS.
           05  TABLE-COUNT            PIC 9(2)       VALUE ZERO.
           05  INVALID-COUNT          PIC 9(2)       VALUE ZERO.
           05  SCORE-SUM              PIC 9(4)       VALUE ZERO.
           05  NUM-STUDENTS           PIC 99         VALUE ZERO.
           05  STUD-AVG               PIC 9(2)V99    VALUE ZERO.


       01  DETAIL-TITLE.
           05                         PIC X.
           05  DET-MONTH              PIC 99.
           05                         PIC X VALUE '/'.
           05  DET-DAY                PIC 99.
           05                         PIC X VALUE '/'.
           05  DET-YEAR               PIC 99.
           05                         PIC X(50).
           05  DET-TITLE              PIC X(20)
                            VALUE 'Student Exam Report '.
           05  FILLER                 PIC X(53).

       01  DETAIL-TITLE2.
           05                         PIC X(54)  VALUE SPACES. 

           05  DET2-TITLE             PIC X(25)
                            VALUE 'List of Invalid Records'.
           05  FILLER                 PIC X(53) VALUE SPACES.

       01  DETAIL-LINE-ONE.
           05  DET1-STUD               PIC X(10)
                            VALUE 'Student#: '.
           05                         PIC X(5)  VALUE SPACES.
           05  DET1-NAME               PIC X(7)
                            VALUE 'Name:  '.
           05                         PIC X(5)  VALUE SPACES.
           05  DET1-YEAR               PIC X(20)
                            VALUE 'Year in School'.

           05                         PIC X(5)  VALUE SPACES.
           05  DET1-SCORE              PIC X(10)
                            VALUE 'Score:  '.

       01  DETAIL-LINE-TWO.
           05  STUD-NUM               PIC 99    VALUE ZERO.
           05                         PIC X(5)  VALUE SPACES.
           05  STUD-NAME              PIC X(20) VALUE SPACES.
           05                         PIC X(5).
           05  STUD-YEAR              PIC X(10) VALUE SPACES.
           05                         PIC X(20) VALUE SPACES.
           05  SCORE                  PIC 999.

       01  DETAIL-LINE-THREE.
           05                         PIC X(20)  VALUE SPACES.
           05  DET3-HEADER            PIC X(5)
                            VALUE '# of '.
           05  DET3-STATUS            PIC X(15)  VALUE SPACES.
           05  DET3-NUM               PIC 99.

       01  DETAIL-LINE-FOUR.
           05                         PIC X(20)  VALUE SPACES.
           05  DET4-TITLE             PIC X(30)
                            VALUE 'Average Students Exam Score:  '.
           05  DET4-AVERAGE           PIC Z99.9.


       01  PRINT-INVALID.
           05  PR-INVALID-NUM         PIC 99    VALUE ZERO.
           05                         PIC X     VALUE SPACE.
           05  PR-INVALID-NAME        PIC X(20) VALUE SPACES.
           05                         PIC X     VALUE SPACE.
           05  PR-STATUS              PIC 9     VALUE ZERO.
           05                         PIC X     VALUE SPACE.
           05  PR-SCORE               PIC 9(3)  VALUE ZERO.



       01  ERROR-CHECK.
           05  STUD-NUM-ER            PIC 99    VALUE ZERO.


       01  STATUS-COUNT.
           05  FR-COUNT               PIC 99    VALUE ZERO.
           05  SOPH-COUNT             PIC 99    VALUE ZERO.
           05  JUN-COUNT              PIC 99    VALUE ZERO.
           05  SEN-COUNT              PIC 99    VALUE ZERO.


       
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
 
           ADD 1 TO TABLE-COUNT GIVING TABLE-COUNT.

           ACCEPT SYS-DATE FROM DATE.
           ACCEPT SYS-TIME FROM TIME.
           ACCEPT MY-DATE FROM DATE.

           PERFORM 100-PRINT-HEADER.
 
           READ INPUT-FILE.

           MOVE MY-DAY TO DET-DAY.
           MOVE MY-YEAR TO DET-YEAR.
           MOVE MY-MONTH TO DET-MONTH.


           WRITE PRINT-LINE FROM DETAIL-TITLE2
                 AFTER ADVANCING 2 LINES.


           PERFORM 200-MOVE UNTIL EOF-FLAG = 'Y'.


           MOVE 1 TO TABLE-COUNT.

           WRITE PRINT-LINE FROM DETAIL-TITLE
                 AFTER ADVANCING 2 LINES.
           WRITE PRINT-LINE FROM DETAIL-LINE-ONE
                 AFTER ADVANCING 2 LINES.


           PERFORM 300-PRINT-VALIDS.

           PERFORM 400-SUMMERY.

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
      * 200-MOVE checks if record is valid and moves it to
      *          appropriate detail line.
      ***************************************************************
 
       200-MOVE.
 

           MOVE IN-STUDENT-NUMBER TO STUD-NUM-ER.

           IF (STUD-NUM-ER >= 1 OR STUD-NUM-ER <= 40 )
              MOVE  IN-STUDENT-NUMBER TO TB-STUDENT-NUMBER
                  (TABLE-COUNT)
              MOVE  IN-STUDENT-NAME   TO TB-STUDENT-NAME
                  (TABLE-COUNT)
              MOVE  IN-YEAR-IN-SCHOOL TO TB-YEAR-IN-SCHOOL-NUM
                  (TABLE-COUNT)
              MOVE  IN-EXAM-SCORE     TO TB-EXAM-SCORE
                  (TABLE-COUNT)
              ADD SCORE-SUM TO TB-EXAM-SCORE (TABLE-COUNT) GIVING
                  SCORE-SUM
              ADD 1 TO NUM-STUDENTS GIVING NUM-STUDENTS.
                  IF (TB-YEAR-IN-SCHOOL-NUM (TABLE-COUNT) = 1)
                     ADD 1 TO FR-COUNT GIVING FR-COUNT
                  END-IF
                  IF (TB-YEAR-IN-SCHOOL-NUM (TABLE-COUNT) = 2)
                     ADD 1 TO SOPH-COUNT GIVING SOPH-COUNT
                  END-IF
                  IF (TB-YEAR-IN-SCHOOL-NUM (TABLE-COUNT) = 3)
                     ADD 1 TO JUN-COUNT GIVING JUN-COUNT
                  END-IF
                  IF (TB-YEAR-IN-SCHOOL-NUM (TABLE-COUNT) = 4)
                     ADD 1 TO SEN-COUNT GIVING SEN-COUNT
                  END-IF
           END-IF.

           IF (STUD-NUM-ER < 1 OR STUD-NUM-ER > 40 )
              ADD 1 TO INVALID-COUNT GIVING INVALID-COUNT
              MOVE IN-STUDENT-NUMBER TO PR-INVALID-NUM
              MOVE IN-STUDENT-NAME TO PR-INVALID-NAME
              MOVE IN-YEAR-IN-SCHOOL TO PR-STATUS
              MOVE IN-EXAM-SCORE TO PR-SCORE
              WRITE PRINT-LINE FROM PRINT-INVALID
                AFTER ADVANCING 1 LINE

           END-IF.


           READ INPUT-FILE
                 AT END MOVE 'Y' TO EOF-FLAG.

           ADD 1 TO TABLE-COUNT GIVING TABLE-COUNT.

           EJECT




      ***************************************************************
      * 300-PRINT-INVALIDS prints invalid records.
      ***************************************************************
       300-PRINT-VALIDS.

           PERFORM UNTIL (TB-STUDENT-NUMBER (TABLE-COUNT) = 99)
              MOVE TB-STUDENT-NUMBER (TABLE-COUNT) TO STUD-NUM
              MOVE TB-STUDENT-NAME (TABLE-COUNT) TO  STUD-NAME
              EVALUATE TB-YEAR-IN-SCHOOL-NUM (TABLE-COUNT)
              WHEN 1
                   MOVE 'FRESHMEN' TO STUD-YEAR
              WHEN 2
                   MOVE 'SOPHMORE' TO STUD-YEAR
              WHEN 3
                   MOVE 'JUNIOR' TO STUD-YEAR
              WHEN 4
                   MOVE 'SENIOR' TO STUD-YEAR
              END-EVALUATE

              MOVE TB-EXAM-SCORE (TABLE-COUNT) TO  SCORE

              WRITE PRINT-LINE FROM DETAIL-LINE-TWO
                AFTER ADVANCING 1 LINE
              ADD 1 TO TABLE-COUNT GIVING TABLE-COUNT
           END-PERFORM.


           EJECT


      ***************************************************************
      * 400-SUMMERY Prints final summery.
      ***************************************************************
       400-SUMMERY.

           MOVE 'FRESHMEN' TO DET3-STATUS.
           MOVE FR-COUNT TO DET3-NUM.

           WRITE PRINT-LINE FROM DETAIL-LINE-THREE
                AFTER ADVANCING 3 LINE.

           MOVE 'SOPHMORES' TO DET3-STATUS.
           MOVE SOPH-COUNT TO DET3-NUM.

           WRITE PRINT-LINE FROM DETAIL-LINE-THREE
                AFTER ADVANCING 1 LINE.

           MOVE 'JUNIORS' TO DET3-STATUS.
           MOVE JUN-COUNT TO DET3-NUM.

           WRITE PRINT-LINE FROM DETAIL-LINE-THREE
                AFTER ADVANCING 1 LINE.

           MOVE 'SENIORS' TO DET3-STATUS.
           MOVE SEN-COUNT TO DET3-NUM.

           WRITE PRINT-LINE FROM DETAIL-LINE-THREE
                AFTER ADVANCING 1 LINE.



           DIVIDE SCORE-SUM BY NUM-STUDENTS GIVING STUD-AVG.

           MOVE STUD-AVG TO DET4-AVERAGE.

           WRITE PRINT-LINE FROM DETAIL-LINE-FOUR AFTER
                 ADVANCING 2 LINES.
           EJECT

/*
//GO.SYSIN  DD DSN=T90ASS1.SPRING01.COBDATA(DATA06),DISP=SHR
//GO.SYSOUT DD SYSOUT=*
//




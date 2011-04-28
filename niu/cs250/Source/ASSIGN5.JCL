//Z002161A JOB ,'Samir Faci'
/*JOBPARM ROOM=161
//    EXEC IGYWCG,CPARM='FLAG(I,I),APOST,TEST(STMT)'
//COB.SYSIN DD *
      *******************************************************************
      * Module Name:   Assign5
      *
      * Function:      To produce a sales report organized by 
      *                division using control-break and other concepts
      *                learned in class.
      *
      * Input:         A file containing several records.
      *
      * Output:        A sales report.
      *
      * Notes:         None
      *******************************************************************
 
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  ASSIGN5.
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO S-SYSIN.
           SELECT PRINT-FILE ASSIGN TO S-SYSOUT.
           SELECT SORTWORK ASSIGN TO S-SORTWORK.
           SELECT SORTED ASSIGN TO S-SORTED.          
 
           EJECT
       DATA DIVISION.
 
       FILE SECTION.
 
      *******************************************************************
      * The INPUT-FILE contains several 80-character customer record.
      * Each record contains the course number, course title,
      * credit hours, and prerequisites.
      *******************************************************************
 
       FD  INPUT-FILE
           RECORDING MODE IS F.
 
       01  INPUT-RECORD.
           05  IN-ITEM-ID                 PIC X(5).
           05                             PIC X.
           05  IN-DIVISION                PIC X.
           05                             PIC X.
           05  IN-ITEM-CAT                PIC X(3).
           05                             PIC X.
           05  IN-ITEM-DESC               PIC X(25).
           05                             PIC X.
           05  IN-ITEM-PRICE              PIC 9(5).
           05                             PIC X.
           05  IN-QUANTITY                PIC 9(3).
           05                             PIC X.
           05  IN-SALE-RETURN             PIC X.
           05  FILLER                     PIC X(31).
 
 
      *******************************************************************
      * The PRINT-FILE holds the output.  PRINT-RECORD is written
      * from detail lines defined in WORKING-STORAGE.
      *******************************************************************
 
       FD  PRINT-FILE
           LABEL RECORDS ARE OMITTED
           RECORDING MODE IS F.
 
       01  PRINT-LINE                 PIC X(132).
 

      *******************************************************************
      * The SORTED-WORK file is a temporary file used to sort the data
      *******************************************************************
       SD  SORTWORK
           RECORD CONTAINS 80 CHARACTERS.

       01  SORTWORK-RECORD.
           05  IN-ITEM-ID                 PIC X(5).
           05                             PIC X.
           05  IN-DIVISION                PIC X.
           05                             PIC X.
           05  IN-ITEM-CAT                PIC X(3).
           05                             PIC X.
           05  IN-ITEM-DESC               PIC X(25).
           05                             PIC X.
           05  IN-ITEM-PRICE              PIC 9(5).
           05                             PIC X.
           05  IN-QUANTITY                PIC 9(3).
           05                             PIC X.
           05  IN-SALE-RETURN             PIC X.
           05  FILLER                     PIC X(31).

      *******************************************************************
      * The SORTED file containing the sorted data.
      *******************************************************************


       FD  SORTED
           RECORDING MODE IS F
           DATA RECORD IS SORTED-RECORD.

       01  SORTED-RECORD.
           05  IN-ITEM-ID                 PIC X(5).
           05                             PIC X.
           05  IN-DIVISION                PIC X.
           05                             PIC X.
           05  IN-ITEM-CAT                PIC X(3).
           05                             PIC X.
           05  IN-ITEM-DESC               PIC X(25).
           05                             PIC X.
           05  IN-ITEM-PRICE              PIC 9(5).
           05                             PIC X.
           05  IN-QUANTITY                PIC 9(3).
           05                             PIC X.
           05  IN-SALE-RETURN             PIC X.
           05  FILLER                     PIC X(31).


           EJECT
       WORKING-STORAGE SECTION.
 
      *******************************************************************
      * VARIABLE DICTIONARY
      *
      * SYSTEM-DATE-AND-TIME     Current system date and time.
      * DASHED-LINE              Prints a dashed line
      * BLANK-LINE               Prints a blank line.
      * NON-EDITED-TOTALS        Non formatted variables.
      * TOTALS                   Totals
      * SAVED-PREV-INFO          Previous Division and Category.
      * DETAIL LINES             Prints something on the screen.
      * DIV-TOTALS(1,2,3)        Prints division totals.
      * GR-TOTALS(1,2,3)         Prints grand totals.
      * DET-TOTALS               Prints category totals.
      * EOF-FLAG                 Signals end of file.
      * TOTALS                   Includes Grand, Division and Category
      *                          totals.
      * COUNTER                  page and line count.
      * WORKING-VAR              Temporary variables used in program
      *                          (necessery)
      * DIVISION-IDENTIFIERS     Previous division/category saving
      *                          variables.
      *******************************************************************
 
       01  SYSTEM-DATE-AND-TIME.
           05  SYS-DATE               PIC X(6).
           05                         PIC X           VALUE SPACE.
           05  SYS-TIME               PIC X(8).
 
       01  DASHED-LINE                PIC X(132)     VALUE ALL '-'.
       01  BLANK-LINE                 PIC X(132)     VALUE ALL ' '.

       01  NON-EDITED-VARS.
           05  NE-ITEM-ID                 PIC X(5).
           05  NE-DIVISION                PIC X(3).
           05  NE-ITEM-CAT                PIC X(25).
           05  NE-ITEM-DESC               PIC X(25).
           05  NE-PRICE                   PIC 9(5)V99.
           05  NE-SALE-PRICE              PIC 9(5)V99.
           05  NE-SALE-QTY                PIC 9(3).
           05  NE-RETURN-PRICE            PIC 9(5)V99.
           05  NE-RETURN-QTY              PIC 9(3).


       01  TOTALS.
           05  GRAND-TOTALS.
               10  GR-SALE-QTY        PIC 9(5).
               10  GR-SALE-AMT        PIC 9(5)V99.
               10  GR-RET-QTY         PIC 9(5).
               10  GR-RET-AMT         PIC 9(5)V99.
           05  DIVISION-TOTALS.
               10  DIV-SALE-QTY       PIC 9(5).
               10  DIV-SALE-AMT       PIC 9(5)V99.
               10  DIV-RET-QTY        PIC 9(5).
               10  DIV-RET-AMT        PIC 9(5)V99.
           05  CATEGORY-TOTALS.
               10  CAT-SALE-QTY       PIC 9(3).
               10  CAT-SALE-AMT       PIC 9(5)V99.
               10  CAT-RET-QTY        PIC 9(3).
               10  CAT-RET-AMT        PIC 9(5)V99.

       01  SAVED-PREV-INFO.
           05  PREV-CAT               PIC X(25)    VALUE SPACES.
           05  PREV-DIV               PIC X(3)     VALUE SPACES.

       01  DETAIL-TITLE.
           05                         PIC X(47)    VALUE SPACES.
           05  DETT-TITLE             PIC X(37)
                        VALUE 'Your Pamperted Pet, Inc. Sales Report'.
           05                         PIC X(40)        VALUE SPACES.
           05  DETT-PAGE              PIC X(5)     VALUE 'Page '.
           05  DETT-PAGE-NUM          PIC 9(2)     VALUE 01.

       01  DETAIL-HEADER-ONE.
           05  DETH1-DIV              PIC X(11)    VALUE 'Division:  '.
           05  DETH1-DIV-NAME         PIC X(3)     VALUE SPACES.
           05                         PIC X(6)     VALUE SPACES.
           05  DETH1-CAT              PIC X(11)    VALUE 'Category:  '.
           05  DETH1-CAT-NAME         PIC X(25)    VALUE SPACES.
           05  FILLER                 PIC X(76)    VALUE SPACES.
 
       01  DETAIL-HEADER-TWO.
           05                         PIC X(9)     VALUE SPACES.
           05  DETH2-ITEM-ID          PIC X(7)   
                                          VALUE 'Item-ID'.
           05                         PIC X(8)     VALUE SPACES.
           05  DETH2-ITEM-DESC        PIC X(16)
                                       VALUE 'Item-Description'.
           05                         PIC X(16)    VALUE SPACES.
           05  DETH2-PRICE            PIC X(5)     VALUE 'Price'.
           05                         PIC X(5)     VALUE SPACES.
           05  DETH2-SALE-QTY         PIC X(8) 
                                       VALUE 'Sale Qty'.
           05                         PIC X(5)     VALUE SPACES.
           05  DETH2-SALE-AMT         PIC X(8)   
                                       VALUE 'Sale Amt'.
           05                         PIC X(5)     VALUE SPACES.
           05  DETH2-RET-QTY          PIC X(10)  
                                       VALUE 'Return Qty'.
           05                         PIC X(5)     VALUE SPACES.
           05  DETH2-RET-AMT          PIC X(10)  
                                       VALUE 'Return Amt'.
           05  FILLER                 PIC X(29).

       01  DETAIL-LINE-ONE.
           05  FILLER                     PIC X(9).
           05  DET1-ITEM-ID               PIC X(5).
           05                             PIC X(10).
           05  DET1-ITEM-DESC             PIC X(25).
           05                             PIC X(5).
           05  DET1-PRICE                 PIC $$$$9.99.
           05                             PIC X(7).
           05  DET1-SALE-QTY              PIC 99
                     BLANK WHEN ZERO.
           05                             PIC X(7).
           05  DET1-SALE-PRICE            PIC $$$$9.99
                     BLANK WHEN ZERO.
           05                             PIC X(10).
           05  DET1-RETURN-QTY            PIC 99
                     BLANK WHEN ZERO.
           05                             PIC X(9).
           05  DET1-RETURN-PRICE          PIC $$$$9.99
                     BLANK WHEN ZERO.

       01  DET-TOTALS.
           05                      PIC X(24)  VALUE SPACES.
           05  TOTALS2             PIC X(7)   VALUE 'Total '.
           05  TOTALS3             PIC X(33)  VALUE SPACES.
           05  TOT-SALE-QTY        PIC ZZZ,ZZ9.
           05                      PIC X(6).
           05  TOT-SALE-AMT        PIC $$$$$9.99.
           05                      PIC X(5).
           05  TOT-RET-QTY         PIC ZZZ,ZZ9.
           05                      PIC X(8).
           05  TOT-RET-AMT         PIC $$$$$9.99.

       01  DIV-TOTALS.
           05  CATEGORY            PIC X(4)    VALUE SPACES.
           05  DIVS-TOTALS         PIC X(18)
                                VALUE 'DIVISION TOTALS:  '.
           05  FILLER              PIC X(110)  VALUE SPACES.

       01  DIV-TOTALS2.
           05                      PIC X(24)   VALUE SPACES.
           05  HEAD-1              PIC X(10)
                                VALUE 'Sale Qty  '.
           05                      PIC X(5)    VALUE SPACES.
           05  HEAD-2              PIC X(10)  
                                VALUE 'Sale Amt  '.
           05                      PIC X(5)    VALUE SPACES.
           05  HEAD-3              PIC X(12)
                                VALUE 'Return Qty  '.
           05                      PIC X(5)    VALUE SPACES.
           05  HEAD-4              PIC X(12)
                                VALUE 'Return Amt  '.

       01  DIV-TOTALS3.
           05                      PIC X(21)   VALUE SPACES.
           05  TOTD-SALE-QTY       PIC ZZZ,ZZ9.
           05                      PIC X(9)    VALUE SPACES.
           05  TOTD-SALE-AMT       PIC $$$,$$9.99.
           05                      PIC X(6)    VALUE SPACES.
           05  TOTD-RET-QTY        PIC ZZZ,ZZ9.
           05                      PIC X(9)    VALUE SPACES.
           05  TOTD-RET-AMT        PIC $$$,$$9.99.

       01  GR-TOTALS.
           05  GRAND-TOTALS        PIC X(30)
                                VALUE 'TOTALS FOR ALL DIVISIONS:  '.
           05  FILLER              PIC X(102)    VALUE SPACES.

       01  GR-TOTALS2.
           05                      PIC X(24)   VALUE SPACES.
           05  GR-HEAD-1           PIC X(10)
                                VALUE 'Sale Qty  '.
           05                      PIC X(5)    VALUE SPACES.
           05  GR-HEAD-2           PIC X(10)  
                                VALUE 'Sale Amt  '.
           05                      PIC X(5)    VALUE SPACES.
           05  GR-HEAD-3           PIC X(12)
                                VALUE 'Return Qty  '.
           05                      PIC X(5)    VALUE SPACES.
           05  GR-HEAD-4           PIC X(12)
                                VALUE 'Return Amt  '.

       01  GR-TOTALS3.
           05                      PIC X(21)   VALUE SPACES.
           05  GRAND-SALE-QTY      PIC ZZZ,ZZ9.
           05                      PIC X(9)    VALUE SPACES.
           05  GRAND-SALE-AMT       PIC $$$,$$9.99.
           05                      PIC X(6)    VALUE SPACES.
           05  GRAND-RET-QTY        PIC ZZZ,ZZ9.
           05                      PIC X(9)    VALUE SPACES.
           05  GRAND-RET-AMT        PIC $$$,$$9.99.


       01  EOF-FLAG                   PIC X         VALUE 'N'.

       01  COUNTERS.
           05  PAGE-COUNT           PIC 9(2)      VALUE 3.
           05  LINE-COUNT           PIC 9(2)      VALUE 1.

       01  WORKING-VAR.
           05  TEMP-DIVISION        PIC X.
           05  TEMP-CAT             PIC X(3).
           05  TEMP-SALE-RETURN     PIC X.

       01  DIVISION-IDENTIFIERS.
           05  CAT-ID               PIC X(25).
           05  DIV-ID               PIC X(3).
       
       
           EJECT
       PROCEDURE DIVISION.
 
      *******************************************************************
      * 000-MAIN obtains the system date and time, then calls a
      * subroutine to print it.  It reads the input record, then
      * calls a subroutine to print the detail lines until it reaches
      * the eof marker (aka eof-flag = 'y')
      *******************************************************************
 
       000-MAIN.
 
           
           SORT SORTWORK
             ASCENDING KEY IN-DIVISION IN SORTWORK
                           IN-ITEM-CAT IN SORTWORK
             WITH DUPLICATES IN ORDER
             USING INPUT-FILE
             GIVING SORTED.

           OPEN  INPUT SORTED 
                 OUTPUT PRINT-FILE.

           ACCEPT SYS-DATE FROM DATE.
           ACCEPT SYS-TIME FROM TIME.

           PERFORM 100-PRINT-HEADER.
           INITIALIZE TOTALS  NON-EDITED-VARS.
 
           READ SORTED.
           PERFORM 300-ONE-LARGE-GROUP
               UNTIL EOF-FLAG = 'Y'.
           PERFORM 600-PRINT-GRAND-TOTALS.
           CLOSE SORTED
                 PRINT-FILE.

           STOP RUN.
 
 
 
      *******************************************************************
      * 100-PRINT-HEADER just prints the system date and time.
      *******************************************************************
 
       100-PRINT-HEADER.
 
           WRITE PRINT-LINE FROM SYSTEM-DATE-AND-TIME
               AFTER ADVANCING PAGE.
 
           EJECT


      *******************************************************************
      * 200-PRINT-HEADER moves anything necessery to the correct 
      *  variable.
      *******************************************************************
 
       200-MOVE-EVERYTHING.
 
           MOVE IN-DIVISION IN SORTED TO TEMP-DIVISION.
           MOVE IN-ITEM-CAT IN SORTED TO TEMP-CAT.

           EVALUATE TEMP-DIVISION
               WHEN 'C'
                    MOVE 'CAT' TO NE-DIVISION
               WHEN 'D'
                    MOVE 'DOG' TO NE-DIVISION
               WHEN OTHER
                    MOVE 'ERR' TO NE-DIVISION
           END-EVALUATE.

           EVALUATE TEMP-CAT
               WHEN 'BED'
                    MOVE 'bedding/furniture' TO NE-ITEM-CAT
               WHEN 'GAT'
                    MOVE 'gates and doors' TO NE-ITEM-CAT
               WHEN 'GRM'
                    MOVE 'grooming' TO NE-ITEM-CAT
               WHEN 'TOY' 
                    MOVE 'toys' TO NE-ITEM-CAT
               WHEN 'TRV' 
                    MOVE 'travel' TO NE-ITEM-CAT
               WHEN OTHER
                    MOVE 'ERROR!!!' TO NE-ITEM-CAT
           END-EVALUATE.

          

      *  everything above were moved to appropriate variable      *
      *  now everything will be moved to the num-edited variables *


      *                 begin header one moves                    *

           MOVE NE-DIVISION TO DETH1-DIV-NAME.
           MOVE NE-ITEM-CAT TO DETH1-CAT-NAME.

      *                 end header one moves                      *


           EJECT


      *******************************************************************
      * 300-ONE-LARGE-GROUP handles the divisions and adds stuff.
      *******************************************************************
 
       300-ONE-LARGE-GROUP.

           PERFORM 200-MOVE-EVERYTHING


      *     command below saves large group identified..aka division *
      *     name                                                     *

           MOVE NE-DIVISION TO DIV-ID.
           
           INITIALIZE DIVISION-TOTALS IN TOTALS.

      *    print division and increment grand totals.     

           PERFORM 400-ONE-MEDIUM-GROUP 
                     UNTIL DETH1-DIV-NAME NOT = DIV-ID 
                      OR EOF-FLAG = 'Y'.


           ADD DIV-SALE-AMT TO GR-SALE-AMT GIVING GR-SALE-AMT.
           ADD DIV-SALE-QTY TO GR-SALE-QTY GIVING GR-SALE-QTY.
           ADD DIV-RET-AMT TO GR-RET-AMT GIVING GR-RET-AMT.
           ADD DIV-RET-QTY TO GR-RET-QTY GIVING GR-RET-QTY.

           MOVE DIV-ID TO CATEGORY.
           MOVE DIV-SALE-AMT TO TOTD-SALE-AMT.
           MOVE DIV-SALE-QTY TO TOTD-SALE-QTY.
           MOVE DIV-RET-QTY TO TOTD-RET-QTY.
           MOVE DIV-RET-AMT TO TOTD-RET-AMT.


           WRITE PRINT-LINE FROM DASHED-LINE
                 AFTER ADVANCING 1 LINES.
           WRITE PRINT-LINE FROM DIV-TOTALS
                 AFTER ADVANCING 2 LINES.
           WRITE PRINT-LINE FROM DIV-TOTALS2
                 AFTER ADVANCING 2 LINES.
           WRITE PRINT-LINE FROM DIV-TOTALS3
                 AFTER ADVANCING 2 LINES.
           WRITE PRINT-LINE FROM DASHED-LINE
                 AFTER ADVANCING 1 LINES.
           WRITE PRINT-LINE FROM DASHED-LINE
                 AFTER ADVANCING 1 LINES.


           EJECT

      *******************************************************************
      * 400-ONE-MEDIUM-GROUP handles the categories and adds stuff.
      *******************************************************************
       400-ONE-MEDIUM-GROUP.

      *     command below saves large group identified..aka division *
      *     name                                                     *

           MOVE NE-ITEM-CAT TO CAT-ID.
            
           INITIALIZE CATEGORY-TOTALS IN TOTALS.
             
           MOVE CAT-SALE-QTY TO TOT-SALE-QTY.
           MOVE CAT-SALE-AMT TO TOT-SALE-AMT.
           MOVE CAT-RET-QTY TO TOT-RET-QTY.
           MOVE CAT-RET-AMT TO TOT-RET-AMT.
      

           ADD 1 TO PAGE-COUNT GIVING PAGE-COUNT.


           IF PAGE-COUNT >= 2
              WRITE PRINT-LINE FROM DETAIL-TITLE
                 AFTER ADVANCING PAGE.
              ADD 1 TO LINE-COUNT GIVING LINE-COUNT
              MOVE 0 TO PAGE-COUNT
              MOVE LINE-COUNT TO DETT-PAGE-NUM
           END-IF.


           WRITE PRINT-LINE FROM DASHED-LINE
                 AFTER ADVANCING 2 LINES.
           WRITE PRINT-LINE FROM DETAIL-HEADER-ONE
                 AFTER ADVANCING 2 LINES.
           WRITE PRINT-LINE FROM DETAIL-HEADER-TWO
                 AFTER ADVANCING 2 LINES.

           PERFORM 500-ONE-RECORD 
                  UNTIL DETH1-CAT-NAME NOT = CAT-ID OR
                        DETH1-DIV-NAME NOT = DIV-ID OR
                        EOF-FLAG = 'Y'.

           ADD CAT-SALE-QTY TO DIV-SALE-QTY GIVING DIV-SALE-QTY.
           ADD CAT-SALE-AMT TO DIV-SALE-AMT GIVING DIV-SALE-AMT.
           ADD CAT-RET-QTY TO DIV-RET-QTY GIVING DIV-RET-QTY.
           ADD CAT-RET-AMT TO DIV-RET-AMT GIVING DIV-RET-AMT.




           MOVE CAT-ID TO TOTALS3.
           MOVE CAT-SALE-QTY TO TOT-SALE-QTY.
           MOVE CAT-SALE-AMT TO TOT-SALE-AMT.
           MOVE CAT-RET-AMT  TO TOT-RET-AMT.
           MOVE CAT-RET-QTY  TO TOT-RET-QTY.
 
           WRITE PRINT-LINE FROM DET-TOTALS
                 AFTER ADVANCING 2 LINES.


           EJECT
      *******************************************************************
      * 500-ONE-RECORD prints individual lines and adds stuff.
      *******************************************************************
       500-ONE-RECORD.

           MOVE IN-ITEM-ID IN SORTED TO NE-ITEM-ID.
           MOVE IN-ITEM-DESC IN SORTED TO NE-ITEM-DESC.
           MOVE IN-ITEM-PRICE IN SORTED TO NE-PRICE.
           MOVE IN-SALE-RETURN IN SORTED TO TEMP-SALE-RETURN.
           DIVIDE NE-PRICE BY 100 GIVING NE-PRICE.

           IF TEMP-SALE-RETURN = 'S'
              MOVE ZERO TO NE-RETURN-PRICE
              MOVE ZERO TO NE-RETURN-QTY
              MOVE IN-ITEM-PRICE IN SORTED TO NE-SALE-PRICE
              MOVE IN-QUANTITY IN SORTED TO NE-SALE-QTY
           ELSE
              MOVE ZERO TO NE-SALE-PRICE
              MOVE ZERO TO NE-SALE-QTY
              MOVE IN-ITEM-PRICE IN SORTED TO NE-RETURN-PRICE
              MOVE IN-QUANTITY IN SORTED TO NE-RETURN-QTY
           END-IF.
           DIVIDE NE-RETURN-PRICE BY 100 GIVING NE-RETURN-PRICE.
           DIVIDE NE-SALE-PRICE BY 100 GIVING NE-SALE-PRICE.


      *                 begin detail line one moves               *

           MOVE NE-ITEM-ID TO      DET1-ITEM-ID.
           MOVE NE-ITEM-DESC TO    DET1-ITEM-DESC.
           MOVE NE-PRICE     TO    DET1-PRICE.
           MOVE NE-SALE-PRICE TO   DET1-SALE-PRICE.
           MOVE NE-SALE-QTY TO     DET1-SALE-QTY.
           MOVE NE-RETURN-PRICE TO DET1-RETURN-PRICE.
           MOVE NE-RETURN-QTY TO   DET1-RETURN-QTY.

      *               end detail line one moves                   *

           ADD NE-SALE-PRICE TO CAT-SALE-AMT GIVING CAT-SALE-AMT.
           ADD NE-SALE-QTY TO CAT-SALE-QTY GIVING CAT-SALE-QTY.
           ADD NE-RETURN-PRICE TO CAT-RET-AMT GIVING CAT-RET-AMT.
           ADD NE-RETURN-QTY TO CAT-RET-QTY GIVING CAT-RET-QTY.

           WRITE PRINT-LINE FROM DETAIL-LINE-ONE 
                 AFTER ADVANCING 1 LINE.
           READ SORTED
                AT END MOVE 'Y' TO EOF-FLAG.
           PERFORM 200-MOVE-EVERYTHING

           EJECT

      *******************************************************************
      * 600-PRINT-GRAND-TOTALS prints final totals.
      *******************************************************************

       600-PRINT-GRAND-TOTALS.

           WRITE PRINT-LINE FROM GR-TOTALS 
               AFTER ADVANCING 2 LINES.
           WRITE PRINT-LINE FROM GR-TOTALS2.
           MOVE GR-SALE-QTY TO GRAND-SALE-QTY.
           MOVE GR-SALE-AMT TO GRAND-SALE-AMT.
           MOVE GR-RET-QTY  TO GRAND-RET-QTY.
           MOVE GR-RET-AMT  TO GRAND-RET-AMT.

           WRITE PRINT-LINE FROM GR-TOTALS3
               AFTER ADVANCING 2 LINES.


           EJECT


 
/*
//GO.SYSIN  DD  DSN=T90ASS1.SPRING01.COBDATA(DATA05),DISP=SHR
//GO.SORTWORK DD DSN=&&SORTWORK,UNIT=DISK,VOL=SER=ACA302,
//          SPACE=(TRK,(1,1)),DISP=(NEW,PASS)
//GO.SORTED DD DSN=&&SORTED,UNIT=DISK,VOL=SER=ACA302,
//          SPACE=(TRK,(1,1)),DISP=(NEW,PASS)
//GO.SYSOUT DD SYSOUT=*

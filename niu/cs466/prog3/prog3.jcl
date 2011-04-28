//Z002161A JOB 'Samir Faci',TIME=(,5),REGION=2048K
/*JOBPARM ROOM=161,LINES=10
//*********************************************************************
//*                                                                   *
//* THE LIBRARY HOLDING ANY PROCEDURES THAT ARE USED BY THE ASSEMBLER *
//* MACROS.                                                           *
//*                                                                   *
//*********************************************************************
//PROCLIB DD DSN=T90GMH2.JJ.IMSSIM.PROCLIB,DISP=SHR
//*
//*
//*********************************************************************
//*                                                                   *
//* STEP1 DELETES THE PDS'S FOR THE DATABASE                          *
//*                                                                   *
//* DDNAME              FILE DESCRIPTION                              *
//*                                                                   *
//* DELDD1    INPUT:    PDS THAT HOLDS THE DATABASE INFORMATION       *
//*                                                                   *
//*********************************************************************
//*                                                                   
//STEP1   EXEC PGM=IEFBR14
//DEL1   DD DSN=Z002161.NEWDB,UNIT=DISK,VOL=SER=ACA301,
//       DISP=(MOD,DELETE,DELETE)
//*
//*
//*
//STEP2 EXEC ASM
//*********************************************************************
//*                                                                   *
//* STEP1 executes the assembler procedure asm to define the users    *
//*        view of the database                                       *
//*                                                                   *
//* DDNAME              FILE DESCRIPTION                              *
//*                                                                   *
//* ASM.SYSIN   INPUT:  instream data that defines the database       *
//* ASM.SYSLIN  OUTPUT: pds member that holds the database setup      *
//*                                                                   *
//*********************************************************************
//*                                                                   
//ASM.SYSIN DD *
         PRINT NOGEN
         PCB     TYPE=DB,DBDNAME=BUSDBD,PROCOPT=A,KEYLEN=14
         SENSEG  NAME=HOTEL,PARENT=0                                    
         SENSEG  NAME=RATES,PARENT=HOTEL                                
         SENSEG  NAME=DAYS,PARENT=HOTEL                                 
         SENSEG  NAME=ROOMS,PARENT=DAYS                                 
         SENSEG  NAME=CUSTOMER,PARENT=HOTEL                             
         SENSEG  NAME=CHARGES,PARENT=CUSTOMER                           
         PCB     TYPE=DB,DBDNAME=BUSDBD,PROCOPT=A,KEYLEN=14
         SENSEG  NAME=HOTEL,PARENT=0                                    
         SENSEG  NAME=RATES,PARENT=HOTEL                                
         SENSEG  NAME=DAYS,PARENT=HOTEL                                 
         SENSEG  NAME=ROOMS,PARENT=DAYS                                 
         SENSEG  NAME=CUSTOMER,PARENT=HOTEL                             
         SENSEG  NAME=CHARGES,PARENT=CUSTOMER                           
         PSBGEN  LANG=COBOL,PSBNAME=BUSPSB
         END
/*         
//ASM.SYSLIN DD DSN=Z002161.DBDPDS(BUSPSB),UNIT=DISK,
//             VOL=SER=ACA301,DISP=(OLD,KEEP,KEEP),
//             DCB=(LRECL=80,BLKSIZE=2960,RECFM=FB)
//*
//*
//STEP3 EXEC IGYWC,CPARM='APOST,TEST(STMT)',COND=(4,LT)
//*
//*********************************************************************
//*                                                                   *
//* STEP3 compiles the cobol program that prints the queued up data   *
//*        based on the transaction code read in from the tran-file.  *
//*                                                                   *
//* DDNAME              FILE DESCRIPTION                              *
//*                                                                   *
//* COB.SYSIN   INPUT:  instream data that contains the cobol program *
//*                                                                   *
//*********************************************************************
//COB.SYSIN DD *

      *******************************************************************
      * module name:   assign3                                          *
      *                                                                 *
      * function:      this program will print reports based on the     *
      *                transaction file.  It will queue up the          *
      *                appropriate data from the IMS db and replace it  *
      *                or update it as needed.                          *
      *                                                                 *
      * input:        data-file                                         *
      *                                                                 *
      * output:        formatted report and database itself.            *
      *                                                                 *
      * notes:        I enjoyed much more then prog2, i'm done with     *
      *               MVS yahoooooooooo!!!!!!!!                         *
      *                                                                 *
      *******************************************************************

       IDENTIFICATION DIVISION.

       PROGRAM-ID.    BUSPSB.
       AUTHOR.        SAMIR FACI   

       
       
       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRAN-FILE ASSIGN TO S-TRANDATA. 
           SELECT PRINT-FILE ASSIGN TO S-REPORT.

           EJECT

       DATA DIVISION.

       FILE SECTION.
      *****************************************************************
      * TRAN-FILE contains the data that will be used to retrieve     *
      *      the data from the IMS database.                          *
      *****************************************************************
       FD  TRAN-FILE
           LABEL RECORDS ARE STANDARD
           RECORD CONTAINS 80 CHARACTERS
           RECORDING MODE IS F.

       01  TRAN-RECORD.
           05  TRAN-CODE               PIC X.
           05  TRAN-INFO               PIC X(79).
           05  TRAN-ONE REDEFINES TRAN-INFO.
               10  TR1-CNUM            PIC X(3).
               10  TR1-CLNAME          PIC X(15).
               10  TR1-CFNAME          PIC X(10).
               10  TR1-DISC-TYPE       PIC X.
               10                      PIC X(50).
           05  TRAN-TWO REDEFINES TRAN-INFO.
               10  TR2-CNUM            PIC X(3).
               10                      PIC X(76).
           05  TRAN-THREE REDEFINES TRAN-INFO.
               10  TR3-HOTEL-ID        PIC X(3).
               10  TR3-INCREMENT-FLAG  PIC X.
               10  TR3-INCREMENT-PERCENT PIC 9(2).
               10  TR3-ROOM-TYPE       PIC X.
               10                      PIC X(72).
           05  TRAN-FOUR REDEFINES TRAN-INFO.
               10  TR4-HOTEL-ID        PIC X(3).
               10                      PIC X(76).
           05  TRAN-FIVE REDEFINES TRAN-INFO.
               10  TR5-HOTEL-ID        PIC X(3).
               10  TR5-CNUM            PIC X(3).
               10  TR5-CHARGE-DATE     PIC X(8).
               10  TR5-CHARGE-TYPE     PIC X.
               10  TR5-CHARGE-AMT      PIC 9(3)V99.
               10  TR5-CHARGE-DISC     PIC 9(3)V99.
               10                      PIC X(54).
             
      *****************************************************************
      * PRINT-FILE file used to print the required reports.           *
      *                                                               *
      *****************************************************************

       FD  PRINT-FILE
           LABEL RECORDS ARE OMITTED
           RECORD CONTAINS 132 CHARACTERS
           RECORDING MODE IS F.

       01  PRINT-LINE                  PIC X(132).          

           EJECT

       WORKING-STORAGE SECTION.

      *****************************************************************
      * VARIABLE DICTIONARY                                           *
      *                                                               *
      * EOF-FLAG              set to 'y' when end of file occurs      *
      * I-O-AREA              buffer area used by the DLI calls       *
      *                        redefined to suit input of each        *
      *                        segment type.                          *
      * VARS                 stores different variables/counters/flags*
      *                      used by different subroutines.           *
      * GEN-SSA              generic ssa used by serveral subroutines *
      * GEN-SSA2             same as above                            *
      * DLI-CALLS            used to perform specific queries on the  *
      *                      database.                                *
      * SAVE-INFO            specifc information saved from the       *
      *                      I-O-AREA for later reference.            *
      * QU-HOTEL-SSA         a qualified SSA of segm hotel used       *
      *                      by several functions.                    *
      * QU-CUST-SSA          a qualified SSA of segm customer used    *
      *                      by multiple functions.                   *
      * QU-ROOMS-SSA         a qualified SSA of segment rooms used    *
      *                      in conjunction with 300-TRAN-TYPE2       *
      * QU-ROOMS-SSA2        a qualified SSA of segment rooms used    *
      *                      in conjunction with 500-TRAN-TYPE4       *
      * QU-RATES-SSA         a qualified SSA of segment rates used    *
      *                      in conjunction with                      *
      *                                                               *
      * DETAIL-LINES:                                                 *
      *   TRANSACTION-HEADING  prints a heading preceding each        *
      *                        transaction report.                    *
      *   GEN-ERROR            generic error print-line.              *
      *   TRAN-4-DETAIL        prints info for tran4 report.          *
      *                                                               *
      *****************************************************************

       01  I-O-AREA                    PIC X(79).   
       01  I-O-HOTELS REDEFINES I-O-AREA.
           05  H-IDNUM                 PIC 9(3).
           05  H-CITY                  PIC X(15).
           05  H-NUMROOMS              PIC 9(2).
           05  H-POOL                  PIC X.
           05  H-PETS                  PIC X.
           05  H-FOOD                  PIC X.
           05  H-LAUNDRY               PIC X.
           05  H-WEIGHTRM              PIC X.
           05                          PIC X(54).
       01  I-O-RATES REDEFINES I-O-AREA.
           05  R-TYPEROOM              PIC X.
           05  R-TYPEWEEK              PIC X.
           05  R-RATE                  PIC 9(3)V99.
           05                          PIC X(72).
       01  I-O-DAYS REDEFINES I-O-AREA.
           05  D-DATE                  PIC X(8).
           05  D-WEEKTYPE              PIC X.
           05                          PIC X(70).
       01  I-O-ROOMS REDEFINES I-O-AREA.
           05  RM-ROOMNUM              PIC 9(2).
           05  RM-ROOMTYPE             PIC X.
           05  RM-SMOKING              PIC X.
           05  RM-BOOKED               PIC X.
           05  RM-GUARANTE             PIC X.
           05  RM-FILLED               PIC X.
           05  RM-CUSTNUM              PIC X(3).
           05                          PIC X(69).
       01  I-O-CUSTOMER REDEFINES I-O-AREA.
           05  C-CNUM                  PIC 9(3).
           05  C-CLNAME                PIC X(15).
           05  C-CFNAME                PIC X(10).
           05  C-DISCTYPE              PIC X.
           05                          PIC X(50).
       01  I-O-CHARGES REDEFINES I-O-AREA.
           05  CH-CHRGDATE             PIC X(8).
           05  CH-CHRGTYPE             PIC X.
           05  CH-CHRGAMT              PIC 9(3)V99.
           05  CH-CHRDISC              PIC 9(3)V99.    
           05                          PIC X(60).

       01  EOF-FLAG                    PIC X          VALUE 'N'.
       
       01  DLI-CALLS.
           05  GU                      PIC X(4)       VALUE 'GU  '.
           05  GN                      PIC X(4)       VALUE 'GN  '.
           05  GNP                     PIC X(4)       VALUE 'GNP '.     
           05  GHU                     PIC X(4)       VALUE 'GHU '.
           05  GHN                     PIC X(4)       VALUE 'GHN '.
           05  GHNP                    PIC X(4)       VALUE 'GHNP'.
           05  ISRT                    PIC X(4)       VALUE 'ISRT'.
           05  DLET                    PIC X(4)       VALUE 'DLET'.
           05  REPL                    PIC X(4)       VALUE 'REPL'.
           
       01  VARS.
           05  OLDNUM                  OCCURS 10 TIMES PIC 9(3).
           05  LOC-PTR                 PIC 9(2)  VALUE IS 1.
           05  COUNT1                  PIC 9(2)  VALUE IS ZERO.
           05  NEW-RATE                PIC 9(3)V99.
           05  DONE-FLAG               PIC 9     VALUE IS ZERO.
           05  ERR-FLAG                PIC 9     VALUE IS ZERO.
           05  SAVE-CUSTNUM            PIC 9(3)  VALUE IS ZERO.
       
      *****************************************************************
      *  begin definition of ssa used by the dli calls.               *
      *                                                               *
      *****************************************************************

           
       01  GEN-SSA.
           05  GEN-SEG-NAME                PIC X(8).
           05                              PIC X      VALUE SPACE.
           
       01  GEN-SSA2.
           05  GEN2-SEG-NAME               PIC X(8).
           05                              PIC X      VALUE SPACE.

       01  QU-CUST-SSA.
           05                          PIC X(8) VALUE 'CUSTOMER'.
           05                          PIC X    VALUE '('.
           05                          PIC X(8) VALUE 'CNUM'.
           05                          PIC X(2) VALUE '= '.
           05  CUST-SSA-IN             PIC X(3) VALUE SPACES.
           05                          PIC X    VALUE ')'.


       01  QU-ROOMS-SSA.
           05                          PIC X(8) VALUE 'ROOMS'.
           05                          PIC X    VALUE '('.
           05                          PIC X(8) VALUE 'CUSTNUM'.
           05                          PIC X(2) VALUE '= '.
           05  IN-RCNUM                PIC X(3) VALUE SPACES.
           05                          PIC X    VALUE ')'.

       01  QU-HOTEL-SSA.
           05                          PIC X(8) VALUE 'HOTEL'.
           05                          PIC X    VALUE '('.
           05                          PIC X(8) VALUE 'IDNUM'.
           05                          PIC X(2) VALUE '= '.
           05  IN-HOTEL-ID             PIC X(3) VALUE SPACES.
           05                          PIC X    VALUE ')'.



       01  QU-HOTEL-SSA2.
           05                          PIC X(8) VALUE 'HOTEL'.
           05                          PIC X    VALUE '('.
           05                          PIC X(8) VALUE 'IDNUM'.
           05                          PIC X(2) VALUE '= '.
           05  IN-HOTEL2               PIC X(3) VALUE SPACES.
           05                          PIC X    VALUE ')'.



       01  QU-RATES-SSA.
           05                          PIC X(8) VALUE 'RATES'.
           05                          PIC X    VALUE '('.
           05                          PIC X(8) VALUE 'TYPEROOM'.
           05                          PIC X(2) VALUE '= '.
           05  IN-TYPEROOM             PIC X(3) VALUE SPACES.
           05                          PIC X    VALUE ')'.


       01  QU-ROOMS-SSA2.
           05                          PIC X(8) VALUE 'ROOMS'.
           05                          PIC X    VALUE '('.
           05                          PIC X(8) VALUE 'SMOKING'.
           05                          PIC X(2) VALUE '= '.
           05  IN-SMOKE                PIC X    VALUE 'S'.   
           05                          PIC X    VALUE ')'.



      *****************************************************************
      * DETAIL LINES DECLARATIONS used to print the different values  *
      *    obtained from our beloved IMS.                             *
      *****************************************************************
       01  TRANSACTION-HEADING.
           05                       PIC X(20)  
                            VALUE IS 'TRANSACTION TYPE: '.
           05  TRAN-NUM             PIC 9.
           
       01  GEN-ERROR.
           05  ERROR-NAME           PIC X(60)  VALUE IS SPACES.
           05                       PIC X(15)  
                    VALUE IS 'STATUS-CODE:  '.
           05  ERR-STATUS-CODE      PIC X(2)   VALUE IS SPACES.


       01  TRAN-4-DETAIL. 
           05  TR4-FNAME            PIC X(15).
           05                       PIC X(5)   VALUE IS SPACES.
           05  TR4-LNAME            PIC X(15).


       LINKAGE SECTION.
       
      *****************************************************************
      *  PCB-MASK       program communication block mask used to      *
      *                 access the status information generated       *
      *                 following each call to the database.          *
      *                                                               *
      *  PCB-MASK2      same as above used when access to more then   *
      *                 one path is required.                         *
      *                                                               *
      *****************************************************************
            
       01  PCB-MASK.
           05  DBDNAME                 PIC X(8).
           05  LEVEL-NUMBER            PIC X(2).
           05  STATUS-CODE             PIC X(2).
           05  PROC-OPT                PIC X(4).
           05  JCB-ADDR                PIC X(4).
           05  SEG-NAME                PIC X(8).
           05  KEY-LENGTH              PIC S9(5) COMP.
           05  NUMBER-SEGS             PIC S9(5) COMP.
           05  KEY-FEEDBACK            PIC X(43).
           
       01  PCB-MASK2.
           05  DBDNAME2                PIC X(8).
           05  LEVEL-NUMBER2           PIC X(2).
           05  STATUS-CODE2            PIC X(2).
           05  PROC-OPT2               PIC X(4).
           05  JCB-ADDR2               PIC X(4).
           05  SEG-NAME2               PIC X(8).
           05  KEY-LENGTH2             PIC S9(5) COMP.
           05  NUMBER-SEGS2            PIC S9(5) COMP.
           05  KEY-FEEDBACK2           PIC X(43).
           
           EJECT
           
           
       PROCEDURE DIVISION.
           ENTRY 'DLITCBL' USING PCB-MASK PCB-MASK2.

      *****************************************************************
      * Name:       000-MAIN                                          *
      *                                                               *
      * Function:   Calls subroutine to update database as needed     *
      *             depending on the tran record read in.             *
      *                                                               *
      * Pseudo:                                                       *
      *                                                               *
      *                                                               *
      *    Open files                                                 *
      *    Read the first record                                      *
      *       call subroutine to process code                         *
      *    Close files                                                *
      *    Return control to DLI                                      *
      *                                                               *
      *****************************************************************

       000-MAIN. 

           
           OPEN INPUT TRAN-FILE
                OUTPUT PRINT-FILE.
                
           READ TRAN-FILE
               AT END MOVE 'Y' TO EOF-FLAG
           END-READ.
                
           PERFORM 100-PROCESS-CODE
               UNTIL EOF-FLAG = 'Y'.
           

           MOVE 'DATABASE DUMP:' TO PRINT-LINE.
           WRITE PRINT-LINE AFTER ADVANCING PAGE.


           PERFORM 700-PRINT-DATABASE.  

           CLOSE TRAN-FILE
                 PRINT-FILE.

           GOBACK.
       
       
      *****************************************************************
      * Name:       100-PROCESS-CODE                                  *
      *                                                               *
      * Function:   Evaluates the TRAN-TYPE and calls the appropriate *
      *             sub-routine to process that query.  If it is an   *
      *             invalid query type it then prints an error        *
      *             message. And then it reads the next record to be  *
      *             processed.                                        *
      *                                                               *
      * Pseudo:                                                       *
      *                                                               *
      *   Evaluate the transaction code                               *
      *       Perform appropriate sub-routine                         *
      *   End-evalutate.                                              *
      *   Read next record                                            *
      *                                                               *
      *****************************************************************

       100-PROCESS-CODE.    

           EVALUATE TRAN-CODE
              WHEN 1
                     MOVE 1 TO TRAN-NUM
                     WRITE PRINT-LINE FROM TRANSACTION-HEADING
                         AFTER ADVANCING PAGE
                     PERFORM 200-TRAN-TYPE1
              WHEN 2
                     MOVE 2 TO TRAN-NUM
                     WRITE PRINT-LINE FROM TRANSACTION-HEADING
                         AFTER ADVANCING PAGE
                     PERFORM 300-TRAN-TYPE2
              WHEN 3
                     MOVE 3 TO TRAN-NUM
                     WRITE PRINT-LINE FROM TRANSACTION-HEADING
                         AFTER ADVANCING PAGE
                     PERFORM 400-TRAN-TYPE3
              WHEN 4
                     MOVE 4 TO TRAN-NUM
                     WRITE PRINT-LINE FROM TRANSACTION-HEADING
                         AFTER ADVANCING PAGE
                     END-WRITE
                     PERFORM 500-TRAN-TYPE4
              WHEN 5
                     MOVE 5 TO TRAN-NUM
                     WRITE PRINT-LINE FROM TRANSACTION-HEADING
                         AFTER ADVANCING PAGE
                     PERFORM 600-TRAN-TYPE5
              WHEN OTHER
                     MOVE 'ERROR.  INVALID TRAN CODE READ IN' 
                             TO ERROR-NAME
                     MOVE 'NA' TO ERR-STATUS-CODE
                     WRITE PRINT-LINE FROM GEN-ERROR
           END-EVALUATE.

           READ TRAN-FILE
               AT END MOVE 'Y' TO EOF-FLAG
           END-READ.


           EJECT

      *****************************************************************
      * Name:       200-TRAN-TYPE1                                    *
      *                                                               *
      * Function:   This transaction will insert the customer         *
      *             obtained from the transaction record.             *
      *             if customer already exists in DB, then print      *
      *             error, else call ISRT and add to DB.              *
      *                                                               *
      * Pseudo:                                                       *
      *                                                               *
      *    get customer segment                                       *
      *    if ok                                                      *
      *       print error                                             *
      *    else                                                       *
      *       build io-area                                           *
      *       insert record                                           *
      *    end-if.                                                    *
      *                                                               *
      *****************************************************************

       200-TRAN-TYPE1.      

           
           MOVE 'HOTEL' TO GEN-SEG-NAME.    
           MOVE TR1-CNUM TO CUST-SSA-IN.
           MOVE 'CUSTOMER' TO GEN2-SEG-NAME.
           MOVE SPACES TO I-O-AREA.
           
           CALL 'CBLTDLI' USING GU
                                PCB-MASK
                                I-O-AREA
                                GEN-SSA  
                                QU-CUST-SSA.

           IF STATUS-CODE = '  '
                MOVE 'ERROR. CUSTOMER ' TO ERROR-NAME
                MOVE TR1-CNUM TO ERROR-NAME(17:3)
                MOVE ' ALREAD EXISTS IN DB.' TO 
                       ERROR-NAME(21:22)
                MOVE STATUS-CODE TO ERR-STATUS-CODE
                WRITE PRINT-LINE FROM GEN-ERROR
           ELSE

                MOVE SPACES TO I-O-AREA
                MOVE TRAN-INFO TO I-O-AREA

                MOVE 'CUSTOMER' TO GEN-SEG-NAME
                CALL 'CBLTDLI' USING ISRT
                                     PCB-MASK
                                     I-O-AREA
                                     GEN-SSA
                END-CALL
                IF STATUS-CODE NOT = '  '
                     MOVE 'ERROR.  COULD NOT INSERT CUSTOMER IN DB'
                        TO ERROR-NAME
                     MOVE STATUS-CODE TO ERR-STATUS-CODE
                     WRITE PRINT-LINE FROM GEN-ERROR
                ELSE
                     MOVE I-O-AREA(1:50) TO PRINT-LINE
                     MOVE 'WAS INSERTED' TO PRINT-LINE(51:15)
                     WRITE PRINT-LINE
                END-IF
           END-IF.
                      

           EJECT


      *****************************************************************
      * Name:       300-TRAN-TYPE2                                    *
      *                                                               *
      * Function:   This transaction will delete a customer and all   *
      *             related descendants from the database.  This      *
      *             transaction will also update all room reservations*
      *                within the database to match the update.       *
      *                                                               *
      *                                                               *
      * Pseudo:                                                       *
      *    Get customer record                                        *
      *    if ok                                                      *
      *          delete customer                                      *
      *          ghu rooms qualified by cust num                      *
      *          while ok                                             *
      *            update i-o to match deleted cust status            *
      *            replace record                                     *
      *            ghn next room num                                  *
      *          end-while                                            *
      *    else                                                       *
      *       print error                                             *
      *    end-if                                                     *
      *                                                               *
      *****************************************************************
       300-TRAN-TYPE2.      

           MOVE 'HOTEL' TO GEN-SEG-NAME.    
           MOVE TR2-CNUM TO CUST-SSA-IN.
           MOVE 'CUSTOMER' TO GEN2-SEG-NAME.
           MOVE SPACES TO I-O-AREA.
           
           CALL 'CBLTDLI' USING GHU
                                PCB-MASK
                                I-O-AREA
                                GEN-SSA  
                                QU-CUST-SSA
           END-CALL.

           IF STATUS-CODE = '  '
              CALL 'CBLTDLI' USING DLET
                                   PCB-MASK
                                   I-O-AREA
              END-CALL

              IF STATUS-CODE = '  '

                  MOVE I-O-AREA(1:50) TO PRINT-LINE
                  MOVE 'WAS DELETED' TO PRINT-LINE(51:15)
                  WRITE PRINT-LINE
              END-IF

              MOVE TR2-CNUM TO IN-RCNUM
              MOVE 'HOTEL' TO GEN-SEG-NAME

              CALL 'CBLTDLI' USING GHU
                                   PCB-MASK
                                   I-O-AREA
                                   GEN-SSA
                                   QU-ROOMS-SSA
              END-CALL
              PERFORM UNTIL STATUS-CODE  NOT = '  '
                     MOVE 'N' TO RM-BOOKED
                     MOVE 'N' TO RM-GUARANTE
                     MOVE 'N' TO RM-FILLED

                     CALL 'CBLTDLI' USING REPL
                                          PCB-MASK
                                          I-O-AREA
                     END-CALL
                     CALL 'CBLTDLI' USING GHN
                                          PCB-MASK
                                          I-O-AREA
                                          GEN-SSA
                                          QU-ROOMS-SSA
                     END-CALL
              END-PERFORM


           ELSE
               MOVE 'ERROR. CUSTOMER' TO  ERROR-NAME
               MOVE TR2-CNUM TO ERROR-NAME(17:3) 
               MOVE 'DOES NOT EXIST' TO ERROR-NAME(22:15)
               MOVE STATUS-CODE TO STATUS-CODE
               WRITE PRINT-LINE FROM GEN-ERROR

           END-IF.
           

           EJECT


      *****************************************************************
      * Name:       400-TRAN-TYPE3                                    *
      *                                                               *
      * Function:   Updates the rate of the room depending on the     *
      *             transaction record read in.  The change will      *
      *             affect both the Weekday and Weekend rates.        *
      *                                                               *
      * Pseudo:                                                       *
      *     get rates segment                                         *
      *     while ok                                                  *
      *         Change i-o-area depending of input flags              *
      *         replace segment                                       *
      *         ghn rates segment                                     *
      *     end-while                                                 *
      *                                                               *
      *****************************************************************

       400-TRAN-TYPE3.      

           

           MOVE TR3-HOTEL-ID TO IN-HOTEL-ID.
           MOVE TR3-ROOM-TYPE TO IN-TYPEROOM.

           CALL 'CBLTDLI' USING GHU
                                PCB-MASK
                                I-O-AREA
                                QU-HOTEL-SSA
                                QU-RATES-SSA
           END-CALL.
           PERFORM UNTIL STATUS-CODE NOT = '  '
              IF TR3-INCREMENT-FLAG = 'I'
                   COMPUTE NEW-RATE = R-RATE * 
                      (100 + TR3-INCREMENT-PERCENT) / 100
                   END-COMPUTE
                   MOVE NEW-RATE TO R-RATE
              ELSE
                   COMPUTE NEW-RATE = R-RATE *
                         (100 - TR3-INCREMENT-PERCENT) / 100
                   END-COMPUTE
                   MOVE NEW-RATE TO R-RATE
              END-IF
              CALL 'CBLTDLI' USING REPL
                                   PCB-MASK
                                   I-O-AREA
              END-CALL
              IF STATUS-CODE NOT = '  '
                 MOVE 'ERROR.  COULD NOT UPDATE RATE' TO
                       PRINT-LINE
                 WRITE PRINT-LINE
              END-IF

              CALL 'CBLTDLI' USING GHN
                                   PCB-MASK
                                   I-O-AREA
                                   QU-HOTEL-SSA
                                   QU-RATES-SSA
              END-CALL
           END-PERFORM.
           IF TR3-INCREMENT-FLAG = 'I'
              MOVE 'INCREASED RATES FOR HOTEL:  ' TO PRINT-LINE
           ELSE
              MOVE 'DECREASED RATES FOR HOTEL:  ' TO PRINT-LINE
           END-IF.

           MOVE TR3-HOTEL-ID TO PRINT-LINE(29:3).
           MOVE 'BY ' TO PRINT-LINE(33:3).
           MOVE TR3-INCREMENT-PERCENT TO PRINT-LINE(37:2).
           MOVE '%' TO PRINT-LINE(39:1).
           WRITE PRINT-LINE.

             
           EJECT

      *****************************************************************
      * Name:       500-TRAN-TYPE4                                    *
      *                                                               *
      * Function:   Update hotel to a non-smocking hotel.  Hence all  *
      *             smoking reservations are deleted.  Prints a list. *
      *             of customer reservations who were deleted.        *
      *             needs to update the booked, reserved flags to N   *
      *             as well.  Update Smoking status to 'N' in all     *
      *             rooms.                                            *
      *                                                               *
      * Pseudo:                                                       *
      *     get rates segment                                         *
      *     while ok                                                  *
      *        save cust number                                       *
      *        update i-o-area                                        *
      *        Replace segment                                        *
      *        GU customer based on saved cust num                    *
      *        if ok                                                  *
      *              print cust info                                  *
      *        end-if                                                 *
      *        GHN rooms segment                                      *
      *     end-while                                                 *
      *                                                               *
      *                                                               *
      * note:  does some fancy looping and flagging to make sure      *
      *        the customer is only printed once.                     *
      *                                                               *
      *****************************************************************
       500-TRAN-TYPE4.      


          
           PERFORM VARYING COUNT1 FROM 1 BY 1
                   UNTIL COUNT1 > 9
                 MOVE 0 TO OLDNUM(COUNT1)
           END-PERFORM.

           MOVE TR4-HOTEL-ID TO IN-HOTEL-ID.
           MOVE SPACES TO I-O-AREA.

           CALL 'CBLTDLI' USING GHU
                                PCB-MASK
                                I-O-AREA
                                QU-HOTEL-SSA
                                QU-ROOMS-SSA2
           END-CALL.



           IF STATUS-CODE = '  '
                MOVE 
                  'THE FOLLOWING CUSTOMERS HAD RESERVATIONS CANCELLED' 
                       TO PRINT-LINE
                WRITE PRINT-LINE

           ELSE
                 MOVE 'ERROR.  HOTEL NUM: ' TO PRINT-LINE
                 MOVE TR4-HOTEL-ID TO PRINT-LINE(21:3)
                 MOVE ' NOT FOUND!' TO PRINT-LINE(24:15)
                 WRITE PRINT-LINE
           END-IF.


           PERFORM UNTIL STATUS-CODE NOT = '  '
               MOVE  RM-CUSTNUM TO SAVE-CUSTNUM
               MOVE 'N' TO RM-BOOKED
               MOVE 'N' TO RM-FILLED
               MOVE 'N' TO RM-GUARANTE
               MOVE 'N' TO RM-SMOKING
               MOVE SPACES TO RM-CUSTNUM
               CALL 'CBLTDLI' USING REPL
                                    PCB-MASK
                                    I-O-AREA
               END-CALL
               MOVE SAVE-CUSTNUM TO CUST-SSA-IN
               
               CALL 'CBLTDLI' USING GU
                                    PCB-MASK2
                                    I-O-AREA
                                    QU-HOTEL-SSA
                                    QU-CUST-SSA
               END-CALL
               IF STATUS-CODE2 = '  '
                   PERFORM VARYING COUNT1 FROM 1 BY 1
                           UNTIL COUNT1 > 9
                           OR DONE-FLAG = 1

                       IF OLDNUM(COUNT1) = SAVE-CUSTNUM
                              MOVE 1 TO ERR-FLAG
                       END-IF
                       IF OLDNUM(COUNT1) = 0
                             MOVE COUNT1 TO LOC-PTR
                             MOVE 1 TO DONE-FLAG
                       END-IF

                   END-PERFORM

                       IF ERR-FLAG = 0
                         MOVE C-CLNAME TO TR4-FNAME
                         MOVE C-CFNAME TO TR4-LNAME
                         WRITE PRINT-LINE FROM TRAN-4-DETAIL
                         MOVE SAVE-CUSTNUM TO OLDNUM(LOC-PTR)
                       END-IF
                       MOVE 0 TO DONE-FLAG
                       MOVE 0 TO ERR-FLAG
               END-IF


               CALL 'CBLTDLI' USING GHN
                                    PCB-MASK
                                    I-O-AREA
                                    QU-HOTEL-SSA
                                    QU-ROOMS-SSA2
               END-CALL


           END-PERFORM.


           EJECT

      *****************************************************************
      * Name:       600-TRAN-TYPE5                                    *
      *                                                               *
      * Function:   This transaction will add new charges for a cust  *
      *             in the database.                                  *
      *                                                               *
      * Pseudo:                                                       *
      *                                                               *
      *    get customer segment                                       *
      *    if  ok                                                     *
      *       build i-o-area                                          *
      *       insert charges  // at end                               *
      *    else                                                       *
      *       error.  no customer found.                              *
      *    end-if                                                     *
      *                                                               *
      *****************************************************************

       600-TRAN-TYPE5.      

           MOVE TR5-HOTEL-ID TO IN-HOTEL-ID.
           MOVE TR5-CNUM TO  CUST-SSA-IN.
           
           CALL 'CBLTDLI' USING GU
                                PCB-MASK
                                I-O-AREA
                                QU-HOTEL-SSA
                                QU-CUST-SSA
           END-CALL.

           IF STATUS-CODE = '  '
               MOVE SPACES TO I-O-AREA
               MOVE TR5-CHARGE-DATE TO CH-CHRGDATE
               MOVE TR5-CHARGE-TYPE TO CH-CHRGTYPE
               MOVE TR5-CHARGE-AMT  TO CH-CHRGAMT
               MOVE TR5-CHARGE-DISC TO CH-CHRDISC
               MOVE 'CHARGES' TO GEN-SEG-NAME

               CALL 'CBLTDLI' USING ISRT
                                    PCB-MASK
                                    I-O-AREA
                                    GEN-SSA
               END-CALL


               IF STATUS-CODE = '  '
                  MOVE 'ADDED THE FOLLOWING CHARGE TO CUST: '
                      TO PRINT-LINE
                  MOVE I-O-AREA(1:40) TO PRINT-LINE(40:40)
                  WRITE PRINT-LINE
               END-IF
           ELSE
               MOVE 'ERROR. CUSTOMER' TO  ERROR-NAME
               MOVE TR2-CNUM TO ERROR-NAME(17:3) 
               MOVE 'NOT FOUND!    ' TO ERROR-NAME(22:15)
               MOVE STATUS-CODE TO STATUS-CODE
               WRITE PRINT-LINE FROM GEN-ERROR
           END-IF.


           EJECT


      *****************************************************************
      * Name:       700-PRINT-DATABASE.                               *
      *                                                               *
      * Function:   This transaction type will print a hierarchical   *
      *             listing of the entire database.                   *
      *                                                               *
      * Pseudo:                                                       *
      *    Get first segment                                          *
      *    Do while ok                                                *
      *          Print segment info                                   *
      *          Get next event                                       *
      *    End-Do.                                                    *
      *                                                               *
      *****************************************************************
       700-PRINT-DATABASE.  


           MOVE SPACES TO GEN-SEG-NAME.
           MOVE SPACES TO I-O-AREA.
           
           CALL 'CBLTDLI' USING GU
                                PCB-MASK
                                I-O-AREA.
                                
           IF STATUS-CODE NOT = '  '
                MOVE 'INVALID STATUS CODE ON GU.' TO ERROR-NAME
                MOVE STATUS-CODE TO ERR-STATUS-CODE
                WRITE PRINT-LINE FROM GEN-ERROR
           END-IF.

                                
           PERFORM UNTIL STATUS-CODE = 'GB'
                WRITE PRINT-LINE FROM I-O-AREA
                MOVE SPACES TO I-O-AREA
                
                CALL 'CBLTDLI' USING GN
                                     PCB-MASK
                                     I-O-AREA
                END-CALL
           END-PERFORM.

           EJECT


/*
//*********************************************************************
//* STEP4 uses the imsseg85 (ims simulator link-edit and go) to       *
//*       link edit the compiled cobol program, dbd, and psb, to      *
//*       create an ims application module and will then run          *
//*       the ims simulator program to execute the application        *
//*       module.                                                     *
//*                                                                   *
//*   DDNAMES:                                                        *
//*   PGMLINK.SYSLIN     pgm object module                            *
//*   PSBLINK.SYSLIN     psb object module                            *
//*   IMS.BUSDBD         ims database                                 *
//*   IMS.SYSOUT         location of printing for system messages     *
//*   IMS.TRANDATA       location of database query file              *
//*   IMS.REPORT         used to print output                         *
//*                                                                   *
//*********************************************************************
//*
//STEP4 EXEC IMSSEG85,COND=(0,NE),PSBNAME=BUSPSB,
//      WRITE='(BUSDBD.PUNCH)'
//PGMLINK.SYSLIN  DD
//       DD *
       ENTRY DLITCBL
/*
//DBDLINK.SYSLIN DD * 
      INCLUDE DBDLIB(BUSDBD)
      NAME BUSDBD
/*
//DBDLINK.DBDLIB DD DSN=Z002161.DBDPDS,DISP=SHR,UNIT=DISK, 
//         VOL=SER=ACA301
//PSBLINK.SYSLIN DD DSN=Z002161.DBDPDS(BUSPSB),DISP=SHR,UNIT=DISK,
//         VOL=SER=ACA301
//IMS.BUSDBD DD DSN=Z002161.DBFILE,UNIT=DISK,DISP=(OLD,KEEP,KEEP),
//         VOL=SER=ACA301
//IMS.PUNCH DD DSN=Z002161.NEWDB,UNIT=DISK,DISP=(NEW,KEEP,KEEP),
//         VOL=SER=ACA301,SPACE=(TRK,(1,1)),
//         DCB=(LRECL=80,BLKSIZE=800,DSORG=PS,RECFM=FB)
//IMS.SYSOUT DD SYSOUT=*
//IMS.TRANDATA DD DSN=T90MBM1.HOTEL.DATA3,DISP=SHR
//IMS.REPORT DD SYSOUT=*
//


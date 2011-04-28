//Z002161A JOB ,'Samir Faci',REGION=2048K,LINES=5
/*JOBPARM ROOM=161
//*******************************************************************
//*        CATALOGED LIBRARY FOR THE COMPILE AND LINKED PROCEDURES  *
//*******************************************************************
//STEP0  JCLLIB  ORDER=(Z002161.CS465.LIB2)
//*******************************************************************
//*        DELETES THE PRECEDING VSAM CLUSTERS WHICH WERE CREATED   *
//*******************************************************************
//STEP1 EXEC PGM=IDCAMS,COND=EVEN
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
   DELETE-
   Z002161.C465S02.VSAM.KSDS
   DELETE -
   Z002161.C465S02.VSAM.ESDS
   DELETE -
   Z002161.C465S02.VSAM.RRDS1
   DELETE -
   Z002161.C465S02.VSAM.RRDS2
/*
//*******************************************************************
//*        SORTS THE INPUT DATA AND PUTS OUTPUT IN A TEMP FILE      *
//*******************************************************************
//STEP2   EXEC  PGM=SYNCSORT,PARM='CMP=CLC',COND=EVEN
//SORTIN  DD    DSN=T90RAZ1.A8DATA,DISP=SHR,
//    UNIT=DISK,VOL=SER=ACA302
//SORTOUT DD    DSN=&&SORTED,UNIT=PUB,DISP=(NEW,PASS,DELETE),
//      SPACE=(TRK,(1,1))
//SORTOUT DD    SYSOUT=*
//SYSOUT   DD    SYSOUT=*
//SORTWK01 DD   DSN=&&SORTWK,UNIT=PUB,DISP=(NEW,DELETE),
//      SPACE=(TRK,(1,1))
//SYSIN    DD   *
  SORT   FIELDS=(1,8,BI,A)
/*
//*******************************************************************
//*        DEFINES A KSDS CLUSTER                                   *
//*******************************************************************
//STEP3 EXEC PGM=IDCAMS,COND=EVEN
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
   DEFINE CLUSTER(-
   NAME(Z002161.C465S02.VSAM.KSDS)-
   INDEXED-
   VOLUMES(ACA301)-
   TRACKS(1 1 )-
   KEYS( 28  0))
/*
//*******************************************************************
//*        LOADS DATA INTO THE KSDS CLUSTER                         *
//*******************************************************************
//STEP4  EXEC PGM=IDCAMS,COND=EVEN
//SYSPRINT DD SYSOUT=*
//INPUT DD DSN=&&SORTED,DISP=SHR
//SYSIN DD *
   REPRO -
     INFILE (INPUT)-
     OUTDATASET(Z002161.C465S02.VSAM.KSDS)
/*
//*******************************************************************
//*        DEFINES AN ESDS CLUSTER                                  *
//*******************************************************************
//STEP5  EXEC PGM=IDCAMS,COND=EVEN
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
   DEFINE CLUSTER(-
   NAME(Z002161.C465S02.VSAM.ESDS)-
   NONINDEXED-
   VOLUMES(ACA301)-
   RECORDS(70 10 )-
   RECORDSIZE(82 82))
/*
//*******************************************************************
//*        LOADS DATA INTO AN ESDS CLUSTER                          *
//*******************************************************************
//STEP6  EXEC PGM=IDCAMS,COND=EVEN
//SYSPRINT DD SYSOUT=*
//INPUT DD DSN=T90RAZ1.A8DATA,VOL=SER=ACA302,DISP=SHR,UNIT=DISK
//SYSIN DD *
   REPRO -
     INFILE (INPUT)-
     OUTDATASET(Z002161.C465S02.VSAM.ESDS)
/*
//*******************************************************************
//*        DEFINES THE 1ST RRDS CLUSTER                             *
//*******************************************************************
//STEP7 EXEC PGM=IDCAMS,COND=EVEN
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
   DEFINE CLUSTER(-
   NAME(Z002161.C465S02.VSAM.RRDS1)-
   VOLUMES(ACA301)-
   RECORDS(70 10)-
   RECORDSIZE(82 82)-
   NUMBERED)
/*
//*******************************************************************
//*        LOADS UNSORTED DATA INTO THE 1ST RRDS CLUSTER            *
//*******************************************************************
//STEP8  EXEC PGM=IDCAMS,COND=EVEN
//SYSPRINT DD SYSOUT=*
//INPUT DD DSN=T90RAZ1.A8DATA,VOL=SER=ACA302,DISP=SHR,UNIT=DISK,
//   DCB=(LRECL=82)
//SYSIN DD *
   REPRO -
     INFILE (INPUT)-
     OUTDATASET(Z002161.C465S02.VSAM.RRDS1)
/*
//*
//*******************************************************************
//*        DEFINES THE 2ND RRDS CLUSTER                             *
//*******************************************************************
//STEP9 EXEC PGM=IDCAMS,COND=EVEN
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
   DEFINE CLUSTER(-
   NAME(Z002161.C465S02.VSAM.RRDS2)-
   VOLUMES(ACA301)-
   RECORDS(70 10)-
   RECORDSIZE(82 82)-
   NUMBERED)
/*
//STEP10 EXEC COMPILE,CREG=2048K,
//    CPARM='LIB,APOST,FLAG(W,W),TEST,MAP,OFFSET',COBJ=&&MAIN
//SYSIN DD *
         TITLE 'SAMIR FACI CSCI 465 SECTION 1 ASSIGNMENT 8'
      *******************************************************************
      * Module Name:   Assign8                                          *
      *                                                                 *
      * Function:      This program loads the RRDS cluster by           *
      *                calculating a hashed value, which the program    *
      *                uses for setting relative key of the RRDS file.  *
      *                                                                 *
      * Input:         unsorted input file                              *
      *                                                                 *
      * Output:        the loaded RRDS cluster                          *
      * Notes:                                                          *
      *******************************************************************

       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  ASSIGN8.
 
       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT IN-FILE ASSIGN TO INDD.
           SELECT RRDS-FILE ASSIGN TO RRDSDD
                       ORGANIZATION IS RELATIVE
                       ACCESS IS RANDOM
                       RELATIVE KEY IS HASH-KEY.

       DATA DIVISION.
       FILE SECTION.
      ***************************************************************
      * IN-FILE contains info on books including author name, isnb..
      *************************************************************** 
       FD  IN-FILE
           RECORDING MODE IS F
           LABEL RECORDS ARE STANDARD
           RECORD CONTAINS 82 CHARACTERS.
      
       01  IN-RECORD.
           05 IN-ISBN-NO                       PIC 9(8).
           05 IN-AUTHOR                        PIC X(25).
           05 IN-TITLE                         PIC X(40).           
           05 IN-CODE                          PIC 9(6).
           05 IN-QHAND                         PIC S9(3).

      ***************************************************************
      * RRDS-FILE is a template for the RRDS-CLUSTER which is filled
      * from the INPUT-FILE.
      ***************************************************************
       FD  RRDS-FILE
           RECORD CONTAINS 82 CHARACTERS.
   
       01  RRDS-RECORD.
           05 RRDS-ISBN-NO                       PIC 9(8).
           05 RRDS-AUTHOR                        PIC X(25).
           05 RRDS-TITLE                         PIC X(40).
           05 RRDS-CODE                          PIC 9(6).
           05 RRDS-QHAND                         PIC S9(3).

       WORKING-STORAGE SECTION.
      ***************************************************************
      *  
      * IN-EOF                  FLAG TO INDICATE EOF FOR INPUT-FILE 
      * HASH-KEY                HASHED KEY.
      * HASH-SAVE               VARIABLE TO INDICATE THE NONEMPTY SLOT
      * DONE-FLAG               INDICATES A SUCCESSFUL WRITE.
      * FULL-FLAG               ON IF THE KSDS CLUSTER IS FULL
      * RESULT                  POINTLESS VARIABLE
      * REMAIN                  STORES REMAINDER OF DIVISION.
      ****************************************************************   
       01  FLAGS. 
           05 IN-EOF                           PIC X VALUE 'N'.
           05 RRDS-EOF                         PIC X VALUE 'N'.
           05 DONE-FLAG                        PIC X VALUE 'N'.
           05 FULL-FLAG                        PIC X VALUE 'N'.

       01  VARIABLES.       
           05 HASH-KEY                         PIC 9(2) VALUE 0.
           05 HASH-SAVE                        PIC 9(2) VALUE 0.
           05 RESULT                           PIC 9(4) VALUE 0.
           05 REMAIN                           PIC 9(4) VALUE 0.

        01  DASHED-LINE          PIC X(132)  VALUE ALL '-'.

       PROCEDURE DIVISION.
      *******************************************************************
      * 000-MAIN controls the flow of the program.                      *
      * calculates the hash key and fills the RRDS using the hashed key *
      *******************************************************************
       000-MAIN.
  
           OPEN INPUT IN-FILE
                OUTPUT RRDS-FILE

           READ IN-FILE 
                AT END MOVE 'Y' TO IN-EOF.
                
           PERFORM 50-GET-KEY UNTIL IN-EOF = 'Y'.

           CLOSE IN-FILE
                 RRDS-FILE
           STOP RUN.

      *******************************************************************
      * 50-GET-KEY writes the records to the RRDS record.               *
      *******************************************************************
       50-GET-KEY.

           MOVE 'N' TO DONE-FLAG.
           MOVE 'N' TO FULL-FLAG.

           DIVIDE IN-ISBN-NO BY 70
               GIVING RESULT
               REMAINDER REMAIN.
           
           ADD 1 TO REMAIN GIVING HASH-KEY.
           MOVE HASH-KEY TO HASH-SAVE.           

           PERFORM UNTIL DONE-FLAG = 'Y' OR
                         FULL-FLAG = 'Y'
           WRITE RRDS-RECORD FROM IN-RECORD
               INVALID KEY  
                   PERFORM 100-FIND-NEXT-SLOT
               NOT INVALID KEY              
                   MOVE 'Y' TO DONE-FLAG               
           END-WRITE
           END-PERFORM.

           READ IN-FILE 
              AT END MOVE 'Y' TO IN-EOF
           END-READ.

           EJECT    

      *******************************************************************
      * 100-FIND-NEXT-SLOT calculates the address of the                *
      * hash key to fill the RSDS cluster                               *
      *******************************************************************
       100-FIND-NEXT-SLOT.

           IF HASH-KEY >= 70
              MOVE 1 TO HASH-KEY
           ELSE 
              ADD 1 TO HASH-KEY
           END-IF.
                      
           IF HASH-KEY = HASH-SAVE
              MOVE 'Y' TO FULL-FLAG
           END-IF.

           EJECT
/*
//STEP10B EXEC LINKED,LOBJ=&&MAIN
//PROC3.INDD  DD DSN=T90RAZ1.A8DATA,UNIT=DISK,VOL=SER=ACA302,
//      DISP=SHR
//PROC3.RRDSDD DD DSN=Z002161.C465S02.VSAM.RRDS2,UNIT=DISK,
//   VOL=SER=ACA301,DISP=(OLD,KEEP,DELETE) 
//*******************************************************************
//*        PRINTS THE DATA INSIDE THE CLUSTERS.                     *
//*******************************************************************
//STEP11 EXEC PGM=IDCAMS,COND=EVEN
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
   PRINT-
   INDATASET(Z002161.C465S02.VSAM.KSDS)-
   CHAR
   PRINT-
   INDATASET(Z002161.C465S02.VSAM.ESDS)-
   CHAR
   PRINT-
   INDATASET(Z002161.C465S02.VSAM.RRDS1)-
   CHAR   
   PRINT-
   INDATASET(Z002161.C465S02.VSAM.RRDS2)-
   CHAR
   PRINT-
   INDATASET(Z002161.C465S02.VSAM.KSDS)-
   DUMP
/*
//*******************************************************************
//* FINAL DELETE 
//*******************************************************************                                         
//STEP12  EXEC PGM=IDCAMS,COND=EVEN
//SYSPRINT  DD SYSOUT=*
//SYSIN  DD *
   DELETE (Z002161.C465S02.VSAM.KSDS)  
   DELETE (Z002161.C465S02.VSAM.ESDS)  
   DELETE (Z002161.C465S02.VSAM.RRDS1)  
   DELETE (Z002161.C465S02.VSAM.RRDS2) 
/*
//

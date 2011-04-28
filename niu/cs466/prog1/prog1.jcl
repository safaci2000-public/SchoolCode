//Z002161A JOB 'Samir Faci',TIME=(,5),REGION=2048K
/*JOBPARM LINES=10
//*********************************************************************
//*                                                                   *
//* THE PURPOSE OF THIS JOB IS TO CREATE, LOAD, AND PRINT THE         *
//* CONTENTS OF AN IMS DATABASE.                                      *
//*                                                                   *
//*********************************************************************
//*
//*********************************************************************
//*                                                                   *
//* THE LIBRARY HOLDING ANY PROCEDURES THAT ARE USED BY THE ASSEMBLER *
//* MACROS.                                                           *
//*                                                                   *
//*********************************************************************
//PROCLIB DD DSN=T90GMH2.JJ.IMSSIM.PROCLIB,DISP=SHR,VOL=SER=ACA301
//*
//STEP1 EXEC PGM=IEFBR14
//*********************************************************************
//*                                                                   *
//* STEP1 DELETES THE PDS'S FOR THE DATABASE                          *
//*                                                                   *
//* DDNAME              FILE DESCRIPTION                              *
//*                                                                   *
//* DD1       INPUT:    PDS THAT HOLDS THE DATABASE INFORMATION       *
//* DD2       INPUT:    PDS FOR THE PRINTFILE                         *
//*                                                                   *
//*********************************************************************
//DD1 DD DSN=Z002161.DBDPDS,UNIT=DISK,VOL=SER=ACA301,                  
//           DISP=(MOD,DELETE,DELETE)
//DD2 DD DSN=Z002161.DBFILE,UNIT=DISK,VOL=SER=ACA301,                  
//           DISP=(MOD,DELETE,DELETE)
//*
//*
//STEP2     EXEC ASM
//*
//*********************************************************************
//*                                                                   *
//* STEP2 EXECUTES THE ASSEMBLER PROCEDURE ASM TO DEFINE THE DATABASE *
//*                                                                   *
//* DDNAME               FILE DESCRIPTION                             *
//*                                                                   *
//* ASM.SYSIN   INPUT:   THE INSTREAM DATA THAT DEFINES THE DATABASE  *
//* ASM.SYSLIN  OUTPUT:  PDS MEMBER THAT HOLDS THE DATABASE           *
//*                                                                   *
//*********************************************************************
//*                                                                   
//*********************************************************************
//*   NAME:       BUSDBD                                              *
//*                                                                   *
//*   FUNCTION:   TO GENERATE A DBD (DATA BASE DESCRIPTOR)            *
//*               USING ASSEMBLER MACROS.                             *
//*                                                                   *
//*   HIERARCHICAL STRUCTURE:                                         *
//*                                                                   *
//*                ---------------                                    *
//*                |    HOTEL    |                                    *
//*                ---------------                                    *
//*                       |                                           *
//*    -----------------------------------------------------          *
//*    |                      |                            |          *
//*  ----------         ------------              --------------      *
//*  | RATES  |         |   DAYS   |              | CUSTOMER   |      *
//*  ----------         ------------              --------------      *
//*                           |                            |          *
//*                     ------------              --------------      *
//*                     |  ROOMS   |              |  CHARGES   |      *
//*                     ------------              --------------      *
//*                                                                   *
//*********************************************************************
//*
//ASM.SYSIN DD *
       PRINT   NOGEN
       DBD     NAME=BUSDBD,ACCESS=HIDAM
       DATASET DD1=BUSDBD,DEVICE=3350
       SEGM    NAME=HOTEL,PARENT=0,BYTES=(25,25)                 
       FIELD   NAME=(IDNUM,SEQ,U),BYTES=3,START=1                  
       FIELD   NAME=(CITY),BYTES=15,START=4                          
       FIELD   NAME=(NUMROOMS),BYTES=2,START=19                 
       FIELD   NAME=(POOL),BYTES=1,START=21                          
       FIELD   NAME=(PETS),BYTES=1,START=22                          
       FIELD   NAME=(FOOD),BYTES=1,START=23                          
       FIELD   NAME=(LAUNDRY),BYTES=1,START=24                       
       FIELD   NAME=(WEIGHTRM),BYTES=1,START=25                      
       SEGM    NAME=RATES,PARENT=HOTEL,BYTES=(7,7)                   
       FIELD   NAME=(TYPEROOM),BYTES=1,START=1                       
       FIELD   NAME=(TYPEWEEK),BYTES=1,START=2                       
       FIELD   NAME=(RATE),BYTES=5,START=3                           
       SEGM    NAME=DAYS,PARENT=HOTEL,BYTES=(9,9)                    
       FIELD   NAME=(DATE,SEQ,U),BYTES=8,START=1                   
       FIELD   NAME=(WEEKTYPE),BYTES=1,START=9                       
       SEGM    NAME=ROOMS,PARENT=DAYS,BYTES=(10,10)                  
       FIELD   NAME=(ROOMNUM,SEQ,U),BYTES=2,START=1                
       FIELD   NAME=(ROOMTYPE),BYTES=1,START=3                       
       FIELD   NAME=(SMOKING),BYTES=1,START=4                        
       FIELD   NAME=(BOOKED),BYTES=1,START=5                         
       FIELD   NAME=(GUARANTE),BYTES=1,START=6                       
       FIELD   NAME=(FILLED),BYTES=1,START=7                         
       FIELD   NAME=(CUSTNUM),BYTES=3,START=8                        
       SEGM    NAME=CUSTOMER,PARENT=HOTEL,BYTES=(29,29)              
       FIELD   NAME=(CNUM,SEQ,U),BYTES=3,START=1                   
       FIELD   NAME=(CLNAME),BYTES=15,START=4                        
       FIELD   NAME=(CFNAME),BYTES=10,START=19                       
       FIELD   NAME=(DISCTYPE),BYTES=1,START=29                      
       SEGM    NAME=CHARGES,PARENT=CUSTOMER,BYTES=(19,19)            
       FIELD   NAME=(CHRGDATE,SEQ,M),BYTES=8,START=1                  
       FIELD   NAME=(CHRGTYPE),BYTES=1,START=9                       
       FIELD   NAME=(CHRGAMT),BYTES=5,START=10                       
       FIELD   NAME=(CHRGDISC),BYTES=5,START=15                    
       DBDGEN
       FINISH
       END
/*       
//ASM.SYSLIN DD DSN=Z002161.DBDPDS(BUSDBD),UNIT=DISK,
//        VOL=SER=ACA301,SPACE=(2960,(20,10,2)),DISP=(NEW,KEEP,KEEP),
//        DCB=(LRECL=80,BLKSIZE=2960,RECFM=FB)
//*
//*
//STEP3 EXEC ASM,COND=(0,NE)
//*********************************************************************
//*                                                                   *
//* STEP3 EXECUTES THE ASSEMBLER PROCEDURE ASM TO DEFINE THE USER    S*
//*        VIEW OF THE DATABASE                                       *
//*                                                                   *
//* DDNAME              FILE DESCRIPTION                              *
//*                                                                   *
//* ASM.SYSIN   INPUT:  INSTREAM DATA THAT DEFINES THE DATABASE       *
//* ASM.SYSLIN  OUTPUT: PDS MEMBER THAT HOLDS THE DATABASE SETUP      *
//*                                                                   *
//*********************************************************************
//*                                                                   
//ASM.SYSIN DD *
         PRINT NOGEN
         PCB     TYPE=DB,DBDNAME=BUSDBD,PROCOPT=LS,KEYLEN=14
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
//STEP4 EXEC IGYWC,CPARM='APOST,TEST(STMT)',COND=(4,LT)
//*
//*********************************************************************
//*                                                                   *
//* STEP4 COMPILES THE COBOL PROGRAM THAT LOADS AND PRINTS THE IMS    *
//*        DATABASE                                                   *
//*                                                                   *
//* DDNAME              FILE DESCRIPTION                              *
//*                                                                   *
//* COB.SYSIN   INPUT:  INSTREAM DATA THAT CONTAINS THE COBOL PROGRAM *
//*                                                                   *
//*********************************************************************
//COB.SYSIN DD *

      *******************************************************************
      * module name:   assign1                                          *
      *                                                                 *
      * function:      this program will load the data into a ims       *
      *                database using the dl/i interface.               *
      *                                                                 *
      *                                                                 *
      * input:        data-file                                         *
      *                                                                 *
      *                                                                 *
      * output:        formatted report and database itself.            *
      *                                                                 *
      * notes:                                                          *
      *******************************************************************

       IDENTIFICATION DIVISION.

       PROGRAM-ID.    BUSPSB.
       AUTHOR.        SAMIR FACI   

       
       
       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT DATA-FILE ASSIGN TO S-LOADDATA. 
           SELECT PRINT-FILE ASSIGN TO S-REPORT.

           EJECT

       DATA DIVISION.

       FILE SECTION.
      *****************************************************************
      * DATA-FILE contains the data that shall be loaded into the     *
      *      database.                                                *
      *****************************************************************
       FD  DATA-FILE
           LABEL RECORDS ARE STANDARD
           RECORD CONTAINS 80 CHARACTERS
           RECORDING MODE IS F.

       01  DATA-RECORD.
           05  SEGMENT-TYPE            PIC X.
           05  REST-OF-DATA            PIC X(79).
             
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
      * VARIABLE DICTIONARY:                                          *
      *                                                               *
      * EOF-FLAG              set to 'y' when end of file occurs      *
      * COUNTERS.                                                     *
      *    NUM-HOTELS         number of hotel segments inserted in DB *
      *    NUM-RATES          number of rates segments inserted in DB *
      *    NUM-DAYS           number of days segments inserted in DB  *
      *    NUM-ROOMS          number of room segments inserted in DB  *
      *    NUM-CUSTOMER       number of cust. segments inserted in DB *
      *    NUM-CHARGES        number of charges segment inserted in DB*
      *    TOTAL-SEGMENTS     total # of segments inserted in DB      *
      * GEN-SSA               general ssa used for loading segs in db.*
      * I-O-AREA              buffer to store data to be recorded     *
      *                       into the database.                      *      
      * ISRT                  value used by DL/I                      *      
      * DASHED-LINE           var which stores an underline used for  *      
      *                       output.                                 *      
      * PRETTY                prints a pretty lil header and page #   *      
      * HEADERS*              prints the columns headers.             *            
      * DATA1                 prints the number of each type of segs  *            
      *                       which have been inserted into the       *            
      *                       database                                *            
      *                                                               *            
      *****************************************************************

       01  EOF-FLAG                    PIC X          VALUE 'N'.
       
       01  COUNTERS.
           05  NUM-HOTELS              PIC 9(4)         VALUE ZERO.
           05  NUM-RATES               PIC 9(4)         VALUE ZERO.
           05  NUM-DAYS                PIC 9(4)         VALUE ZERO.
           05  NUM-ROOMS               PIC 9(4)         VALUE ZERO.
           05  NUM-CUSTOMER            PIC 9(4)         VALUE ZERO.
           05  NUM-CHARGES             PIC 9(4)         VALUE ZERO.
           05  TOTAL-SEGMENTS          PIC 9(4)         VALUE ZERO.
           
       01  GEN-SSA.
           05  GEN-SEG-NAME            PIC X(8).
           05                          PIC X          VALUE SPACE.
           
       01  I-O-AREA                    PIC X(79).
       01  ISRT                        PIC X(4)       VALUE 'ISRT'.

      *****************************************************************
      *    begin definition of working storage relating to output.    *
      *****************************************************************

       01  DASHED-LINE                 PIC X(132)     VALUE ALL '-'.
     
       01  PRETTY.
           05                         PIC X(50) VALUE SPACES.
           05                  PIC X(30)
                   VALUE IS 'CS466 DATABASE COUNT'.
           05                         PIC X(40) VALUE IS SPACES.
           05                         PIC X(5) VALUE IS 'PAGE '.
           05 PR-PAGE                 PIC Z9.


       01  HEADERS1.
           05  HD1-HOTELS              PIC X(10)  VALUE 'NUMBER OF '.
           05                          PIC X(5) VALUE SPACES.
           05  HD1-RATES               PIC X(10)  VALUE 'NUMBER OF '.
           05                          PIC X(5) VALUE SPACES.
           05  HD1-DAYS                PIC X(10)  VALUE 'NUMBER OF '.
           05                          PIC X(5) VALUE SPACES.
           05  HD1-ROOMS               PIC X(10)  VALUE 'NUMBER OF '.
           05                          PIC X(5) VALUE SPACES.
           05  HD1-CUSTOMER            PIC X(15)  VALUE 'NUMBER OF '.
           05                          PIC X(5) VALUE SPACES.
           05  HD1-CHARGES             PIC X(15)  VALUE 'NUMBER OF '.
           05                          PIC X(5) VALUE SPACES.
           05  HD1-SEGMENTS            PIC X(10)  VALUE 'NUMBER OF '.


       01  HEADERS2.
           05  HD2-HOTELS              PIC X(10)  VALUE 'HOTEL SEGS'.
           05                          PIC X(5) VALUE SPACES.
           05  HD2-RATES               PIC X(10)  VALUE 'RATES SEGS'.
           05                          PIC X(5) VALUE SPACES.
           05  HD2-DAYS                PIC X(10)  VALUE 'DAYS SEGS '.
           05                          PIC X(5) VALUE SPACES.
           05  HD2-ROOMS               PIC X(10)  VALUE 'ROOMS SEGS'.
           05                          PIC X(5) VALUE SPACES.
           05  HD2-CUSTOMER          PIC X(15)  VALUE 'CUSTOMER SEGS'.
           05                          PIC X(5) VALUE SPACES.
           05  HD2-CHARGES             PIC X(15)  VALUE 'CHARGES SEGS'.
           05                          PIC X(5) VALUE SPACES.
           05  HD2-SEGMENTS            PIC X(10)  VALUE 'TOTAL SEGS'.
           05                          PIC X(5) VALUE SPACES.

       01  DATA1.
           05  DATA-HOTELS              PIC ZZZZ9.
           05                           PIC X(10) VALUE SPACES.
           05  DATA-RATES               PIC ZZZZ9.
           05                           PIC X(10) VALUE SPACES.
           05  DATA-DAYS                PIC ZZZZ9.
           05                           PIC X(10) VALUE SPACES.
           05  DATA-ROOMS               PIC ZZZZ9.
           05                           PIC X(10) VALUE SPACES.
           05  DATA-CUSTOMER            PIC ZZZZ9.
           05                           PIC X(15) VALUE SPACES.
           05  DATA-CHARGES             PIC ZZZZ9.
           05                           PIC X(15) VALUE SPACES.
           05  DATA-TOTALS              PIC ZZZZ9.






       LINKAGE SECTION.
       
      *****************************************************************
      *  PCB-MASK       program communication block mask used to      *
      *                 access the status information generated       *
      *                 following each call to the database.          *
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
       
           EJECT
           
       PROCEDURE DIVISION.


      *****************************************************************
      * 000-MAIN controls the flow of the proram, read the data       *
      *  and loads it into the database, after which it will print    *
      *  the number of each segments inserted.                        *
      *     of course all this is done by calling other subroutines   *
      *     before returning control to dl/i.                         *
      *****************************************************************

       000-MAIN. 
           ENTRY 'DLITCBL' USING PCB-MASK.
           
           OPEN INPUT DATA-FILE
                OUTPUT PRINT-FILE.
           
           READ DATA-FILE
               AT END MOVE 'Y' TO EOF-FLAG
           END-READ.

           PERFORM 100-LOAD-TABLE
               UNTIL EOF-FLAG = 'Y'
 
           PERFORM 200-PRINT-REPORT.
           

           CLOSE DATA-FILE
                 PRINT-FILE.

           GOBACK.
       
       
      *****************************************************************
      *  100-LOAD-TABLE reads the required data from the input file   *
      *     and loads it into the database using the DL/I interface.  *
      *     once EOF is reached 'y' is moved to EOF-FLAG              *
      *                                                               *
      *****************************************************************

       100-LOAD-TABLE. 


           EVALUATE SEGMENT-TYPE
              WHEN 1
                    MOVE 'HOTEL' TO GEN-SEG-NAME
                    MOVE REST-OF-DATA TO I-O-AREA
                    CALL 'CBLTDLI' USING ISRT
                                       PCB-MASK
                                       I-O-AREA
                                       GEN-SSA
                  IF STATUS-CODE NOT = '  '
                     DISPLAY 'ERROR IN HOTELS'
                     DISPLAY STATUS-CODE
                  ELSE
                     ADD 1 TO NUM-HOTELS   
                  END-IF
              WHEN 2
                    MOVE 'RATES' TO GEN-SEG-NAME
                    MOVE REST-OF-DATA TO I-O-AREA
                    CALL 'CBLTDLI' USING ISRT
                                        PCB-MASK
                                        I-O-AREA
                                        GEN-SSA
                    IF STATUS-CODE NOT = '  '
                        DISPLAY 'ERROR IN RATES'
                        DISPLAY STATUS-CODE
                    ELSE
                        ADD 1 TO NUM-RATES
                    END-IF
              WHEN 3
                    MOVE 'DAYS' TO GEN-SEG-NAME
                    MOVE REST-OF-DATA TO I-O-AREA
                    
                    CALL 'CBLTDLI' USING ISRT
                                        PCB-MASK
                                        I-O-AREA
                                        GEN-SSA
                    IF STATUS-CODE NOT = '  '
                        DISPLAY 'ERROR IN DAYS'
                        DISPLAY STATUS-CODE
                    ELSE
                        ADD 1 TO NUM-DAYS
                    END-IF
              WHEN 4
                    MOVE 'ROOMS' TO GEN-SEG-NAME
                    MOVE REST-OF-DATA TO I-O-AREA
                    
                    CALL 'CBLTDLI' USING ISRT
                                        PCB-MASK
                                        I-O-AREA
                                        GEN-SSA
                    IF STATUS-CODE NOT = '  '
                        DISPLAY 'ERROR IN ROOMS'
                        DISPLAY STATUS-CODE
                    ELSE
                        ADD 1 TO NUM-ROOMS
                    END-IF
              WHEN 5
                    MOVE 'CUSTOMER' TO GEN-SEG-NAME
                    MOVE REST-OF-DATA TO I-O-AREA
                    
                    CALL 'CBLTDLI' USING ISRT
                                        PCB-MASK
                                        I-O-AREA
                                        GEN-SSA

                    IF STATUS-CODE NOT = '  '
                        DISPLAY 'ERROR IN CUSTOMER'
                        DISPLAY STATUS-CODE
                    ELSE
                        ADD 1 TO NUM-CUSTOMER
                    END-IF
                    
              WHEN 6
                    MOVE 'CHARGES' TO GEN-SEG-NAME
                    MOVE REST-OF-DATA TO I-O-AREA
                    
                    CALL 'CBLTDLI' USING ISRT
                                        PCB-MASK
                                        I-O-AREA
                                        GEN-SSA

                    IF STATUS-CODE NOT = '  '
                        DISPLAY 'ERROR IN CHARGES'
                        DISPLAY STATUS-CODE
                    ELSE
                        ADD 1 TO NUM-CHARGES
                    END-IF
           END-EVALUATE.    
                                       
           ADD 1 TO TOTAL-SEGMENTS.


           READ DATA-FILE
               AT END MOVE 'Y' TO EOF-FLAG
           END-READ.

           EJECT

      *****************************************************************
      *  200-PRINT-REPORT  prints the page header, columns headers    *
      *         as well as the number of segments of each type that   *
      *         that have been inserted into the database.            *
      *                                                               *
      *****************************************************************

       200-PRINT-REPORT. 

           MOVE 1 TO PR-PAGE.
           WRITE PRINT-LINE FROM PRETTY AFTER ADVANCING PAGE.
           WRITE PRINT-LINE FROM HEADERS1 
                    AFTER ADVANCING 3 LINES.
          
           WRITE PRINT-LINE FROM HEADERS2.
           WRITE PRINT-LINE FROM DASHED-LINE.

           MOVE NUM-HOTELS TO DATA-HOTELS.
           MOVE NUM-RATES TO DATA-RATES.
           MOVE NUM-DAYS TO DATA-DAYS.
           MOVE NUM-ROOMS TO DATA-ROOMS.
           MOVE NUM-CUSTOMER TO DATA-CUSTOMER.
           MOVE NUM-CHARGES TO DATA-CHARGES.
           MOVE TOTAL-SEGMENTS TO DATA-TOTALS.


           WRITE PRINT-LINE FROM DATA1.



           EJECT

/*
//*********************************************************************
//* STEP5 USES THE IMSSEG85 (IMS SIMULATOR LINK-EDIT AND GO) TO       *
//*       LINK EDIT THE COMPILED COBOL PROGRAM, DBD, AND PSB, TO      *
//*       CREATE AN IMS APPLICATION MODULE AND WILL THEN RUN          *
//*       THE IMS SIMULATOR PROGRAM TO EXECUTE THE APPLICATION        *
//*       MODULE.                                                     *
//*                                                                   *
//*   DDNAMES:                                                        *
//*                                                                   *
//*                                                                   *
//*********************************************************************
//*
//STEP5 EXEC IMSSEG85,COND=(0,NE),LOADMEM='(BUSDBD)',
//            PSBNAME=BUSPSB,WRITE='(BUSDBD.PUNCH)'
//PGMLINK.SYSLIN  DD
//       DD *
       ENTRY DLITCBL
/*
//DBDLINK.SYSLIN DD  *
      INCLUDE DBDLIB(BUSDBD)
      NAME BUSDBD
/*
//DBDLINK.DBDLIB DD DSN=Z002161.DBDPDS,DISP=SHR,UNIT=DISK, 
//         VOL=SER=ACA301
//PSBLINK.SYSLIN DD DSN=Z002161.DBDPDS(BUSPSB),DISP=SHR,UNIT=DISK,
//         VOL=SER=ACA301
//IMS.PUNCH DD DSN=Z002161.DBFILE,UNIT=DISK,VOL=SER=ACA301,
//         DISP=(NEW,KEEP,KEEP),SPACE=(TRK,(1,1)),
//         DCB=(LRECL=80,BLKSIZE=800,RECFM=FB)
//IMS.SYSOUT DD SYSOUT=*
//IMS.LOADDATA DD DSN=T90MBM1.HOTEL.DATA1,DISP=SHR
//IMS.REPORT DD SYSOUT=*
//*
//STEP6 EXEC DFSDUMP,COND=(0,NE),DBD=BUSDBD
//*********************************************************************
//*                                                                   *
//* STEP6 DUMPS THE IMS DATABASE IN HIERACHAL SEQUENCE                *
//*                                                                   *
//* DDNAME                  FILE DESCRIPTION                          *
//*                                                                   *
//* DFSDUMP.SYSUT1  INPUT:  CONTAINS THE IMS DATABASE TO BE PRINTED   *
//*                                                                   *
//*********************************************************************
//DFSDUMP.SYSUT1 DD DSN=Z002161.DBFILE,UNIT=DISK,VOL=SER=ACA301,
//         DISP=(OLD,KEEP,KEEP)
//

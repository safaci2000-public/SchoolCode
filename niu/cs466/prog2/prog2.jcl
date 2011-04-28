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
//STEP1 EXEC ASM
//*********************************************************************
//*                                                                   *
//* STEP1 EXECUTES THE ASSEMBLER PROCEDURE ASM TO DEFINE THE USERS    *
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
         PCB     TYPE=DB,DBDNAME=BUSDBD,PROCOPT=G,KEYLEN=14
         SENSEG  NAME=HOTEL,PARENT=0                                    
         SENSEG  NAME=RATES,PARENT=HOTEL                                
         SENSEG  NAME=DAYS,PARENT=HOTEL                                 
         SENSEG  NAME=ROOMS,PARENT=DAYS                                 
         SENSEG  NAME=CUSTOMER,PARENT=HOTEL                             
         SENSEG  NAME=CHARGES,PARENT=CUSTOMER                           
         PCB     TYPE=DB,DBDNAME=BUSDBD,PROCOPT=G,KEYLEN=14
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
//* STEP3 COMPILES THE COBOL PROGRAM THAT PRINTS THE QUEUED UP DATA   *
//*        BASED ON THE TRANSACTION CODE READ IN FROM THE TRAN-FILE.  *
//*                                                                   *
//* DDNAME              FILE DESCRIPTION                              *
//*                                                                   *
//* COB.SYSIN   INPUT:  INSTREAM DATA THAT CONTAINS THE COBOL PROGRAM *
//*                                                                   *
//*********************************************************************
//COB.SYSIN DD *

      *******************************************************************
      * module name:   assign2                                          *
      *                                                                 *
      * function:      this program will print reports based on the     *
      *                transaction file.  It will queue up the          *
      *                appropriate data from the IMS db and print it    *
      *                in the usual user-friendly manner.               *
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
               10  TR1-DATE            PIC X(8).
               10                      PIC X(71).
           05  TRAN-TWO REDEFINES TRAN-INFO.
               10  TR2-JUNK            PIC X(79).
           05  TRAN-THREE REDEFINES TRAN-INFO.
               10  TR3-HOTEL-ID        PIC 9(3).
               10  TR3-ROOM-TYPE       PIC X.
               10  TR3-SMOKING         PIC X.
               10  TR3-DATE            PIC X(8).
               10                      PIC X(66).
           05  TRAN-FOUR REDEFINES TRAN-INFO.
               10  TR4-JUNK            PIC X(79).
           05  TRAN-FIVE REDEFINES TRAN-INFO.
               10  TR5-HOTEL-CITY      PIC X(15).
               10  TR5-DATE            PIC X(8).
               10  TR5-POOL            PIC X.
               10  TR5-PETS            PIC X.
               10  TR5-FOOD            PIC X.
               10  TR5-LAUNDERY        PIC X.
               10  TR5-WEIGHT          PIC X.
               10  TR5-ROOM-TYPE       PIC X.
               10  TR5-SMOCKING        PIC X.
               10                      PIC X(49).
             
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
           05  RM-SMOCKING             PIC X.
           05  RM-BOOKED               PIC X.
           05  RM-GUARANTE             PIC X.
           05  RM-FILLED               PIC X.
           05  RM-CUSTNUM              PIC X(3).
           05                          PIC X(69).
       01  I-O-CUSTOMER REDEFINES I-O-AREA.
           05  C-CNUM                  PIC 9(3).
           05  C-CLNAME                PIC X(15).
           05  C-CFNAME                PIC X(15).
           05  C-DISCTYPE              PIC X.
           05                          PIC X(45).
       01  I-O-CHARGES REDEFINES I-O-AREA.
           05  CH-CHRGDATE             PIC X(8).
           05  CH-CHRGTYPE             PIC X.
           05  CH-CHRGAMT              PIC 9(3)V99.
           05  CH-CHRDISC              PIC 9(3)V99.    
           05                          PIC X(60).

       01  I-O-AREA2.
           05  HOTEL-AERA              PIC X(25).
           05  CUST-AREA.
               10  CUST-NUM            PIC X(3).
               10  CUST-FNAME          PIC X(15).
               10  CUST-LNAME          PIC X(10).
               10  CUST-DISC-TYPE      PIC X.
       
       01  EOF-FLAG                    PIC X          VALUE 'N'.
       
       01  TOTAL-CHARGES               PIC 9(5)       VALUE IS ZERO.
           
       01  GEN-SSA.
           05  GEN-SEG-NAME                PIC X(8).
           05                              PIC X      VALUE SPACE.
           
       01  GEN-SSA2.
           05  GEN2-SEG-NAME               PIC X(8).
           05  GEN2-PARM                   PIC X(2)   VALUE '*D'.
           05                              PIC X      VALUE SPACE.

      
       01  QU-HOTEL-SSA.
           05                          PIC X(8) VALUE 'HOTEL'.
           05                          PIC X    VALUE '('.
           05                          PIC X(8) VALUE 'IDNUM   '.
           05                          PIC X(2) VALUE '= '.
           05  HOTEL-ID                PIC X(5) VALUE SPACES.
           05                          PIC X    VALUE ')'.
        
       01  QU-CUST-SSA.
           05                          PIC X(8) VALUE 'CUSTOMER'.
           05                          PIC X    VALUE '('.
           05                          PIC X(8) VALUE 'CNUM'.
           05                          PIC X(2) VALUE '= '.
           05  CUST-SSA-IN             PIC X(3) VALUE SPACES.
           05                          PIC X    VALUE ')'.
           
       01  ROOMNUM                 PIC X(3) VALUE SPACES.    
       01  QU-ROOMS-SSA.
           05                          PIC X(8) VALUE 'ROOMS'.
           05                          PIC X    VALUE '('.
           05                          PIC X(8) VALUE 'FILLED'.
           05                          PIC X(2) VALUE '= '.
           05  IN-RESPONSE             PIC X    VALUE 'Y'.
           05                          PIC X    VALUE ')'.
           

       01  QU-DAYS-SSA.
           05                          PIC X(8) VALUE 'DAYS'.
           05                          PIC X    VALUE '('.
           05                          PIC X(8) VALUE 'DATE'.
           05                          PIC X(2) VALUE '= '.
           05  IN-DATE                 PIC X(8) VALUE SPACES.
           05                          PIC X    VALUE ')'.
       01  DISC-TYPE-SSA.
           05                          PIC X(8)       VALUE 'CUSTOMER'.
           05                          PIC X          VALUE '('.
           05                          PIC X(8)       VALUE 'DISCTYPE'.
           05                          PIC X(2)       VALUE 'NE'.
           05                          PIC X(4)       VALUE 'S'.
           05                          PIC X          VALUE ')'.
           

       01  ISRT                        PIC X(4)       VALUE 'ISRT'.
       01  GU                          PIC X(4)       VALUE 'GU  '.
       01  GN                          PIC X(4)       VALUE 'GN  '.
       01  GNP                         PIC X(4)       VALUE 'GNP '.     


      *****************************************************************
      * DETAIL LINES DECLARATIONS used to print the different values  *
      *    obtained from our beloved IMS.                             *
      *****************************************************************
       01  TRANSACTION-HEADING.
           05                       PIC X(20)  
                            VALUE IS 'TRANSACTION TYPE: '.
           05  TRAN-NUM             PIC 9.
           
       01  TRAN-4-DETAIL.
           05                       PIC X(15)  VALUE IS 'HOTEL ID:'.
           05  TR4D-HOTEL           PIC ZZ9.
           05                       PIC X(15)  
                            VALUE IS 'FIRST NAME: '.
           05  TR4D-FNAME           PIC X(15).
           05                       PIC X(15)  
                        VALUE IS 'LAST NAME: '.
           05  TR4D-LNAME           PIC X(15).
           05                       PIC X(15) VALUE IS 'CHARGES:'.
           05  TR4D-CHARGES         PIC ZZZZ9.

      * 01  TRAN-5-DETAIL.

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


      *****************************************************************
      * 000-MAIN controls the flow of the proram,                     *
      *                                                               *
      *                                                               *
      *                                                               *
      *                                                               *
      *****************************************************************

       000-MAIN. 
           ENTRY 'DLITCBL' USING PCB-MASK PCB-MASK2.
           
           OPEN INPUT TRAN-FILE
                OUTPUT PRINT-FILE.
                
           READ TRAN-FILE
               AT END MOVE 'Y' TO EOF-FLAG
           END-READ.
                

           PERFORM 100-PROCESS-CODE
               UNTIL EOF-FLAG = 'Y'.
           

           CLOSE TRAN-FILE
                 PRINT-FILE.

           GOBACK.
       
       
      *****************************************************************
      *  100-PROCESS-CODE                                             *
      *                                                               *
      *                                                               *
      *                                                               *
      *****************************************************************

       100-PROCESS-CODE.    

           EVALUATE TRAN-CODE
      *        WHEN 1
      *               PERFORM 200-TRAN-TYPE1
      *        WHEN 2
      *               PERFORM 300-TRAN-TYPE2
      *        WHEN 3
      *               PERFORM 400-TRAN-TYPE3
              WHEN 4
                     PERFORM 500-TRAN-TYPE4
      *        WHEN 5
      *               PERFORM 600-TRAN-TYPE5
      *        WHEN OTHER
      *            DISPLAY 'ERROR.  INVALID TRAN CODE READ IN' 
           END-EVALUATE.

           READ TRAN-FILE
               AT END MOVE 'Y' TO EOF-FLAG
           END-READ.

           EJECT
      *****************************************************************
      *                                                               *
      *                                                               *
      *                                                               *
      *****************************************************************

       200-TRAN-TYPE1.      

           MOVE 'HOTEL' TO GEN2-SEG-NAME.    
           MOVE 'DAYS' TO GEN-SEG-NAME.
           MOVE TR1-DATE TO IN-DATE.
           
           DISPLAY 'TRAN RECORD IS:  '  TRAN-RECORD.
           
           DISPLAY 'GEN-SSA:  '  QU-DAYS-SSA.
           DISPLAY 'GEN-SSA2: '  GEN-SSA2.
           
           CALL 'CBLTDLI' USING GU
                                PCB-MASK
                                I-O-AREA
                                GEN-SSA2  
                                QU-DAYS-SSA.

           DISPLAY 'STATUS CODE IS:  '  STATUS-CODE.
           DISPLAY I-O-AREA.
           DISPLAY 'STATUS CODE 2 IS:  '  STATUS-CODE2.
           
      *     PERFORM UNTIL STATUS-CODE = 'GB'
              CALL 'CBLTDLI' USING GN
                            PCB-MASK
                            I-O-AREA
                            QU-ROOMS-SSA
              END-CALL.
              
              DISPLAY 'I-O-AREA AFTER GNP'  I-O-AREA STATUS-CODE.
              MOVE I-O-AREA(1:3) TO ROOMNUM.
      *        PERFORM UNTIL STATUS-CODE2 NOT = '  '
                  
      *            CALL 'CBLTDLI' USING GU
      *                          PCB-MASK2
      *                          I-O-AREA
      *                          GEN-SSA2  
      *                          QU-DAYS-SSA
      *            END-CALL                
      *        END-PERFORM


      *        IF STATUS-CODE = '  '
      *             DISPLAY I-O-AREA
      *        ELSE
      *             DISPLAY 'ERROR' STATUS-CODE
      *        END-IF
           
      *     END-PERFORM.
                      

           EJECT


      *****************************************************************
      *                                                               *
      *                                                               *
      *                                                               *
      *****************************************************************

       300-TRAN-TYPE2.      

           
           MOVE SPACES TO GEN-SEG-NAME.
           MOVE SPACES TO I-O-AREA.
           
           CALL 'CBLTDLI' USING GU
                                PCB-MASK
                                I-O-AREA.
                                
           IF STATUS-CODE NOT = '  '
                DISPLAY 'THERE IS A STUPID FUCKING ERROR.'  STATUS-CODE
           END-IF.

                                
           PERFORM UNTIL STATUS-CODE = 'GB'
                DISPLAY I-O-AREA
                MOVE SPACES TO I-O-AREA
                
                CALL 'CBLTDLI' USING GN
                                     PCB-MASK
                                     I-O-AREA
                END-CALL
           END-PERFORM.

           EJECT


      *****************************************************************
      *                                                               *
      *                                                               *
      *                                                               *
      *****************************************************************

       400-TRAN-TYPE3.      

           DISPLAY 'ENTERED 400-TRAN-TYPE3'.             

           EJECT
      *****************************************************************
      *  MAKING MY LIFE MISERABLE, GIVING HEADACHES AND SUPPOSEDLY    *
      *   PRINTING ALL CUSTOMERS THAT HAVE A CHARGE GREATER THEN      *
      *   $1000 ACCUMULATED.                                          *
      *****************************************************************

       500-TRAN-TYPE4.      

           MOVE SPACES TO I-O-AREA2.
           MOVE 'HOTEL' TO GEN2-SEG-NAME.    
           MOVE 'CUSTOMER' TO GEN-SEG-NAME.
           
           CALL 'CBLTDLI' USING GU
                                PCB-MASK
                                I-O-AREA2
                                GEN-SSA2  
                                GEN-SSA.
           DISPLAY 'STATUS CODE IS:  '  STATUS-CODE  I-O-AREA2.

           PERFORM UNTIL STATUS-CODE  = 'GB'
                MOVE 0 TO TOTAL-CHARGES          
                MOVE SPACES TO I-O-AREA
                IF CUST-DISC-TYPE IS EQUAL 'S'
                
                MOVE 'CHARGES' TO GEN-SEG-NAME

                CALL 'CBLTDLI'  USING GN
                                PCB-MASK
                                I-O-AREA
                                GEN-SSA
                END-CALL
      *          DISPLAY 'I-O-AREA AFTER 1ST GNP IS:  '  I-O-AREA
                
                PERFORM UNTIL STATUS-CODE  = '  '
                    ADD CH-CHRGAMT TO TOTAL-CHARGES
                    MOVE SPACES TO I-O-AREA
                    
                    MOVE 'CHARGES' TO GEN-SEG-NAME
                    MOVE SPACES TO I-O-AREA
                    CALL 'CBLTDLI'  USING GNP
                                    PCB-MASK
                                    I-O-AREA
                                    GEN-SSA
                    END-CALL
      *              DISPLAY 'I-O-AREA AFTER 2ND GNP IS: ' I-O-AREA 
                END-PERFORM
                
                IF TOTAL-CHARGES > 1000
                        MOVE TOTAL-CHARGES TO TR4D-CHARGES
                        MOVE CUST-NUM TO TR4D-HOTEL
                        MOVE CUST-FNAME TO TR4D-FNAME
                        MOVE CUST-LNAME TO TR4D-LNAME
                        WRITE PRINT-LINE FROM TRAN-4-DETAIL 
                            AFTER ADVANCING 2 LINES
                        END-WRITE
                END-IF
              END-IF

             MOVE 'HOTEL' TO GEN2-SEG-NAME
             MOVE 'CUSTOMER' TO GEN-SEG-NAME
             
             CALL 'CBLTDLI' USING GN
                                PCB-MASK
                                I-O-AREA2
                                GEN-SSA2
                                GEN-SSA
             END-CALL
      *       DISPLAY 'I-O-AREA AFTER GN IS:  ' I-O-AREA STATUS-CODE

            END-PERFORM.

           EJECT

      *****************************************************************
      *                                                               *
      *                                                               *
      *                                                               *
      *****************************************************************

       600-TRAN-TYPE5.      

           DISPLAY 'ENTERED 600-TRAN-TYPE5'.

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
//STEP5 EXEC IMSSEG85,COND=(0,NE),PSBNAME=BUSPSB
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
//IMS.BUSDBD DD DSN=Z002161.DBFILE,UNIT=DISK,DISP=SHR,VOL=SER=ACA301
//*
//IMS.SYSOUT DD SYSOUT=*
//IMS.TRANDATA DD DSN=T90MBM1.HOTEL.DATA2,DISP=SHR
//IMS.REPORT DD SYSOUT=*
//

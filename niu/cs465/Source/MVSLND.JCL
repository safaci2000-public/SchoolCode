//Z002161A JOB ,'Samir Faci',REGION=2048K,LINES=5
/*JOBPARM ROOM=161
//*
//*
//COMPILE  PROC CREG=248K,CDISP=(NEW,PASS,DELETE),COBJ=&&OBJSET,
//      CPARM=
//*******************************************************************
//* Purpose of this jobs is to execute the cobol main pgm and print
//* out reports concerning the tiddly-wins tournament
//* aka. step below calls the IGYCRCTL cobol compiler
//*******************************************************************
//   EXEC PGM=IGYCRCTL,REGION=&CREG,
//      PARM='TEST,APOST,&CPARM'
//*******************************************************************
//* STEPLIB:  INPUT:  LOCATION OF THE COBOL COMPILER.
//* SYSLIN    OUTPUT:    OBJECT MODULE TO PASS TO LOADER           
//* SYSPRINT  OUTPUT:    SOURCE LISTING AND DIAGNOSTIC MESSAGES    
//*
//*******************************************************************
//STEPLIB DD  DSN=SYS2.ADCOBOL.V110.SIGYCOMP,DISP=SHR
//SYSLIN  DD  DSN=&COBJ,UNIT=PUB,
//        SPACE=(TRK,(3,3)),DISP=&CDISP
//SYSLIB  DD  DSN=T90RAZ1.C465S02.COPYLIB,DISP=SHR
//SYSPRINT DD SYSOUT=*
//*******************************************************************
//*                                                                 *
//*  THE FOLLOWING DATA SETS ARE REQUIRED BY THE COMPILER.          *
//*                                                                 *
//*******************************************************************
//SYSUT1   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT2   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT3   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT4   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT5   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT6   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//SYSUT7   DD  UNIT=PUB,SPACE=(CYL,(1,1))
//         PEND
//*
//*
//STEP1    EXEC PROC=COMPILE,COBJ=&&SUBPGM,CREG=2048K,
//      CPARM='LIB,FLAG(E,E)'
//SYSIN    DD  *
      *******************************************************************
      * Module Name:   SUBPGM                                           *
      *                                                                 *
      * Function:     to be an absolutely pointless waste of paper      *
      *               and space.  actually it increments the page count *
      *               by 20.                                            *
      *                                                                 *
      * Input:        NONE.                                             *
      *                                                                 *
      *                                                                 *
      * Output:        NONE.                                            *
      *                                                                 *
      * Notes:        POINTLESSSSSS                                     *
      *                                                                 *
      *******************************************************************
       IDENTIFICATION DIVISION.
 
       PROGRAM-ID.  SUBPGM.
 
       ENVIRONMENT DIVISION.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRINT-FILE     ASSIGN      TO PRINTER.
 
           EJECT

       DATA DIVISION.


       FILE SECTION.

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
      *                                                                 *
      * NO VARS                IN WORKING STORAGE                       *
      * PAGE-COUNT         KEEPS TRACK OF # OF PAGES (INCREMENTED)      *
      *                                                                 *
      *******************************************************************
       LINKAGE SECTION.


       01  PAGE-COUNT                  PIC 999.

       PROCEDURE DIVISION USING PAGE-COUNT.


      *******************************************************************
      * 000-MAIN controls the flow of the program.                      *
      * merges the 2 tables and sets the merged-count to the correct    *
      * value.                                                          *
      *                                                                 *
      *******************************************************************
 
       000-MAIN.
 
           ADD 20 TO PAGE-COUNT.


           GOBACK.

           EJECT


//LINKED  PROC  LOBJ=&&OBJSET,LDISP=(OLD,DELETE,DELETE),
//        LPARM=,LREG=2048K,LCOND=
//****************************************************************
//* step4 creates the load module.
//*                                                               
//*                                                               
//****************************************************************
//    EXEC PGM=HEWL,REGION=&LREG,
//        COND=&LCOND,PARM='&LPARM'
//****************************************************************
//* SYSLIN   INPUT:  object modules to be linked and run
//* SYSLIB   INPUT:  library files needed by loader.
//* SYSLMOD  OUTPUT: a temporary pds
//****************************************************************
//SYSLIN  DD  DSN=&LOBJ,DISP=&LDISP
//*
//SYSLIB  DD  DSN=SYS2.LE370.V111.SCEELKED,DISP=SHR
//SYSLMOD DD  DSN=Z002161.MIRC(SUBPGM),DISP=(NEW,KEEP,KEEP),
//      UNIT=DISK,VOL=SER=ACA301,SPACE=(1024,(50,20,1))
//SYSPRINT DD SYSOUT=*
//SYSUT1   DD UNIT=PUB,SPACE=(TRK,(10,10))
//         PEND
//*
//*
//STEP2    EXEC PROC=LINKED,LREG=1024K,LCOND=(0,GT),
//      PARM='MAP,LIST,AMODE(24)',LOBJ=&&SUBPGM
//

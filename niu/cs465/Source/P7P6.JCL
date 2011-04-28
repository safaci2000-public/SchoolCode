//Z002161A JOB ,'Samir Faci',REGION=2048K,LINES=5
/*JOBPARM ROOM=161
//*
//*
//****************************************************************
//* STEP DEFINES THE LIBRARY WHERE THE PROCEDURES ARE LOCATED @  *
//*                                                              *
//****************************************************************
//STEP0 JCLLIB  ORDER=(Z002161.CS465.LIB)
//*
//****************************************************************
//* STEP1 CALLS THE COMPILE PROCEDURE.                           *
//*                                                              *
//****************************************************************
//STEP1    EXEC COMPILE,COBJ=&&OBJMOD,CREG=2048K,
//      CPARM='LIB,FLAG(E,E),NOSOURCE'
//PROC1.SYSLIB DD  DSN=T90RAZ1.C465S02.COPYLIB,DISP=SHR
//*
//SYSIN    DD  DSN=Z002161.CS465.SOURCE,DISP=(OLD,PASS,KEEP),
//     UNIT=DISK,VOL=SER=ACA301
//*
//****************************************************************
//* STEP2 CALLS THE LINKED  PROCEDURE.                           *
//*                                                              *
//****************************************************************
//STEP2    EXEC LINKED,LREG=3000K,LCOND=(0,GT),
//      LPARM='MAP',LOBJ=&&OBJMOD,
//      LOPT=//TERMTHDACT(DUMP),FREG=2048K,FCOND=(4,LT),
//      LPDS='&&LOADLIB'
//*
//PROC3.STEPLIB DD
//          DD
//          DD  DSN=Z002161.MIRC(SUBPGM),DISP=(OLD,KEEP,KEEP),
//      UNIT=DISK,VOL=SER=ACA301
//PROC3.SYSUDUMP DD DUMMY
//****************************************************************
//*                                                              *
//*  THE FOLLOWING DATA SETS ARE REQUIRED BY THE COBOL PROGRAM.  *
//*                                                              *
//*  BOOK1      INPUT:     1ST RECORD OF BOOKS INFO              *
//*  BOOK2      INPUT:     2ND RECORD OF BOOKS INFO              *
//*  WKFILE     TEMP:      USED IN SORTING                       *
//*  WKFILE2    TEMP:      USED IN THE 2ND SORT                  *
//*  WKFILE3    TEMP:      USED IN MERGE OF RECORD               *
//*  MERGE      IN/OUT:    PRODUCT OF MERGE                      *
//*                                                              *
//*  PRINTER    OUTPUT:    USED IN PROGRAM TO WRITE REPORT.      *
//*                                                              *
//****************************************************************
//PROC3.BOOK1 DD DSN=T90RAZ1.C465S02.A6BOOKS1,DISP=SHR
//PROC3.BOOK2 DD DSN=T90RAZ1.C465S02.A6BOOKS2,DISP=SHR
//PROC3.PRINTER DD SYSOUT=*
//PROC3.WKFILE  DD DSN=&&WKFILE,DISP=NEW,UNIT=PUB
//PROC3.WKFILE2 DD  DSN=&&WKFILE2,DISP=NEW,UNIT=PUB
//PROC3.SORT1   DD  DSN=&&SORT1,DISP=NEW,UNIT=PUB
//PROC3.SORT2   DD  DSN=&&SORT2,DISP=NEW,UNIT=PUB
//PROC3.MERGE1  DD  DSN=&&MERGE,DISP=NEW,UNIT=PUB
//PROC3.WKFILE3 DD  DSN=&&WKFILE3,DISP=NEW,UNIT=PUB
//PROC3.SYSOUT  DD  DSN=&&GARBAGE,DISP=(NEW,DELETE),UNIT=PUB,
//      SPACE=(TRK,(1,1))
//****************************************************************
//* UTILITY RUNS WHICH UNCATALOGS THE PROCEDURE LIBRARIES AS     *
//* WELL AS DELETE THE SOURCE PERMENANT DATA SET.                *
//****************************************************************
//CLEAN    EXEC  PGM=IEFBR14
//DELETE1  DD    DSN=Z002161.CS465.SOURCE,UNIT=DISK,
//            VOL=SER=ACA301,DISP=(OLD,DELETE,DELETE)
//UNCAT    DD    DSN=Z002161.CS465.LIB,UNIT=DISK,
//            VOL=SER=ACA301,DISP=(OLD,UNCATLG,KEEP)
//DELETE2  DD    DSN=Z002161.CS465.LIB,UNIT=DISK,
//            VOL=SER=ACA301,DISP=(OLD,DELETE,DELETE)
//

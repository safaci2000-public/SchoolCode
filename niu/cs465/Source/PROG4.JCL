//Z002161A JOB ,'Samir Faci'
/*JOBPARM ROOM=161
//*******************************************************************
//* Purpose of this jobs is to execute a cobol program and print
//* out reports concerning the tiddly-wins tournament
//* aka. step below calls the IGYCRCTL cobol compiler
//*******************************************************************
//STEP1   EXEC PGM=IGYCRCTL,REGION=2048K,
//      PARM='MAP,TEST,APOST,VBREF,FLAG(W,W),LIST,XREF'
//*******************************************************************
//* STEPLIB:  INPUT:  LOCATION OF THE COBOL COMPILER.
//* SYSLIB:   INPUT:  TEMPORARY FILE WHICH STORES THE SOURCE'S 
//*                   OBJECT MODULE
//* SYSIN:    INPUT:  SOURCE CODE
//*
//* SYSLIN    OUTPUT:    OBJECT MODULE TO PASS TO LOADER           
//* SYSPRINT  OUTPUT:    SOURCE LISTING AND DIAGNOSTIC MESSAGES    
//*
//*******************************************************************
//STEPLIB DD  DSN=SYS2.ADCOBOL.V110.SIGYCOMP,DISP=SHR
//SYSLIN  DD  DSN=&&OBJMOD,UNIT=PUB,
//        SPACE=(TRK,(3,3)),DISP=(NEW,PASS,DELETE)
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
//SYSIN    DD  DSN=T90RAZ1.ASS4CODE,VOL=SER=ACA301,DISP=SHR,
//      UNIT=DISK






//*
//****************************************************************
//* step2 executes the object modules, and runs the program.      
//*                                                               
//*                                                               
//****************************************************************
//STEP2   EXEC PGM=HEWLDRGO,REGION=2048K,
//        COND=(0,GT),PARM='MAP,LET//TERMTHDACT(DUMP)'
//****************************************************************
//* SYSLIN   INPUT:  LOCATION OF OBJECT MODULES TO BE EXECUTED.
//* STEPLIB  INPUT:  LIB NEEDED BY THE LOADER PROGRAM.
//* SYSLIB   INPUT:  SYSTEM LIB NEEDED BY PROGRAM. 
//* SYSLOUT  OUTPUT: LOADER MSGS AND ERROR MESSAGES.                                                              
//****************************************************************
//SYSLIN  DD  DSN=&&OBJMOD,UNIT=PUB,SPACE=(TRK,(3,3)),
//            DISP=(OLD,DELETE,DELETE)
//STEPLIB DD  DSN=SYS2.LE370.V111.SCEERUN,DISP=SHR
//SYSLIB  DD  DSN=SYS2.LE370.V111.SCEELKED,DISP=SHR
//SYSLOUT DD  SYSOUT=*
//****************************************************************
//*                                                              *
//*  THE FOLLOWING DATA SETS ARE REQUIRED BY THE COBOL PROGRAM.  *
//*                                                              *
//*  NAME       INPUT:     NAME OF TEAMS AND SCHOOLS             *
//*  SCORE      INPUT:     SCORES RECORD AND OBTAINED IN TOURN.  *
//*                                                              *
//*  PRINTER    OUTPUT:    USED IN PROGRAM TO WRITE REPORT.      *
//*                                                              *
//****************************************************************
//MYINPUT DD  DSN=T90RAZ1.ASS4DATA,VOL=SER=ACA301,DISP=SHR,
//      UNIT=DISK
//MYOUTPUT DD SYSOUT=*
//

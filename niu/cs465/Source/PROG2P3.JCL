//Z002161A JOB ,'Samir Faci'
/*JOBPARM ROOM=161
//*******************************************************************
//* Purpose of this jobs is to execute the object module store in 
//* the PDS location specified.
//*******************************************************************
//STEP1   EXEC PGM=MEM1,REGION=1024K
//*******************************************************************
//* STEPLIB:  INPUT:  PDS LOCATION CONTAINING LOAD MODULE.
//*******************************************************************
//STEPLIB DD  DSN=Z002161.MYPDS,DISP=(OLD,DELETE),
//        UNIT=DISK,VOL=SER=ACA302,SPACE=(1024,(50,20,1))
//        DD  DSN=SYS2.LE370.V111.SCEERUN,DISP=SHR
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
//SCORE   DD  DSN=T90RAZ1.C465S02.SCORFILE,DISP=SHR
//NAME    DD  DSN=T90RAZ1.C465S02.NAMEFILE,DISP=SHR
//PRINTER DD  SYSOUT=*
//*
//*******************************************************************
//* Fail safe steps w/h makes sure that the PDS was indeed deleted.
//*******************************************************************
//STEP2   EXEC PGM=IEFBR14
//REMOVE  DD   DSN=Z002161.MYPDS,UNIT=DISK,
//        VOL=SER=ACA302,DISP=(OLD,DELETE,DELETE)
//

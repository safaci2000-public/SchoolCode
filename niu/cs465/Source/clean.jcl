//Z002161A JOB ,'Samir Faci',REGION=2048K,LINES=5
/*JOBPARM ROOM=161
//*
//*
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

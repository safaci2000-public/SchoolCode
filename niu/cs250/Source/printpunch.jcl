//Z002161A JOB ,'Samir Faci'
/*JOBPARM ROOM=161
//    EXEC PGM=IEBPTPCH
//SYSPRINT DD SYSOUT=*
//SYSUT1 DD DSN=T90ASS1.SPRING01.COBDATA(DATA05),DISP=SHR
//SYSUT2 DD SYSOUT=*
//SYSIN DD *
      PRINT MAXFLDS=1
      RECORD FIELD=(80)
/*
//
 
/*
//GO.SYSIN  DD DSN=T90ASS1.SPRING01.COBDATA(DATA05),DISP=SHR
//GO.SYSOUT DD SYSOUT=*
//


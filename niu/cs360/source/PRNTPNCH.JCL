//Z002161A JOB ,'SAMIR FACI'
/*JOBPARM  NOLOG,ROOM=161
//PRINT    EXEC  PGM=IEBPTPCH
//SYSPRINT DD SYSOUT=*
//SYSUT1   DD DSN=T90MES1.C360(DATA8),DISP=SHR
//SYSUT2   DD SYSOUT=*
//SYSIN    DD *
    PRINT   MAXFLDS=1
    RECORD  FIELD=(80,1,,1)
/*
//

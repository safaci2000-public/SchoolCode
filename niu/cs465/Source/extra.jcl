//Z002161A JOB ,'Samir Faci',REGION=2048K,LINES=5
/*JOBPARM ROOM=161
//*
//*******************************************************************
//*
//*     SORRY ABOUT THE DETAILED DOCS, BUT THE CS DEPT DOES KEEP ON
//*     STRESSING US TO DOC...AND WELL....I WAS BORED...AND WHEN I'M
//*     BORED AND I'M SITTING AT A COMPUTER...VERY WEIRD THINGS HAPPEN
//*     IN THIS CASE... 
//*             A STORY LINE WHICH HOPEFULLY WILL NEVER BE PUBLISHED
//*******************************************************************
//*******************************************************************
//* STEP1 PRINTS THE DATA USING THE DEFAULT FORMAT OF IEBPTPCH
//*  
//*    INPUT:    SYSUT1:  INPUT FILE FROM MVSLAND.
//*    OUTPUT:   SYSUT2:  SENDS OUTPUT TO STDOUT.
//*******************************************************************
//STEP1   EXEC  PGM=IEBPTPCH
//SYSUT1  DD    DSN=T90HCH1.CSCI465.SPRING02.EXTRA.OLDUSER,DISP=SHR
//SYSUT2  DD    SYSOUT=*
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
  PRINT  TYPORG=PS,
         MAXFLDS=1,
         CNTRL=1
  TITLE  ITEM=('OLD USER DATA',40)      /* prints a nice header */
//*
//*
//*******************************************************************
//* STEP2 RE-ARRANGES CERTAIN FIELDS WITHIN THE INPUT FILE
//*   USING THE IEBGENER UTILITY.
//*
//*     INPUT:  SYSUT1:   INPUT FILE FROM MVSLAND
//*     OUTPUT: SYSUT2:   A FILE ON MY ACCT ON MVS LAND
//*  
//*******************************************************************
//STEP2   EXEC  PGM=IEBGENER
//SYSUT1  DD    DSN=T90HCH1.CSCI465.SPRING02.EXTRA.OLDUSER,DISP=SHR
//SYSUT2  DD    DSN=Z002161.OLDCOPY,DISP=(NEW,KEEP,DELETE),
//      UNIT=DISK,VOL=SER=ACA301,SPACE=(CYL,(1,1)),
//       DCB=(LRECL=52,BLKSIZE=5200,RECFM=FB)
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
  GENERATE MAXFLDS=8
    RECORD FIELD=(7,30,,1),     /* logon id */
           FIELD=(10,11,,8),    /* first name */
           FIELD=(10,1,,18),    /* last name */
           FIELD=(8,37,,28),    /* password */
           FIELD=(9,21,,36),    /* id       */
           FIELD=(1,51,,45),    /* credit rating */
           FIELD=(6,45,,46)     /* acct balance */
/*
//*******************************************************************
//* STEP3 CONVERTS NEWUSER DATASET TO MATCH THE FORMAT OF OLDUSER
//*    AND STORES RESULT UNDER MY OWN ACCT ON MVSLAND.
//*
//*    INPUT:  SYSUT1:  ANOTHER INPUT FILE FROM MVSLAND.
//*    OUTPUT: SYSUT2:  A NOTHER FILE ON MY ACCT ON MVS LAND
//*  
//*******************************************************************
//STEP3    EXEC   PGM=IEBGENER
//SYSUT1   DD     DSN=T90HCH1.CSCI465.SPRING02.EXTRA.NEWUSER,DISP=SHR
//SYSUT2   DD     DSN=Z002161.NEWCOPY,DISP=(NEW,KEEP,DELETE),
//      UNIT=DISK,VOL=SER=ACA301,SPACE=(CYL,(1,1)),
//       DCB=(LRECL=52,BLKSIZE=5200,RECFM=FB)
//SYSPRINT DD     SYSOUT=*
//SYSIN     DD    *
  GENERATE MAXFLDS=9,MAXLITS=15
    RECORD FIELD=(1,25,,1),     /* FIRST INITIAL ADDED TO ID */
           FIELD=(1,15,,2),     /* LAST NAME INIT. ADDED TO ID */
           FIELD=(5,10,,3),     /* 5 CHAR ID APPENDED TO INITS */
           FIELD=(10,25,,8),    /* FIRST NAME */
           FIELD=(10,15,,18),   /* LAST NAME */
           FIELD=(8,'LETMEIN!',,28), /* DEFAULT PASSWORD */
           FIELD=(9,1,,36),          /* ID */
           FIELD=(1,'0',,45),        /* CREDIT RATING */
           FIELD=(6,'000000',,46)    /* ACCT BALANCE */
/*
//*******************************************************************
//* STEP4 CONCATENATES THE TWO FILES TOGETHER AND SORT THEM IN 
//*   ASCENDING ORDER BASED ON THE FIRST NAME
//*
//*     INPUT:  SORTIN:  2 FILES ON MY ACCT IN THE TRECHEROUS 
//*                                           ABYSS OF LAND.
//*     OUTPUT: SORTOUT:  A TEMP FILE IN THE PIT OF DARKNESS (MVSLAND)
//*     TEMP:   SORTWK01:  A TEMP FILE USED FOR SORTING.
//*
//*******************************************************************
//STEP4   EXEC  PGM=SYNCSORT,PARM='CMP=CLC'
//SORTIN  DD    DSN=Z002161.OLDCOPY,DISP=(OLD,DELETE,DELETE),
//    UNIT=DISK,VOL=SER=ACA301
//        DD    DSN=Z002161.NEWCOPY,DISP=(OLD,DELETE,DELETE),
//    UNIT=DISK,VOL=SER=ACA301
//SORTOUT DD    DSN=&&SORTED,UNIT=PUB,DISP=(NEW,PASS,DELETE),
//      SPACE=(TRK,(1,1))
//SORTOUT DD    SYSOUT=*
//SYSOUT   DD    SYSOUT=*
//SORTWK01 DD   DSN=&&SORTWK,UNIT=PUB,DISP=(NEW,DELETE),
//      SPACE=(TRK,(1,1))
//SYSIN    DD   *
  SORT   FIELDS=(1,7,CH,A)
/*
//*******************************************************************
//* STEP5 COPIES THE TEMPORARY FILE FROM THE PIT OF DARKNESS (MVSLAND)
//*             PACKES THE TRECHEROUS PRE-HISTORIC CREATURES LEFT 
//*             OVER FROM THE DAYS WHEN COBOL RULED THE LAND 
//*             (NUMERICAL VALUES) AND GIVES THEM A NEW SHAPE WITH 
//*             THE HOPE OF A POSSIBLE BRIGHT FUTURE (PACKED DECIMAL)
//*
//*             INPUT:   SYSUT1:  A TEMP FILE FROM THE PIT 
//*                                     OF DARKNESS (MVSLAND)
//*             OUTPUT:  SYSUT2:  A FILE ON MY ACCT UPON THE 
//*                  THE FORGOTTEN PAST, WHICH ALL HOPE TO FORGET
//*                     BUT FEW TRULLY DO, SINCE IT HOVERS OVER
//*                     US REMINDING US OF OUR PAST, SOMEWHERE 
//*                     BETWEEN A REPRESSED MEMORY AND THE HUMAN
//*                     UNCONSCIOUSNESS LIES THE HEXED FILE KNOWN
//*                     AS Z002161.PACKED
//*******************************************************************
//STEP5    EXEC   PGM=IEBGENER
//SYSUT1   DD     DSN=&&SORTED,DISP=(OLD,DELETE,DELETE)
//SYSUT2   DD     DSN=Z002161.PACKED,DISP=(NEW,PASS,DELETE),
//      UNIT=DISK,VOL=SER=ACA301,SPACE=(CYL,(1,1)),
//       DCB=(LRECL=46,BLKSIZE=4600,RECFM=FB)
//SYSPRINT DD     SYSOUT=*
//SYSIN     DD    *
  GENERATE MAXFLDS=9,MAXLITS=15
    RECORD FIELD=(7,1,,1),      /* logon id */
           FIELD=(10,8,,8),     /* first name */
           FIELD=(10,18,,18),   /* last name */
           FIELD=(8,28,,28),    /* password */
           FIELD=(9,36,ZP,36),  /* packs id# */
           FIELD=(1,45,ZP,41),  /* packs credit rating */
           FIELD=(6,46,ZP,42)   /* packs acct. balance */
/*
//*******************************************************************
//*  STEP6  PRINTS THE FILE IN HEXADECIMAL FORMAT USING HIS TRUSTED
//*             WEAPON OF MIGHT, EXCALIBUR AKA. IEBPTPCH.
//*                     
//*     SYSUT1:  IN THE ABYSS LIES THE PACKED FILE SOMEWHERE ON MY
//*                     ACCT ON MVSLAND.
//*     OUTPUT:  THE COURAGEOUS HERO, WITH BRAVELY AND PROPERLY 
//*                 DOCUMENTED JCL SYNTAX PRINTS UNLEASHES THE TRUTH
//*                 UPON THE MASSES IN AN ANCIENT LANGUAGE KNOW TO
//*                 ON A SELECT FEW MEMBERS OF A GOVERNING ARISTOCARY
//*                  RULING THE LAND.
//*                     THE FEW REMAINING PRACTIONER OF THESE DARK
//*                     ARTS ARE KNOWN AS COMPUTER SCIENCE MAJORS
//*                        WHO HAVE THE UNKANY ABILITY TO UNDERSTAND
//*                        MACHINES AND READ THIS DARK AND SINISTER
//*                        LANGUAGE KNOWN AS HEXADECIMAL.
//*
//*             prints in hex to screen.
//*******************************************************************
//STEP6   EXEC  PGM=IEBPTPCH
//SYSUT1  DD    DSN=Z002161.PACKED,DISP=(OLD,PASS,DELETE),
//     UNIT=DISK,VOL=SER=ACA301
//SYSUT2  DD    SYSOUT=*
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
   PRINT  TYPORG=PS,            /* DEFINES THE TYPE OF FILE */
          TOTCONV=XE,           /* CONVERTS TO HEX */
          MAXFLDS=1,            /* SETS THE MAXFLDS */
          CNTRL=1               /* SINGLE SPACES */
   TITLE  ITEM=('PACKED FILE IN HEX',20)        /* PRINTS TITLE */
   RECORD FIELD=(45,1,XE,1)     /* CONVERTS TO HEX AGAIN */
/*
//*
//*
//*******************************************************************
//* STEP7 THE MIGHTY HERO WITH THE HELP OF THE DARK WORKS OF THE 
//*     DARK AND WISE COMPUTER SCIENCE MAJORS DECRYPTED THE 
//*     ANCIENT HYROGLYPHICS TO REVEAL THE TRUTH TO ALL THE MASSES
//*         AKA CONVERTING IT TO ZONE FOR EVERY1 TO READ USING
//*         IEBPTPCH.
//*
//*   INPUT:   SYSUT1:  FILE FROM MVS LAND.
//*   OUTPUT:  SYSUT2:  A TEMP FILE FROM MVSLAND.
//*******************************************************************
//STEP7   EXEC  PGM=IEBPTPCH
//SYSUT1  DD    DSN=Z002161.PACKED,DISP=SHR,
//     UNIT=DISK,VOL=SER=ACA301
//SYSUT2  DD    DSN=&&PACKED,DISP=(NEW,PASS,DELETE),UNIT=PUB,
//       DCB=(LRECL=58,BLKSIZE=5800,RECFM=FB)
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
   PRINT  TYPORG=PS,            /* DEFINES TYPE OF FILE */
          MAXFLDS=8,            /* SETS MAX # OF FIELDS */
          CNTRL=1               /* SINGLE SPACES */
    RECORD FIELD=(7,1,,1),      /* LOGIN ID */
           FIELD=(10,8,,8),     /* FIRST NAME */
           FIELD=(10,18,,18),   /* LAST NAME */
           FIELD=(8,28,,28),    /* PASSWORD */
           FIELD=(5,36,PZ,36),  /*   ID     */
           FIELD=(1,41,PZ,46),  /*  CREDIT BALANCE */
           FIELD=(4,42,PZ,48)   /*  ACCT. BALANCE */
/*
//*
//*
//*******************************************************************
//* STEP8 ONCE THE TRUTH WAS REVEALED IT MUST BE RE-CONSTRUCTED 
//*             SO THE EVEN THE COMMON MAN MAY UNDERSTAND IT 
//*             SIGNIFICANE AND IT'S IMPACT UPON HIS LIFE AND
//*             THE LIVES OF THE PEOPLE IN THE COMING GENERATION
//*         IT HAS BEEN PREDICTED, AND SO IT SHALL BE, THE AGE
//*             DARKNESS HAS COME TO AN END, ALL HAIL MVS!!!!!
//*              (INSERTS DASHED, $, REMOVES CARRIAGE RETURNS,
//*               ETC TO MAKE IT LOOK NEAT AND EASY TO READ )
//*
//*  INPUT:  SYSUT1:   TEMP FILE FROM MVS LAND
//*  OUTPUT:  SYSUT2:  TO A FILE ON MY Z# ACCT IN THE MIDDLE OF 
//*                     THE TOWN SQUARE FOR ALL TO READ.
//*******************************************************************
//STEP8   EXEC  PGM=IEBGENER
//SYSUT1  DD    DSN=&&PACKED,DISP=(OLD,DELETE,DELETE),UNIT=PUB
//SYSUT2  DD    DSN=Z002161.NEATCOPY,DISP=(NEW,PASS,DELETE),
//       UNIT=DISK,VOL=SER=ACA301,SPACE=(CYL,(1,1)),
//       DCB=(LRECL=58,BLKSIZE=5800,RECFM=FB)
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
  GENERATE MAXFLDS=13,MAXLITS=4
    RECORD FIELD=(35,2,,1),              /* moves char data */
           FIELD=(3,37,,37),            /* first 3 digits */
           FIELD=(1,'-',,40),           /* insert dash */
           FIELD=(2,40,,41),            /* secnd 2 digits */
           FIELD=(1,'-',,43),           /* insert dash */           
           FIELD=(4,42,,44),            /* last 4 digits */           
           FIELD=(2,48,,48),            /* Credit rating */           
           FIELD=(1,'$',,50),           /* insert $ sign */
           FIELD=(4,50,,51),            /* first 3 nums */
           FIELD=(1,'.',,55),           /* insert decimal point */
           FIELD=(3,54,,56)             /* insert last 2 digits */
/*
//*
//*******************************************************************
//* STEP9.   AS THE TRUTH WAS UNVEILED IT MUST NOW BE PRESERVED,
//*             SO IT HAS BEEN DECREED BY THE POWER TO BE, AND SO
//*             IT SHALL.  THE KNOWLEDGE SHALL BE PLACED UPON
//*               THE MUSEUM OF KNOWLEDGE TO BE KEPT FOR ALL TIME
//*                  OR UNTIL THE PAPER IT WAS PRINTED ON IS RECYCLED
//*             IN OTHER WORDS, IT'S PRINTED TO SCREEN WITH NEAT
//*                     HEADERS TO MAKE IT EASY TO READ.
//*
//*     INPUT:  FILE FROM THE ABYSS OF MVS LAND ON MY Z# ACCT.
//*     OUTPUT:  TO SCREEN (THE MUSEUM OF KNOWLEDGE)
//*******************************************************************
//STEP9   EXEC  PGM=IEBPTPCH
//SYSUT1  DD    DSN=Z002161.NEATCOPY,DISP=(OLD,KEEP,DELETE),
//      UNIT=DISK,VOL=SER=ACA301,
//       DCB=(LRECL=58,BLKSIZE=5800,RECFM=FB)
//SYSUT2  DD    SYSOUT=*
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
  PRINT  TYPORG=PS,
         MAXFLDS=15,
         CNTRL=1
  TITLE  ITEM=('NEAT COPY PRT',20)      /* BASIC HEADER */
  TITLE  ITEM=('LOGONID     ',1),       /* COLUMN HEADERS */
         ITEM=('FIRST NAME',15),        /* COLUMN HEADERS */
         ITEM=('LAST NAME',30),         /* COLUMN HEADERS */
         ITEM=('PASSWORD',45),          /* COLUMN HEADERS */
         ITEM=('  ID',58),              /* COLUMN HEADERS */
         ITEM=('RATING',75),            /* COLUMN HEADERS */
         ITEM=('BALANCE',85)            /* COLUMN HEADERS */
  RECORD FIELD=(7,1,,1),     /* LOGON ID */
         FIELD=(10,8,,15),   /* FIRST NAME */
         FIELD=(10,18,,30),  /* LAST NAME */
         FIELD=(8,28,,45),   /* PASSWORD */
         FIELD=(12,36,,58),  /* ID      */
         FIELD=(2,48,,75),  /* CREDIT RATING */
         FIELD=(9,50,,85)   /* BALANCE */
/*
//*******************************************************************
//* STEP10.   THE AGE OF DARKNESS HAS COME TO AN END, THE MIGHTY 
//*             HERO GROWING RESTLESS FROM THE PEACE AND QUITE
//*             GOES IN SEARCH OF NEW ADVENTURES.
//*               HIS SEARCH CENTERING AROUND THE MYTHOLOGICAL
//*                  STORES OF PDS, AN ENTITY OF SUCH POWER AND 
//*                  SUCH DARNESS, THAT EVEN THE BRAVEST SOULS
//*                  DARE ONLY WHISPER OF ITS EXISTANCE FOR FEAR
//*                  OF THE REPRECAUTIONS IT MIGHT CREATE.
//*
//*     CREATES A PDS FILE AND 3 MEMBERS BASED ON SPECIFIC
//*             DELIMITERS (SEE INSTREAM DATA FOR MORE INFO)
//*             USING IEBGENER
//*
//*
//*     INPUT:  FILE FROM THE UNKNOWN ABYSS OF MVSLAND 
//*                     (T90HCH1.CSCI465.SPRING02.EXTRA.DATA)
//*     OUTPUT:  TO A MYTHICAL PDS ON MY OWN ACCT
//*
//*  NOTE:  THE HERO IS SHOCKED AND OVERWHELMED TO THE ASTONISHING
//*             DISCOVERY THAT THE LEGENDARY PDS DO EXIST INDEED.
//*******************************************************************
//STEP10   EXEC  PGM=IEBGENER
//SYSUT1   DD    DSN=T90HCH1.CSCI465.SPRING02.EXTRA.DATA,DISP=SHR
//SYSUT2   DD    DSN=Z002161.SOMEPDS,DISP=(NEW,PASS,DELETE),
//        SPACE=(CYL,(1,1,1)),UNIT=DISK,VOL=SER=ACA301,
//       DCB=(LRECL=43,BLKSIZE=4300,RECFM=FB)
//SYSPRINT DD    SYSOUT=*
  GENERATE MAXFLDS=13,MAXLITS=4,MAXNAME=3,MAXGPS=3
    MEMBER NAME=FIRST
    RECORD IDENT=(5,'!!!!!',6)  /* MARKS THE END OF THE 1ST MEM */
    MEMBER NAME=SECOND
    RECORD IDENT=(8,'????????',36) /* MARKS END OF 2ND MEMBER */
    MEMBER NAME=THIRD
/*
//*******************************************************************
//* STEP11  WITH THE HELP OF HIS FAITHFUL COMPANION (IEBPTPCH) THE 
//*             THE MIGHT HERO TELLS THE TRUTH TO THE PEOPLE IN AN
//*             EASY TO READ FORMATED PERFECTED BY THE DARK DAYS
//*             OF COBOL.
//*
//*     INPUT:  THE PDS FILE CREATED IN STEP10
//*     OUTPUT: THE TOWN SQUARE AKA...TO SCREEN.
//*******************************************************************
//STEP11  EXEC  PGM=IEBPTPCH
//SYSUT1  DD    DSN=Z002161.SOMEPDS,DISP=(OLD,KEEP,DELETE),
//      UNIT=DISK,VOL=SER=ACA301,
//       DCB=(LRECL=43,BLKSIZE=4300,RECFM=FB)
//SYSUT2  DD    SYSOUT=*
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
  PRINT  TYPORG=PO,     /* DEFINE THE TYPE OF FILE */
         MAXFLDS=1,    /* DEFINE MAX # OF FIELDS */
         CNTRL=1       /* SINGLE SPACES OUTPUT */
         RECORD FIELD=(43,1,,1)         
  TITLE  ITEM=('MEMBER OF THE PDS SOMEPDS',1)      
/*
//*******************************************************************
//* STEP12 THE PEOPLE AND THE HERO COUNT AND INSPECT THE PDS USING
//*     THE TOWN WISEMAN (IE. IEHLIST)TO MAKE SURE THAT ALL MEMBERS 
//*     WHICH HAVE BEEN FORTOLD IN THE STORIES ARE INDEED PRESSEN IN
//*            THE PDS.
//*
//*     INPUT:  PDS FROM MY Z# (Z002161.SOMEPDS)
//*     OUTPUT: TO SCREEN
//*******************************************************************
//STEP12   EXEC  PGM=IEHLIST
//SYSPRINT DD    SYSOUT=*
//ANY1     DD    UNIT=DISK,VOL=SER=ACA301,SPACE=(TRK,0),DISP=OLD
//SYSIN    DD     *
   LISTPDS    DSN=Z002161.SOMEPDS,VOL=DISK=ACA301,DUMP
/*
//*******************************************************************
//* STEP13 A FEW THINGS SEEMED DIFFERENT, THIS WAS NOT THE PDS OF 
//*     OLD, A SEARCH WAS MOUNTED USING THE FAMOUS IEBCOPY TRACKER
//*     TO FIND THE TRUE PDS.
//*
//*     INPUT:  A FILE FROM MVSLAND NOT MY OWN.
//*     OUTPUT: A PDS FILE ON MY Z# ACCT. ON MVSLAND
//*
//* THE TRUE PDS OF LEGENDS WAS FOUND AND THE PEOPLE REJOICED.
//*******************************************************************
//STEP13   EXEC  PGM=IEBCOPY
//INFILE    DD    DSN=T90HCH1.CSCI465.SPRING02.EXTRA.LIB,DISP=SHR
//OUTFILE   DD    DSN=Z002161.SOMEPDS,DISP=(OLD,PASS,DELETE)
//SYSPRINT  DD    SYSOUT=*
//SYSIN     DD    *
  COPY  INDD=INFILE,OUTDD=OUTFILE
  SELECT  MEMBER=((NEWFIRST,FIRST,R),(SECOND,,R),(FOURTH,,R))
/*
//*******************************************************************
//* STEP14 THE TOWN WISEMEN (IEHLIST) MADE SURE THAT THE PDS 
//*             RECOVERED WAS INDEED THE PDS OF OLD AND UPON 
//*             CONFIRMATION THE PEOPLE REJOICED.
//*
//*     INPUT:    Z002161.SOMEPDS
//*     OUTPUT:   TO THE TOWNSQUARE (TO SCREEN)
//*******************************************************************
//STEP14   EXEC  PGM=IEHLIST
//SYSPRINT DD    SYSOUT=*
//ANY1     DD    UNIT=DISK,VOL=SER=ACA301,SPACE=(TRK,0),DISP=OLD
//SYSIN    DD     *
   LISTPDS    DSN=Z002161.SOMEPDS,VOL=DISK=ACA301,DUMP
/*
//*******************************************************************
//* STEP15 THE VERIFIED PDS OF OLD WAS PUT ON DISPLAY ON THE TOWN 
//*             SQUARE FOR EVERYONE TO SEE WITH THE HELP OF THE 
//*             MIGHT IEBPTPCH, A WISEMAN AMONG THE WISE.
//*
//*       INPUT:  Z002161.SOMEPDS
//*       OUTPUT: TO THE TOWNSQUARE (TO SCREEN)
//*******************************************************************
//STEP15  EXEC  PGM=IEBPTPCH
//SYSUT1  DD    DSN=Z002161.SOMEPDS,DISP=(OLD,KEEP,DELETE),
//      UNIT=DISK,VOL=SER=ACA301,
//       DCB=(LRECL=43,BLKSIZE=4300,RECFM=FB)
//SYSUT2  DD    SYSOUT=*
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
  PRINT  TYPORG=PO,
         MAXFLDS=15,
         CNTRL=1
         RECORD FIELD=(43,1,,1)         
  TITLE  ITEM=('MEMBER OF THE PDS SOMEPDS',1)      
/*
//*******************************************************************
//*  AFTER THE REJOICEMENT, THE DARK NATURE OF THE NEW FINDS CAME 
//*     FORTH, AND AFTER A FIERCE BATTLE THE MIGHT WARRIORS VANQUISHED
//*     THE PDS ALL ENTITIES OF MVSLAND WERE PUT TO REST FOREVER
//*         NEVER TO BE SEEN OR HEARD AGAIN (HOPEFULLY THAT SHALL 
//*             APPLY TO MY CASE AS WELL )
//*     
//*     IN CASE ALL THE METAPHORS WEREN'T OBVIOUS THIS STEP DELETES
//*             ALL THE FILES CREATED BY THE MANY STEPS IN THIS 
//*             PROGRAM.
//*******************************************************************
//STEP16   EXEC  PGM=IEFBR14
//DELETE1  DD    DSN=Z002161.PACKED,UNIT=DISK,
//            VOL=SER=ACA301,DISP=(OLD,DELETE,DELETE)
//DELETE2  DD    DSN=Z002161.NEATCOPY,UNIT=DISK,
//            VOL=SER=ACA301,DISP=(OLD,DELETE,DELETE)
//DELETE3  DD    DSN=Z002161.SOMEPDS,DISP=(OLD,DELETE,DELETE),
//            UNIT=DISK,VOL=SER=ACA301
//
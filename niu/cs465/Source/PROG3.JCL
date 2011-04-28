//Z002161A JOB ,'Samir Faci',REGION=2048K
/*JOBPARM ROOM=161
//*******************************************************************
//* Purpose of this jobs is to execute a ASM   program and print
//* out reports concerning the tiddly-wins tournament
//* aka. step below calls the ASMA90   ASSEMBLY COMPILER
//*******************************************************************
//STEP1    EXEC PGM=ASMA90,REGION=512K
//*******************************************************************
//* SYSLIB:   INPUT:  LIBRARIES USED BY THE COMPILERS        
//* SYSIN:    INPUT:  SOURCE CODE
//*
//* SYSLIN    OUTPUT:    OBJECT MODULE TO PASS TO LOADER           
//* SYSPRINT  OUTPUT:    SOURCE LISTING AND DIAGNOSTIC MESSAGES    
//*
//*******************************************************************
//SYSLIB   DD   DSN=SYS2.MACLIB,DISP=SHR
//         DD   DSN=SYS1.MACLIB,DISP=SHR
//         DD   DSN=T90CSCI.CSCI464.MACLIB,DISP=SHR
//SYSLIN   DD   DSN=&&OBJMOD,UNIT=PUB,SPACE=(TRK,(3,3)),
//       DISP=(NEW,PASS,DELETE)
//SYSPRINT DD   SYSOUT=*
//*******************************************************************
//*                                                                 *
//*  THE FOLLOWING DATA SETS ARE REQUIRED BY THE COMPILER.          *
//*                                                                 *
//*******************************************************************
//SYSUT1   DD   DSN=&&SYSUT1,UNIT=PUB,SPACE=(CYL,(1,1))
//SYSIN    DD   *
         TITLE 'SAMIR FACI CSCI 465 SECTION 1 ASSIGNMENT 3'
***********************************************************************
*                                                                     *                     
*                         CSCI 465 Program 3                          *                     
*                                                                     *                     
* Function:  Read in school names and team names as well as scores    *                     
*            print school & team name if avg score is >= 84 to a temp *                     
*            file.  Retrieve data and print again.  As usual all      *                     
*            data is printed in the most boring business reports      *                     
*            imaginable, all in the sake of boring the programmer to  *
*            tears.                                                   *
*                                                                     *
* Input:     NAMEFILE && SCOREFILE && TEMPFILE                        *                     
*                                                                     *                     
* Output:    To OUTFILE && TEMPFILE                                   *                     
*                                                                     *                     
* Entry                                                               *                     
* Conds:     None (This routine is not called as a subroutine)        *                     
*                                                                     *                     
* Exit                                                                *                     
* Conds:     None (This routine does not return parameters)           *                     
*                                                                     *                     
* Program Logic:                                                      *                     
*                                                                     *                     
*                                                                     *                     
* Register                                                            *                     
* Usage:       R1      STORES PARAM ADDRESS                           *                     
*              R15     STANDARD LINKAGE                               *                     
*              R12     STANDARD LINKAGE                               *                     
*                                                                     *                     
*         R14,R13,R15  USED FOR EXTERNAL SUBROUTINES LINKING          *                     
* NOTES:                                                              *                     
***********************************************************************                     
MAIN     CSECT
*ENTRY LINKAGE                                                                              
         STM   R14,R12,12(R13)   SAVES ALL REGS.                                            
         LR    R12,R15           GETS BASE REGISTER                                                   LA    R11,4095(,R15)    ESTABLISHES LINKAGE                                        
         LA    R11,1(,R11)       ESTABLISHES LINKAGE                                        
         USING MAIN,R12,R11      USING R15 & R12                                            
         LA    R14,MAINSAVE      GETS STORAGE ADDRESS                                       
         ST    R13,4(R14)        SAVES BACKWARD POINTER                                      
         ST    R14,8(R13)        SAVES FORWARD POINTER                                       
         LR    R13,R14           GET STORAGE @ IN 13
         PGMDUMP                 DOES THE FUNKY DANCE IF PGM ABENDS
         PRINT NOGEN             DOES NOT EXPEND MACROS.
*BUILD                                                                                      
         LA    R1,BLDPARM       LOADS ADDRESS OF PARAMETERS LIST                            
         L     R15,=V(BUILD)    STORES ADDRESS INTO R15                                     
         BALR  R14,R15          BRANCHES TO BUILD AND BUILDS 1ST TABLE
*PRT
         LA    R1,BLDPARM       LOADS ADDRESS OF PARAMETERS LIST                            
         L     R15,=V(PRT)      STORES ADDRESS INTO R15
         BALR  R14,R15          BRANCHES TO BUILD AND BUILDS 1ST TABLE
*
*EXIT LINKAGE
         L     R13,4(R13)        GETS BACKWARD POINTER
         LM    R14,R12,12(R13)   RESTORES REGISTERS...
         BR    R14               RETURNS TO CALLER                                          
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
***********************************************************************                     
*                                                                                           
*                          STORAGE AREA                                                     
*                                                                                           
***********************************************************************                     
MAINSAVE DS    18F                      SAVES REGS
NAMESTBL DS    250F                     NAMES TABLE (SCHOOL & TEAM)
SCORETBL DS    100F                     SCORES TABLE
BLDPARM  DC    A(NAMESTBL,SCORETBL)     PARM LIST TO PRT & BUILD


***********************************************************************
*       NAME:           BUILD                                         *                     
*       FUNCTION:       TO BUILD THE 2 TABLES USING IN THIS PROGRAM   *                     
*       INPUT:          2 FILES ON DISK.                              *                     
*       OUTPUT:         NONE                                          *                     
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *                     
*       REGISTER USE:   R1 - PARM LIST                                *                     
*                       R10- BACKUP FOR PARM LIST.                    *
*                       R2 - ADDRESS OF TABLE.                        *
*       PSEUDOCODE:     DO WHILE NOT EOF                              *                     
*                        ENTER RECORD INTO THE TABLE.                 *                     
*                       ON EOF, EXIT LOOP AND RETURN TO MAIN.         *                     
*                               AND REPEAT                            *
*                                                                     *
*       NOTES:                                                        *                     
***********************************************************************                     
BUILD    CSECT                                                                              
*ENTRY                                                                                      
         STM   R14,R12,12(R13)  SAVES ALL REGS.                                             
         LR    R12,R15          GETS BASE REGISTER                                          
         USING BUILD,R12        ESTABLISHES ADDRESIBILITY                                   
         LA    R14,BLDSAVE      LOADS & OF BLDSAVE INTO R14                                 
         ST    R13,4(R14)       SAVES BACKWARD POINTER                                      
         ST    R14,8(R13)       SAVES FORWARD POINTER                                       
         LR    R13,R14          GET STORAGE IN R13                                          
         LR    R10,R1           SAVES PARM LIST IN R10
*CODE HERE
         OPEN  (INNAM,(INPUT))   OPENS NAME FILE
         L     R2,0(R10)         LOADS @ OF NAMESTBL INTO R2
         DO WHILE,(CLC,EOFFLAG,NE,=C'Y') WHILE !EOF DO LOOP
         GET   INNAM,0(R2)               READ NEXT RECORD.
         LA    R2,100(R2)                LOADS NEXT ADDRESS INTO R2
         ENDDO                           END LOOP
         CLOSE INNAM                     CLOSE NAME FILE
         MVI   EOFFLAG,C'N'              RE-INITIALIZE EOFFLAG TO N
         L     R2,4(R10)                 LOAD @ OF SCORETBL INTO R2
         OPEN  (INSCORE,(INPUT))         OPEN INSCORE FOR INPUT
         IF    (LTR,R15,R15,NZ)          CHECKS FOR VALID RETURN
                ABEND 465,DUMP           IF INVALID, ABEND 465
         ENDIF                           END IF LOOP
*
*
         DO WHILE,(CLC,EOFFLAG,NE,=C'Y') WHILE !EOF DO LOOP
         GET   INSCORE                   READ NEXT RECORD.
         PACK  0(2,R2),0(3,R1)           PACK 1ST 4 VALUES INTO TABLE
         PACK  2(2,R2),3(3,R1)
         PACK  4(2,R2),6(3,R1)
         PACK  6(2,R2),9(3,R1)
*
         PACK  8(2,R2),12(3,R1)          PACK NEXT VALUES INTO TABLE
         PACK  10(2,R2),15(3,R1)
         PACK  12(2,R2),18(3,R1)
         PACK  14(2,R2),21(3,R1)
*
         PACK  16(2,R2),24(3,R1)
         PACK  18(2,R2),27(3,R1)         PACK NEXT VALUES INTO TABLE
         PACK  20(2,R2),30(3,R1)
         PACK  22(2,R2),33(3,R1)
*
         PACK  24(2,R2),36(3,R1)
         PACK  26(2,R2),39(3,R1)
         PACK  28(2,R2),42(3,R1)         PACK NEXT VALUES INTO TABLE.
         PACK  30(2,R2),45(3,R1)
         LA    R2,32(R2)                 LOAD NEXT @ INTO R2
         ENDDO                           END LOOP
         CLOSE INSCORE
*END CODE HERE
ENDBLD   DS    0H
         L     R13,4(R13)        GETS BACKWARD POINTER                                      
         LM    R14,R12,12(R13)   RESTORES REGS.                                             
         BR    R14               BRANCHES BACK TO MAIN                                      
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
BLDSAVE  DS    18F               USED TO BACKUP REGISTERS                                   
EOFFLAG  DC    C'N'
*
*
EOFRTN   DS    0H
         MVI   EOFFLAG,C'Y'
         BR    R14
*
*       DCB FOR INPUT OF NAME FILE
*
INNAM    DCB   DDNAME=NAME,                                            X
               DEVD=DA,                                                X
               DSORG=PS,                                               X
               MACRF=GM,                                               X
               RECFM=FB,                                               X
               LRECL=100,                                              X
               BLKSIZE=900,                                            X
               EODAD=EOFRTN
*
*       DCB FOR INPUT OF SCORE FILES
*
INSCORE  DCB   DDNAME=SCORE,                                           X
               DEVD=DA,                                                X
               DSORG=PS,                                               X
               MACRF=GL,                                               X
               RECFM=FB,                                               X
               LRECL=48,                                               X
               BLKSIZE=432,                                            X
               EODAD=EOFRTN
*
*
***********************************************************************
*       NAME:           PRINT                                         *                     
*       FUNCTION:       TO PRINT 2 LOVELY GOREGEOUS TABLES THAT I WILL*
*                       ABSOLUTELY, NEVER, EVER, EVER, EVER, HAVE     *
*                       THE PLEASURE OF LOOKING AT AGAIN!! *sigh*     *
*                                                                     *
*       INPUT:          A FILE ON DISK                                *                     
*       OUTPUT:         NONE                                          *                     
*       ENTRY CONDS:    THE REGISTERS FROM THE PASSING PARAMETER      *                     
*       REGISTER USE:   R1 - PARM LIST                                *                     
*                       R2 - @ OF NAMETBL                             *
*                       R3 -  @ OF SCORE TBL                          *
*                       R10 - BACKUP FOR R1 (SOMETIMES)               *                     
*       PSEUDOCODE:     DO WHILE NOT EOF                              *                     
*                        PRINT RECORDS OF TABLE.                      *                     
*                       ON EOF, EXIT LOOP AND RETURN TO MAIN.         *                     
*       NOTES:          NONE                                          *                     
***********************************************************************                     
PRT      CSECT                                                                              
*                                                                                           
*ENTRY LINKAGE                                                                              
         STM   R14,R12,12(R13)   BACKS UP ALL REGISTERS.                                    
         LR    R12,R15           GETS BASE ADDRESS                                          
         USING PRT,R12           ESTABLISHES ADDRESSIBILITY                                 
         LA    R14,PRNTSAVE      STORES @ OF PRNTSAVE INTO R14                              
         ST    R13,4(R14)        STORES BACKWARD POINTER INTO R13                           
         ST    R14,8(R13)        STORES FORWARD POINTER INTO R14                            
         LR    R13,R14           GET STORAGE IN R13
         LR    R10,R1           SAVES PARM LIST IN R10
*BEGIN CODE
         MVC   UT+1(132),UT      INITIALIZES UNDERLINE PLINE.                               
         OPEN  (OUTFILE,(OUTPUT))
         OPEN  (TEMP_OUT,(OUTPUT))
         TIME  DEC               PUTS TIME INTO R1
         ST    R1,MYTIME         PUTS TIME INTO MYTIME
         MVC   MYEAR,=X'2020'    MOVES MASK
         ED    MYEAR(2),MYTIME+1  MOVES YEAR TO PLINE
         MVC   MDAYS,=X'202020'   SETS MASK
         ED    MDAYS(3),MYTIME+2  NOW I'M JUST BORED...OH YEAH..
*                                  MOVE TO PLINE
         L     R2,0(R10)         LOADS ADDRESS OF NAME TABLE INTO R2
         L     R3,4(R10)         LOADS @ OF SCORE TABLE INTO R2.
*BEGIN WHILE
         DO WHILE,(CLC,PRCNT,LT,=F'9') WHILE !EOF DO LOOP
*BEGIN IF
         IF    (CLC,PGCNT,GE,=F'2')
         MVC   PG_NUM(5),=X'4040202020' SETS UP MASK
         ED    PG_NUM(5),MYPGCNT        EDITS FIRST SCORE
         PUT   OUTFILE               GETS @ OF OUTFILE IN R1
         MVC   0(132,R1),TITLE       PRINTS TITLE
         PUT   OUTFILE               GETS @ OF OUTFILE IN R1
         MVC   0(132,R1),TITLE2      PRINTS SECONDARY TITLE
         PUT   OUTFILE               GETS @ OF OUTFILE IN R1
         MVC   0(131,R1),HEADING     PRINTS HEADING
         PUT   OUTFILE               GETS @ OF OUTFILE IN R1
         MVC   0(131,R1),HEAD2       PRINTS 2ND HEADING
         PUT   OUTFILE               GETS @ OF OUTFILE IN R1
         MVC   0(132,R1),UNDER1      PRINTS A LINE OF UNDERSCORES
         AP    MYPGCNT,=P'1'         ADD 1 TO THE PAGE COUNT
         L     R7,=F'0'              LOADS 0 INTO R7
         ST    R7,PGCNT              ZEROS PGCNT - USED FOR PAGE BREAK
*END IF
         ENDIF
        
         MVC   SCL_NAM(20),0(R2)     MOVES SCHOOL NAME TO PLINE
         MVC   TM_NAME(20),20(R2)    MOVE TEAM NAME TO PLINE
*

         MVC   DT_SCR1(5),=X'4040202020' SETS UP MASK
         ED    DT_SCR1(5),0(R3)  EDITS FIRST SCORE 
         MVC   DT_SCR2(5),=X'4040202020' SETS UP MASK
         ED    DT_SCR2(5),2(R3)  EDITS 2ND   SCORE 
         MVC   DT_SCR3(5),=X'4040202020' SETS UP MASK
         ED    DT_SCR3(5),4(R3)  EDITS 3D    SCORE 
         MVC   DT_SCR4(5),=X'4040202020' SETS UP MASK
         ED    DT_SCR4(5),6(R3)  EDITS 4TH   SCORE 
*
*
         ZAP   TEMP(6),0(2,R3)     ADDS 1ST SCORE TO TEMP NUM
         AP    TEMP(6),2(2,R3)     ADDS 2ND SCORE TO TEMP NUM
         AP    TEMP(6),4(2,R3)     ADDS 3D  SCORE TO TEMP NUM
         AP    TEMP(6),6(2,R3)     ADDS 4TH SCORE TO TEMP NUM
         DP    TEMP(6),=P'4'       DIVIDES TEMP NUM BY 4
         MVC   RESULT(2),TEMP+3    MOVES QUOTIENT INOT RESULT
         MVC   TEMP(6),=PL6'0'     ZEROES OUT TEMP
*
*
         IF    (CP,RESULT(2),GE,=P'84')  IF RESULT >= 84..DO 
         PUT   TEMP_OUT                 GETS @ OF TEMP_OUT IN R1
         MVC   0(20,R1),0(R2)           MOVES SCHOOL NAME
         MVC   20(20,R1),20(R2)         MOVES TEAM NAME
         MVC   40(2,R1),RESULT          MOVES TEAM SCORE TO TBL
         ENDIF
*
*
         MVC   DT_AVG(5),=X'4040202020'  SETS UP MASK
         ED    DT_AVG(5),RESULT         EDITS AVG SCORE
         PUT   OUTFILE                  GETS @ OF OUTFILE IN R1
         MVC   0(132,R1),DET1_RP        PRINTS DETAIL LINE 1
*
*
         MVC   TMNAME(20),40(R2)        MOVES TEAM NAME TO PLINE
         MVC   DTSCR1(5),=X'4040202020' SETS UP MASK
         ED    DTSCR1(5),8(R3)  EDITS FIRST SCORE 
         MVC   DTSCR2(5),=X'4040202020' SETS UP MASK
         ED    DTSCR2(5),10(R3)  EDITS 2ND   SCORE 
         MVC   DTSCR3(5),=X'4040202020' SETS UP MASK
         ED    DTSCR3(5),12(R3)  EDITS 3D    SCORE 
         MVC   DTSCR4(5),=X'4040202020' SETS UP MASK
         ED    DTSCR4(5),14(R3)  EDITS 4TH   SCORE 
         ZAP   TEMP(6),8(2,R3)          MOVES NUM1 TO TEMP NUM
         AP    TEMP(6),10(2,R3)         ADDS  NUM2 TO TEMP NUM
         AP    TEMP(6),12(2,R3)         ADD2  NUM3 TO TEMP NUM
         AP    TEMP(6),14(2,R3)         ADD2  NUM4 TO TEMP NUM
         DP    TEMP(6),=P'4'            DIVIDE TEMP NUM BY 4
         MVC   RESULT(2),TEMP+3         GETS RESULT INTO TEMP
         MVC   TEMP(6),=PL6'0'          ZEROS OUT TEMP
         MVC   DTAVG(5),=X'4040202020'  SETS UP MASK
         ED    DTAVG(5),RESULT         EDITS AVG SCORE
         PUT   OUTFILE                 GETS @ OF OUTFILE IN R1
         MVC   0(132,R1),DET2_RP       MOVE TO PLINE
*
*
         IF    (CP,RESULT(2),GE,=P'84') IF >= 84 DO 
         PUT   TEMP_OUT                 GETS @ OF TEMPOUT IN R1
         MVC   0(20,R1),0(R2)           MOVES SCHOOL NAME
         MVC   20(20,R1),40(R2)         MOVES TEAM NAME
         MVC   40(2,R1),RESULT          MOVES TEAM SCORE TO TBL
         ENDIF
*
*
*
*
         MVC   TMNAME(20),60(R2)        MOVE TEAM NAME TO PLINE
         MVC   DTSCR1(5),=X'4040202020' SETS UP MASK
         ED    DTSCR1(5),16(R3)  EDITS FIRST SCORE 
         MVC   DTSCR2(5),=X'4040202020' SETS UP MASK
         ED    DTSCR2(5),18(R3)  EDITS 2ND   SCORE 
         MVC   DTSCR3(5),=X'4040202020' SETS UP MASK
         ED    DTSCR3(5),20(R3)  EDITS 3D    SCORE 
         MVC   DTSCR4(5),=X'4040202020' SETS UP MASK
         ED    DTSCR4(5),22(R3)  EDITS 4TH   SCORE 
         ZAP   TEMP(6),16(2,R3)  ADD 1ST NUM TO TEMP
         AP    TEMP(6),18(2,R3)  ADD 2ND NUM TO TEMP
         AP    TEMP(6),20(2,R3)  ADD 3D  NUM TO TEMP
         AP    TEMP(6),22(2,R3)  ADD 4TH NUM TO TEMP
         DP    TEMP(6),=P'4'     DIVIDE BY 4
         MVC   RESULT(2),TEMP+3  MOVE QUOTIENT INTO RESULT
         MVC   TEMP(6),=PL6'0'   ZERO OUT TEMP
         MVC   DTAVG(5),=X'4040202020'  SETS UP MASK
         ED    DTAVG(5),RESULT         EDITS AVG SCORE
         PUT   OUTFILE            GETS @ OF OUTFILE IN R1
         MVC   0(132,R1),DET2_RP  MOVE TO PLINE
*
*
         IF    (CP,RESULT(2),GE,=P'84')  IF >= 84 DO
         PUT   TEMP_OUT                 GETS @ OF TEMPOUT IN R1
         MVC   0(20,R1),0(R2)           MOVES SCHOOL NAME
         MVC   20(20,R1),60(R2)         MOVES TEAM NAME
         MVC   40(2,R1),RESULT          MOVES TEAM SCORE TO TBL
         ENDIF

*
*
         MVC   TMNAME(20),80(R2)        MOVE TEAM NAME TO DETAIL LINE
         MVC   DTSCR1(5),=X'4040202020' SETS UP MASK
         ED    DTSCR1(5),24(R3)  EDITS FIRST SCORE 
         MVC   DTSCR2(5),=X'4040202020' SETS UP MASK
         ED    DTSCR2(5),26(R3)  EDITS 2ND   SCORE 
         MVC   DTSCR3(5),=X'4040202020' SETS UP MASK
         ED    DTSCR3(5),28(R3)  EDITS 3D    SCORE 
         MVC   DTSCR4(5),=X'4040202020' SETS UP MASK
         ED    DTSCR4(5),30(R3)  EDITS 4TH   SCORE 
         ZAP   TEMP(6),24(2,R3)  ADD NUM1 TO TEMP NUM
         AP    TEMP(6),26(2,R3)  ADD NUM2 TO TEMP NUM
         AP    TEMP(6),28(2,R3)  ADD NUM3 TO TEMP NUM
         AP    TEMP(6),30(2,R3)  ADD NUM4 TO TEMP NUM
         DP    TEMP(6),=P'4'     DIVIDE BY 4
         MVC   RESULT(2),TEMP+3  PUT QUOTIENT INTO RESULT
         MVC   TEMP(6),=PL6'0'   ZERO OUT TEMP
         MVC   DTAVG(5),=X'4040202020'  SETS UP MASK
         ED    DTAVG(5),RESULT         EDITS AVG SCORE
         PUT   OUTFILE           GETS @ OF OUTFILE IN R1
         MVC   0(132,R1),DET2_RP MOVE TO PLINE
*
*
         IF    (CP,RESULT(2),GE,=P'84') IF >= 84 DO
         PUT   TEMP_OUT                 GET @ OF TEMPOUT INTO R1
         MVC   0(20,R1),0(R2)           MOVES SCHOOL NAME
         MVC   20(20,R1),80(R2)         MOVES TEAM NAME
         MVC   40(2,R1),RESULT          MOVES TEAM SCORE TO TBL
         ENDIF
*
*
         L     R7,PRCNT                 LOAD VAL OF PRCNT INTO R7
         A     R7,=F'1'                 ADD 1 TO R7
         ST    R7,PRCNT                 STORE VAL OF R7 TO PRCNT
         L     R7,PGCNT                 LOAD PGCNT INTO R7
         A     R7,=F'1'                 ADD 1 TO PGCNT
         ST    R7,PGCNT                 UPDATE VAL OF PGCNT
         LA    R2,100(R2)               LOAD @ OF R2, 100 OFF OF R2
         LA    R3,32(R3)                LOAD @ OF R3, 32 OFF OF R3

         ENDDO


         MVC   PG_NUM(5),=X'4040202020' SETS UP MASK
         ED    PG_NUM(5),MYPGCNT        EDITS FIRST SCORE
         PUT   OUTFILE                  GETS @ OF OUTFILE IN R1
         MVC   0(132,R1),TITLE          MOVE TO PLINE
         PUT   OUTFILE                  GETS @ OF OUTFILE IN R1
         MVC   0(132,R1),TITLE3         MOVE TO PLINE
         PUT   OUTFILE                  GETS @ OF OUTFILE IN R1
         MVC   0(131,R1),HEAD3          MOVE TO PLINE
         PUT   OUTFILE                  GETS @ OF OUTFILE IN R1
         MVC   0(131,R1),HEAD4          MOVE TO PLINE
         MVC   UT2+1(70),UT2           INITIALIZES UNDERLINE PLINE.
         PUT   OUTFILE                  GETS @ OF OUTFILE IN R1
         MVC   0(100,R1),UNDER2         MOVE TO PLINE

*
*
         CLOSE TEMP_OUT         CLOSE THE TEMP INPUT FILE
*
*
         OPEN  (TEMP_IN,(INPUT))
         GET   TEMP_IN,BUFFER       GETS TEMP DATA IN BUFFER
         DO WHILE,(CLC,TEMPFLAG,NE,=C'Y') WHILE !EOF DO LOOP
         PUT   OUTFILE              PUTS @ OF OUTFILE INTO R1
         MVC   DT3NAM(20),BUFFER    PUTS TEAM NAME IN PLINE
         MVC   DT3TEAM(20),BUFFER+20 PUTS TEAM NAME IN PLINE
         MVC   DT3AVG(5),=X'4040202020'  SETS UP MASK
         ED    DT3AVG(5),BUFFER+40      EDITS AVG SCORE
         MVI   0(R1),C' '               SINGLE SPACES
         MVC   1(132,R1),DET3_RP        MOVE TO PLINE
         GET   TEMP_IN,BUFFER           GETS NEXT RECORD
         ENDDO
         CLOSE TEMP_IN
         CLOSE OUTFILE          CLOSES THE PRINT FILE

*END CODE
ENDPRT   DS    0H
*EXIT LINKAGE
         L     R13,4(R13)        GET BACKWARD POINTER                                       
         LM    R14,R12,12(R13)   RESTORES REGISTERS                                         
         BR    R14               BRANCHES BACK TO MAIN                                      
         LTORG                   FREES UP MEMORY TAKEN BY =F''
         EJECT
*
*
MYTIME   DC    CL8' '            BUFFER FOR TIME MACRO
BUFFER   DC    CL42' '           BUFFER FOR TEMP FILE
TEMP     DS    PL6               USED TO CALC AVERAGE.
RESULT   DC    PL2'0'            QUOTIENT OF TEMP CALCULATIONS
PGCNT    DC    F'2'              PAGE BREAK COUNT
MYPGCNT  DC    PL2'1'            USED TO INCREMENT PAGE
PRCNT    DC    F'0'              SCHOOL COUNT
PRNTSAVE DS    18F               USED TO BACKUP REGISTERS
PRTTEMP  DS    PL4               TEMP VAR USED TO CHECK IF VAL == -1
*
*
*
*       DCB FOR OUTFILE (PRINTER)
*
OUTFILE  DCB   DDNAME=PRINTER,                                         X
               DEVD=DA,                                                X
               DSORG=PS,                                               X
               MACRF=PL,                                               X
               RECFM=FA,                                               X
               LRECL=132,                                              X
               BLKSIZE=1320
*
*
*       DCB FOR TEMP FILE , OUTPUT
*
TEMP_OUT DCB   DDNAME=TEMPFILE,                                        X
               DEVD=DA,                                                X
               DSORG=PS,                                               X
               MACRF=PL,                                               X
               RECFM=FB,                                               X
               LRECL=42,                                               X
               BLKSIZE=4200
*
*       DCB FOR TEMP FILE, INPUT
*
TEMP_IN  DCB   DDNAME=TEMPFILE,                                        X
               DEVD=DA,                                                X
               DSORG=PS,                                               X
               MACRF=GM,                                               X
               RECFM=FB,                                               X
               LRECL=42,                                               X
               BLKSIZE=4200,                                           X
               EODAD=TEMPEOF
*
*
TEMPFLAG DC    C'N'             EOF FLAG FOR TEMP FILE
TEMPEOF  DS    0H               EOF ROUTINE
         MVI   TEMPFLAG,C'Y'
         BR    R14
*
*
*                                                                                           
*                                                                                           
***********************************************************************                     
*                                                                     *                     
*                 STORAGE BELOW SETS UP PRINT LINES                   *                     
*                                                                     *                     
***********************************************************************                     
TITLE    DC    C'1'              TITLE PRINT TITLE HEADING                                  
MYEAR    DC    CL2' '   DATE
         DC    C'.'
MDAYS    DC    CL3' '
         DC    CL4' '
         DC    CL30' '
         DC    CL36'        BIG 9 CONFERENCE            '
         DC    CL40' '          SLACK
PAGE     DC    CL10'PAGE '
PG_NUM   DC    CL5'1'
TITLE2   DC    C' '
         DC    CL40' '
         DC    CL36'         SCORE REPORT               '
         DC    CL55' '
HEADING  DC    C'-'              HEADING PRINTS COLUMN HEADINGS
         DC    CL10'SCHOOL '
         DC    CL20' '                                                                       
         DC    CL20'TEAM   '
         DC    CL10' '
         DC    CL10'GAME 1'
         DC    CL5' '
         DC    CL10'GAME 2'
         DC    CL5' '
         DC    CL10'GAME 3'
         DC    CL5' '
         DC    CL10'GAME 4'
         DC    CL5' '
         DC    CL10'AVERAGE'
HEAD2    DC    C' '              HEADING PRINTS COLUMN HEADINGS
         DC    CL10' NAME  '
         DC    CL20' '                                                                       
         DC    CL20'NAME   '
         DC    CL10' '
         DC    CL10'SCORE '
         DC    CL5' '
         DC    CL10'SCORE '
         DC    CL5' '
         DC    CL10'SCORE '
         DC    CL5' '
         DC    CL10'SCORE '
         DC    CL5' '
         DC    CL10'SCORE  '
UNDER1   DC    C' '
UT       DC    CL132'-'

DET1_RP  DC    C'-'
SCL_NAM  DC    CL20' '
         DC    CL10' '
TM_NAME  DC    CL20' '
         DC    CL10' '
DT_SCR1  DC    CL5' '
         DC    CL10' '
DT_SCR2  DC    CL5' '
         DC    CL10' '
DT_SCR3  DC    CL5' '
         DC    CL10' '
DT_SCR4  DC    CL5' '
         DC    CL10' '
DT_AVG   DC    CL10' '
*         DC    CL7' '
*
*
DET2_RP  DC    C' '
         DC    CL30' '
TMNAME   DC    CL20' '
         DC    CL10' '
DTSCR1   DC    CL5' '
         DC    CL10' '
DTSCR2   DC    CL5' '
         DC    CL10' '
DTSCR3   DC    CL5' '
         DC    CL10' '
DTSCR4   DC    CL5' '
         DC    CL10' '
DTAVG    DC    CL5' '
         DC    CL7' '
*
*
TITLE3   DC    C' '
         DC    CL40' '
         DC    CL36'       EXTRACTED SCORES REPORT      '
         DC    CL55' '
HEAD3    DC    C' '              HEADING PRINTS COLUMN HEADINGS
         DC    CL30' '                                                                       
         DC    CL20'SCHOOL '
         DC    CL10' '
         DC    CL20'TEAM  '
         DC    CL10' '
         DC    CL10'AVERAGE'
HEAD4    DC    C' '              HEADING PRINTS COLUMN HEADINGS
         DC    CL30' '                                                                       
         DC    CL20' NAME  '
         DC    CL10' '
         DC    CL20'NAME  '
         DC    CL10' '
         DC    CL10' SCORE '
UNDER2   DC    C' '
         DC    CL30' '
UT2      DC    CL70'-'
*
*
DET3_RP  DC    C' '
         DC    CL30' '
DT3NAM   DC    CL20' '
         DC    CL10' '
DT3TEAM  DC    CL20' '
         DC    CL10' '
DT3AVG   DC    CL5' '
         DC    CL36' '

*
*
R0       EQU   0                        REGISTER EQUATES FOR BETTER
R1       EQU   1                        UNDERSTANDING THE REGISTER USE
R2       EQU   2
R3       EQU   3
R4       EQU   4
R5       EQU   5
R6       EQU   6
R7       EQU   7
R8       EQU   8
R9       EQU   9
R10      EQU   10
R11      EQU   11
R12      EQU   12
R13      EQU   13
R14      EQU   14
R15      EQU   15
         END   MAIN
/*
//STEP2    EXEC  PGM=HEWLDRGO,PARM='MAP',REGION=2048K
//***************************************************************
//*                                                             *
//*  STEP GO CREATES A LOAD MODULE FROM THE OBJECT MODULE AND   *
//*  EXECUTES THE LOAD MODULE.                                  *
//*                                                             *
//*  STEPLIB   INPUT:    CSCI464 LIBRARY OF USEFUL MACROS FOR   *
//*                      STUDENTS CODING IN ASSEMBLER           *
//*  SYSLIN    INPUT:    THE OBJECT MODULE                      *
//*  SYSLIB    INPUT:    LOAD MODULE LIBRARIES NEEDED BY THE    *
//*                      LINKER                                 *
//*                                                             *
//*  SYSLMOD   OUTPUT:   THE LOAD MODULE                        *
//*  SYSPRINT  OUTPUT:   MESSAGES FROM LOADER                   *
//*                                                             *
//***************************************************************
//SYSLIN   DD    DSN=&&OBJMOD,DISP=(OLD,DELETE,DELETE)
//STEPLIB  DD    DSN=SYS2.LE370.V111.SCEERUN,DISP=SHR
//*         DD    DSN=T90CSCI.CSCI464.MACLIB,DISP=SHR
//SYSLIB   DD    DSN=SYS2.LE370.V111.SCEELKED,DISP=SHR
//         DD    DSN=SYS2.CALLIB,DISP=SHR
//SYSLOUT  DD    SYSOUT=*
//*******************************************************************
//*                                                                 *
//*  THE FOLLOWING DATA SETS ARE REQUIRED BY THE XSNAP AND PGMDUMP  *
//*  MACROS.                                                        *
//*                                                                 *
//*  XSNAPOUT  OUTPUT:   OUTPUT FROM XSNAP MACRO                    *
//*  SYS$DUMP  OUTPUT:   MESSAGES FROM PGMDUMP                      *
//*  SPX$DUMP  OUTPUT:   PROGRAM DUMP                               *
//*                                                                 *         
//*******************************************************************
//SYS$DUMP DD    SYSOUT=*
//SPX$DUMP DD    SYSOUT=*
//XSNAPOUT DD    SYSOUT=*
//*******************************************************************
//*                                                                 *
//*  THE FOLLOWING DATA SETS ARE REQUIRED BY THE PROGRAM            *
//*  MACROS.                                                        *
//*                                                                 *
//*  NAME      INPUT :   NAMES OF SCHOOL & TEAMS                    *
//*  SCORE     INPUT :   SCORES OF TEAMS                            *
//*  TEAMFILE  INPUT :   SCHOOL NAME, TEAM & AVG SCORE >=84         *
//*  TEAMFILE  OUTPUT:    ALSO USED TO OUTPUT SAME DATA.
//*                                                                 *
//*******************************************************************
//NAME     DD    DSN=T90RAZ1.C465S02.NAMEFILE,UNIT=DISK,
//      VOL=SER=ACA302,DISP=SHR
//SCORE    DD    DSN=T90RAZ1.C465S02.PGM3FILE,UNIT=DISK,
//      VOL=SER=ACA301,DISP=SHR
//PRINTER DD  SYSOUT=*
//TEMPFILE DD  DSN=&&MYTEMP,UNIT=PUB,
//        VOL=SER=ACA301,SPACE=(TRK,(3,3)),DISP=(NEW,PASS,DELETE)
//        

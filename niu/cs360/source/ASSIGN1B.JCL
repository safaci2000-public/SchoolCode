         TITLE 'Example Program for CSCI 360, Programming in Assembler X
               Language'
*********1*****1*******************1**********************************1
*                                                                     *
*                         CSCI 360 Sample Program                     *
*                                                                     *
* Function:  This is a sample assembler program.  It provides         *
*            an example of what will be expected in                   *
*            documentation and programming style.                     *
*                                                                     *
* Input:     None    (Documentation is required if the XREAD pseudo   *
*                     instruction is used)                            *
*                                                                     *
* Output:    None    (Documentation is required if the XPRNT pseudo   *
*                     instruction is used).  However, for this        *
*                     special program, see NOTES below.               *
*                                                                     *
* Entry                                                               *
* Conds:     None (This routine is not called as a subroutine)        *
*                                                                     *
* Exit                                                                *
* Conds:     None (This routine does not return parameters)           *
*                                                                     *
* Program Logic:                                                      *
*                                                                     *
* 1) Calculate the sum of NUMA and NUMB and place it in NUMC          *
* 2) Double the value of NUMB and place the result in NUMD            *
* 3) Triple the value of NUMB and place the result in NUME            *
* 4) Quadruple the value of NUMB and place the result in NUMF         *
* 5) Subtract 11 from NUMA and place result in TEST3                  *
* 6) Display the contents of all registers                            *
* 7) Display the contents of the fullwords starting at NUMA           *
* 8) Force an adnormal end to the program by having it execute an     *
*    invalid operation code.                                          *
*                                                                     *
* Register                                                            *
* Usage:     R5, R6, R7 -- Used as work registers                     *
*            R14 -- Return address (not used here)                    *
*            R15 -- Entry address and base reg for main routine       *
*                                                                     *
* NOTES:     This is a sample program (sequence only, no IF or        *
*            DO constructs).  The program does LOAD, STORE, ADD,      *
*            SUBTRACT, XDUMP (registers only), XDUMP of part of       *
*            program memory (the working storage), and ends with      *
*            an S0C1 abend (and dump) at label INVALID.               *
*                                                                     *
***********************************************************************
         EJECT ,    Note: EJECT statements are not printed in listing
PROGRAM1 CSECT ,                   Define the Control SECTion name
         USING PROGRAM1,15         Base register will be 15
*
* 1) Calculate the sum of NUMA and NUMB and place it in NUMC
*
PRICE    DC    F'329995'
PROPTAX  DC    F'2630'
ERLYDISC DC    F'3300'
LANDSCAP DC    F'13450'
BUYCOST  DC    F'0'
BLDCOST  DC    F'308726'
LNDCOST  DC    F'9558'
PROFIT   DS    F
CONTCOST DS    F
         A     PRICE,BUYCOST
         XDUMP
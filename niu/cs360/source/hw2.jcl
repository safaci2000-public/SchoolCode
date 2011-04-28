DUMP1    CSECT
         USING DUMP1,15
         L     1,ONE
         L     2,TWO
         AR    1,2
         ST    1,THREE
         XDUMP THREE,4
         BCR   B'1111',14
*
ONE      DC    F'64'
TWO      DC    F'32'
EOFFLAG  DC    C'0' A
THREE    DS    CL4' '
         END   DUMP1

/********************************************************************
 * Name:        Samir Faci
 * Class:       CS463
 * Section:     2
 * Prof:        Dr. Chung
 * TA:          Brandon Flynn
**********************************************************************/

#include <math.h>

int main()
{

    // initializes the misc variables used in this program.
    
    int i = pow(2,15)-1, m, n;
    unsigned int j = pow(2,16)-1;
    long k = pow(2,31)-1;

    int bYear, bMonth, bDay;
    float pAge;
    char inBuffer[40] = {"Thomas Jefferson 1743 04 13 57.9"},*p = inBuffer;
    char first[10], last[10];


    system("cls");        // clears the screen
    n = strlen(inBuffer);        // sets n to length of inBuffer

    //read in all the data from the inBuffer string.
    sscanf(inBuffer, "%s %s %d %d %d %f %*c", first, last, &bYear, &bMonth, &bDay, &pAge);



    //output from questions asked in assignment
    printf("%d, %x\n", i, i);
    printf("%d, %x\n", i+1, i+1);
    printf("%u, %x\n", j, j);
    printf("%u, %x\n", j+2, j+2);
    printf("%ld, %x\n", k, k);
    printf("%ld, %x\n", k+3, k+3);
    printf("%x, %c\n", *p, *p);

    for (m=n/2+1; m<=n; m++)
        printf("%c ", *(p+m));
    
    printf("\n");         // prints a carriage return

    for (m=n/2+1; m<=n; m++)
        printf("%x ", *(p+m));

    printf("\n");        // carriage return

    printf("%s %s\n", first, last);
    printf("%d/%d/%d,   %4.1f\n", bYear,bMonth,bDay,pAge);

    return 0;
}

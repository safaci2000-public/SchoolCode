/****************************************************************************
 * Name:			Samir Faci
 * Class:			CSCI 463
 * Prof:			Dr. Chung
 * TA:				Brandon Flynn
 * Assignment:		Assignment #5, part II
 * Due Date:		10/04/2002
 * **************************************************************************/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#define  maxC 5        // maxC = max # of check bits
#define  maxM 26       // maxM = max length of message word
#define  maxW 31       // maxW = max length of code word

// main() module:
// 1. Reads a "message word" as a string 
// 2. Computes  m = # of message bits   = strlen(message word)
//              r = # of check bits     = min { k | 2**k - k >= m+1}
//              n = length of code word = m + r
// 3. Displays the (input) message word, m, r, and n.
//    e.g., if "message word" = 1011, this module displays:
//
//    1) Message Word received   = 1011
//    2) Length of the Message   = 4
//    3) Number of Check Bits    = 3
//    3) Length of the Code word = 7

// checkbits() module:
// 1. Identifies Check Bits: Check Bit 1 is bit 2**0
//                           Check Bit 2 is bit 2**1
//                                    . . .
//                           Check Bit r is bit 2**(r-1)
// 2. Determines p[0], p[2], .. , p[r-1], where
//    p[i] identifies the number of the bits that Check Bit i checks.
// 3. Determines c[0][], c[1][], .. , c[r-1][], where
//    c[i][] identifies the bits that Check Bit i checks. 
//    e.g., if "message word" = 1011, this module computes:
//
//    p[]    = { 4 4 4 }
//    c[0][] = { 1 3 5 7 }
//    c[1][] = { 2 3 6 7 }
//    c[2][] = { 4 5 6 7 }
//
// Note: Bits 0,1,2,3 in "message word" are now Bits 3,5,6,7.
//       And, Check Bits 0,1,2 are Bits 1,2,4.

// buildCodeWord() module:
// 1. Computes Check Bit i so that the sum of the 1's in the c[i][]s = even.
// 2. Builds the Code Word.
//    e.g., if "message word" = 1011, this module displays:
//
//    sum[0] = 2 -> Check Bit 1 = 0
//    sum[1] = 3 -> Check Bit 2 = 1
//    sum[2] = 2 -> Check Bit 4 = 0
//
//    Code Word constructed = 0 1 1 0 0 1 1

void checkbits(int n,int *p,int c[][maxW+1]);
void buildCodeWord(int r,int n,int *p,int c[][maxW+1],char msg[],char word[]);
void printbin(unsigned int num, int);


int main()
{ char msg[maxM],word[maxW];
   int i,j,k,m,n,r,p[maxC+1],c[maxC+1][maxW+1];
   int bin; char* reverse;

  printf("\n**>Enter a message word in bits no longer than %d bits.",maxM);
  printf("\nTo Exit, press 'Ctrl+c' in DOS; 'Ctrl+z' in Windows:->");
  fflush(stdin);
  fflush(stdout);

  while(scanf("%hs",msg) != EOF)
  { printf("\nMessage Word received       = %s",msg);

    m = strlen(msg);
    r = 1;
    while (pow(2,r) - r < m+1) r++;
    n = m + r;

    printf("\nm = Length of the Message   = %d",m);
    printf("\nr = Number of Check Bits    = %d",r);
    printf("\nn = Length of the Code Word = %d",n);

    checkbits(n,p,c);

	reverse = malloc ( 100 );

    printf("\n");
    printf("\n b[][] =  ");

	for (i=1; i <=n; i++)
		printbin(i, n);

    printf("\n   p[] = ");
    for (i=0; i<r; i++) printf("%3d",p[i]);
	
	printf("\n");
    for (i=0; i<r; i++)
    { printf("\nc[%d][] = ",i);
      for (j=0; j<p[i]; j++) printf("%3d",c[i][j]);
    }

    buildCodeWord(r,n,p,c,msg,word);
    printf("\n\nCode Word built = ");
    for (i=1;i<=n;i++) printf("%2c",word[i]);

    printf("\n");
    printf("\n**>Enter a message word in bits no longer than %d bits.",maxM);
    printf("\nTo Exit, press 'Ctrl+c' in DOS; 'Ctrl+z' in Windows:->");
    fflush(stdin);
    fflush(stdout);
//	return 0;
  }
}
/****************************************************************************
 * Prototype:  		void checkbits(int n, int *p, int c[][])
 * 
 * Function:		to check the bits and make sure the input doesn't exceed
 * 					the maximum length, as well as the needed check bits 
 * 					necessery to make sure the data is transfered correctly.
 * 			
 *
 * Parameters:  	int n:		length of final word (r + m)
 * 					int *p:		array of length of c[][]
 * 					c[][]:      array with location of bits to check for each
 * 						        instance.
 *
 * Returns:  		None.
 * **************************************************************************/
void checkbits(int n, int *p, int c[][maxW+1])
{  int i, k, u, v, w;
  char temp[maxM];

  for (i=0; i<maxC; i++) p[i] = 0;

  for (k=1; k<=n; k++)
  { u = k;
    v = 0;
    while (u > 0)
    { if (u == u/2*2) temp[v] = '0';
      else            temp[v] = '1';
      u = u/2;
      v++;
    }

    for (w=0; w<v; w++)
    if (temp[w] == '1')
    { c[w][p[w]] = k;
      p[w]++;
    }
  }
  return;
}

/****************************************************************************
 * Prototype:  		void buildCodeWord(int r,int n, int *p, int c[][], 
 * 				    char *msg, char *word
 * 
 * Function:		sets check bits to 1 or 0 and makes sure the #of 1
 * 					is even at the location specified by c[r]
 * 			
 *
 * Parameters:  	int r:	number of check bits
 * 					int n:  number to total bits
 * 					int *p: array indicating the size of each c[r]
 * 					c[][]:  array with location of bits to check for each
 * 						    instance.
 * 				    char *msg:  original msg
 * 				    char *word: resulting word
 * 			
 *
 * Returns:  		*word
 * **************************************************************************/
void buildCodeWord(int r,int n,int *p,int c[][maxW+1],char *msg,char *word)
{  int i, j, k, sum= 0;
	int loc = 0;

   for (i=1; i<=n; i++) 
	   word[i] = '0';
 
   for (i=1; i<=pow(2,r-1); i=i<<1) 
	   word[i] = '1';

   i=1;
   k=0;
   while (i<=n)
   { while (word[i] == '1') i++;    
     word[i] = msg[k];              
     k++;
     i++;
   }
   printf("\n");


   for (i=0; i < r; i++)
   {
		loc++;		
		loc = pow (2, i);



		sum = 0;
		for (k=0; k < p[i]; k++)
		{

		if (word[c[i][k]] == '1')
				  sum++;
		}
		printf("\nsum[%d] = %d -> Check Bit %d = ", i, sum-1, loc);
		if (sum % 2 != 0)
		{
			word[loc] = '0'; 
			printf("0");
		}
		else
			printf("1");
   }

   return;
}
/****************************************************************************
 * Prototype:  		void printbin(unsigned int num, int i)             
 * 				    
 * Function:		prints the num assigned in reversed binary order
 *
 * Parameters:  	int i:	  max size of largest number to be printed
 * 					int num:  number to be printed
 * 			
 *
 * Returns:  		None, output to screen
 * **************************************************************************/
void printbin(unsigned int num, int i)
{
   int x;  // counter

   if (i == 2)			// number of bits for decimal number
		   i = 2;
   else if (i < 8)
		   i = 3;
   else if (i < 16)
		   i = 4;
   else 
		   i= 4;

   
   int remain[5]= {0} ;	// array storing binary value

   x = i - 1;		// sets it to n-1 size of array

   while (num != 0)			// stores values in array
   {
	   remain[x] = num % 2;
	   num /= 2;
	   x--;
   }

   x = --i;
   while ( x >= 0)		// prints values to screen
   {
		   printf ("%d  ", remain[x]);
		   x--;
   }

   printf("\n          "); 
}
